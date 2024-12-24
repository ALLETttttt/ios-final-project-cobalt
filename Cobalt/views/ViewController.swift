//
//  ViewController.swift
//  Cobalt
//
//  Created by Бакдаулет on 15.12.2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var categoryListCollectionView: UICollectionView!
    @IBOutlet weak var productListCollectionView: UICollectionView!
    @IBOutlet weak var previewImage: UIImageView!
    
    let categoryIconImageList = ["Electronics", "Jewellery", "Men`s clothing", "Women`s clothing"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupPreviewImage()
    }
    
    func setupPreviewImage() {
        previewImage.layer.cornerRadius = 10.0
        previewImage.layer.masksToBounds = true
    }
    
    func setupCollectionView() {
        productListCollectionView.delegate = self
        productListCollectionView.dataSource = self
        
        categoryListCollectionView.delegate = self
        categoryListCollectionView.dataSource = self
        
        let productLayout = UICollectionViewFlowLayout()
        productLayout.scrollDirection = .horizontal
        productLayout.itemSize = CGSize(width: 150, height: 150)
        productLayout.minimumLineSpacing = 10
        productLayout.minimumInteritemSpacing = 10
        productListCollectionView.collectionViewLayout = productLayout
        
        let categoryLayout = UICollectionViewFlowLayout()
        categoryLayout.scrollDirection = .horizontal
        categoryLayout.itemSize = CGSize(width: 100, height: 100)
        categoryLayout.minimumLineSpacing = 50
        categoryLayout.minimumInteritemSpacing = 50
        categoryListCollectionView.collectionViewLayout = categoryLayout
        
        productListCollectionView.register(UINib(nibName: "ProductListViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductListViewCell")
        categoryListCollectionView.register(UINib(nibName: "CategoryListViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryListViewCell")
    }
    
}

extension ViewController:
    UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productListCollectionView {
            return 50
        } else if collectionView == categoryListCollectionView {
            return categoryIconImageList.count
        }
        return 777
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        if collectionView == productListCollectionView {
            let productListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListViewCell", for: indexPath) as! ProductListViewCell
            
            productListCell.titleProductLabel.text = "Test title"
            productListCell.imageProductView.image = UIImage(named: "ferrari")
            
            return productListCell
        }
        else if collectionView == categoryListCollectionView {
            let categoryListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryListViewCell", for: indexPath) as! CategoryListViewCell
            categoryListCell.iconImage.image = UIImage(named: categoryIconImageList[indexPath.row])
            categoryListCell.iconName.text = categoryIconImageList[indexPath.row]
            
            return categoryListCell
        }
            
        return UICollectionViewCell()
    }
    
    
}