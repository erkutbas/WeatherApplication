//
//  CharacterListViewController.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 30.10.2021.
//

import UIKit

class CharacterListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var characterListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterItemCollectionViewCell else { fatalError("Please Provide A Reusable Cell") }
        
        cell.characterItemImage.image = UIImage(named: "sample")
        cell.characterLabelName.text = "Item : \(indexPath.row + 1)"
        cell.characterLabelName.textColor = .black
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (UIScreen.main.bounds.width - 50) / 3
        return CGSize(width: width, height: 300)
        
    }
    
}
