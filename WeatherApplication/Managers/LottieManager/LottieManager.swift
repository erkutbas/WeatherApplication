//
//  LottieManager.swift
//  TravelAround_iOS
//
//  Created by Erkut Bas on 16.05.2021.
//

import Foundation
import Combine
import UIKit

class LottieManager: LottieManagerProtocol {
    
    private var subscription = Set<AnyCancellable>()
    
    private lazy var lottiViewController = LottieViewController(name: "loading_animation", loopMode: .loop)

    @AtomicValue private var animationArray: [Int] = [Int]()
    private lazy var workItem = DispatchWorkItem(block: process)
    private lazy var process : () -> Void = { [weak self] in
        self?.stopAnimation()
    }
    
    private var task1 = PassthroughSubject<Bool, Never>()
    private var task2 = PassthroughSubject<Bool, Never>()
    
    init() {
        taskManager()
    }
    
    func onPreExecute() {
        print("onPreExecute fired")
        if animationArray.count == 0 {
            fireAnimation()
        }
    }
    
    func onPostExecute() {
        print("onPostExecute fired")
        if animationArray.count == 1 {
            task1.send(true)
        }
    }
    
    private func taskManager() {
        Publishers.CombineLatest(task1, task2)
            .sink { resultTask1, resultTask2 in
                guard resultTask2, resultTask1 else { return }
                DispatchQueue.main.async(execute: self.workItem)
            }
            .store(in: &subscription)
    }
    
    private func fireAnimation() {
        self.animationArray.append(1)
        DispatchQueue.main.async {
            guard let topMostViewController = UIApplication.topViewController() else { return }
            self.lottiViewController.modalTransitionStyle = .crossDissolve
            self.lottiViewController.modalPresentationStyle = .overFullScreen
            topMostViewController.present(self.lottiViewController, animated: true) { [weak self] in
                print("LOTTIE FIRED")
                self?.task2.send(true)
            }
        }
        
    }
    
    private func stopAnimation() {
        DispatchQueue.main.async {
            self.lottiViewController.animationOperationKiller { [weak self] in
                print("LOTTIE STOPPED")
                self?.animationArray.removeAll()
            }
        }
        
    }
    
}
