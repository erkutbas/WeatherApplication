//
//  CharacterListViewController.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 30.10.2021.
//

import UIKit
import DefaultNetworkOperationPackage

class CharacterListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private lazy var accessProviderManager = AccessProviderManager.shared
    private var characterData = [CharacterData]()
    
    @IBOutlet weak var characterListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
    }
    
    func getData() {
        do {
            guard let urlRequest = try? CharacterListServiceProvider(request: getCharacterListRequest()).returnUrlRequest() else { return }
            fireApiCall(with: urlRequest) { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .failure(let error):
                    print("error : \(error)")
                case .success(let data):
                    self.characterData.removeAll()
                    self.characterData = data.data.results
                    DispatchQueue.main.async {
                        UIView.transition(with: self.characterListCollectionView, duration: 0.8, options: .transitionCrossDissolve) {
                            self.characterListCollectionView.reloadData()
                        }
                    }
                }
            }
        }
        
    }
    
    private func fireApiCall(with request: URLRequest, with completion: @escaping (Result<CharacterDataResponse, ErrorResponse>) -> Void) {
        
        ApiManagerBuilder.build().executeRequest(urlRequest: request, completion: completion)
        
    }
    
    private func getCharacterListRequest() -> CharacterDataRequest {
        return CharacterDataRequest(
            offset: 0,
            limit: 100,
            ts: accessProviderManager.returnUniqueData(),
            apikey: accessProviderManager.returnApiKey(),
            hash: accessProviderManager.returnHash())
    }
    
    private func createImageData(by value: Thumbnail) -> String {
        return "\(value.path)/portrait_incredible.\(value.thumbnailExtension)"
    }
    
    private func fireDetail(with index: Int) {
        let item = characterData[index]
        let viewController = ItemDetailViewBuilder.build(with: ItemDetailViewRequest(id: item.id))
        present(viewController, animated: true, completion: nil)
    }
    
    // MARK: - CollectionView Protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterItemCollectionViewCell else { fatalError("Please Provide A Reusable Cell") }
        
//        cell.characterItemImage.image = UIImage(named: "sample")
        cell.characterItemImage.setImage(with: createImageData(by: characterData[indexPath.row].thumbnail))
        cell.characterLabelName.text = characterData[indexPath.row].name
        cell.characterLabelName.textColor = .black
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (UIScreen.main.bounds.width - 50) / 3
        return CGSize(width: width, height: 300)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isUserInteractionEnabled = false
        cell?.startTappedAnimation(with: { [weak self] finish in
            guard let self = self else { return }
            if finish {
                cell?.isUserInteractionEnabled = true
                self.fireDetail(with: indexPath.row)
            }
        })
    }
    
}

// MARK: - ImageLoadingProcess
extension UIImageView {
 
    func setImage(with value: String) {
        
        image = nil
        
        if let cachedImage = ImageCacheManager.returnImagesFromCache(key: value) {
            image = cachedImage
            return
        }
        
        guard let url = URL(string: value) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("error : \(String(describing: error))")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.handleTaskResponse(data: data, componentData: value)
            }
            
        }.resume()
        
    }
    
    private func handleTaskResponse(data: Data?, componentData: String) {
        guard let data = data, let image = UIImage(data: data) else { return }
        
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) { [weak self] in
            self?.image = image
        }

        ImageCacheManager.setImagesToCache(object: image, key: componentData)
        
    }
    
}
