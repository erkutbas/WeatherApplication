//
//  SampleView.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 17.10.2021.
//

import UIKit

class Sample: UIView {
    
    private lazy var shadowContainer: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.backgroundColor = .red
        temp.layer.shadowColor = UIColor.black.cgColor
        temp.layer.shadowOffset = CGSize(width: 0, height: 2)
        temp.layer.shadowRadius = 4
        temp.layer.shadowOpacity = 0.4
        temp.layer.cornerRadius = 6
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTakasi()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addTakasi() {
        addSubview(shadowContainer)
        
        NSLayoutConstraint.activate([
        
            shadowContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            shadowContainer.topAnchor.constraint(equalTo: topAnchor),
            shadowContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ])
        
    }
    
}

class XData: Equatable {
    
    let name: String
    let surName: String
    
    init(name: String, surName: String) {
        self.name = name
        self.surName = surName
    }
    
    static func == (lhs: XData, rhs: XData) -> Bool {
        return lhs.name == rhs.name &&
        lhs.surName == rhs.surName
    }
    
    
}

class Test {
    
    func toDo() {
        
        let x = 5
        let y = 10
        
        if x == y {
            
        }
        
        let a = XData(name: "Erkut", surName: "Bas")
        let c = XData(name: "Erkut", surName: "Bas")
        let b = XData(name: "Dogukaan", surName: "Kilicarslan")
        
        if a == c {
            
        }
        
        
    }
    
}
