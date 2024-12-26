import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let products = [
        FavoriteModel(name: "Nike Air Max 270", price: 299.43, oldPrice: 534.33, rating: 4, image: "nike_image"),
        FavoriteModel(name: "FS - Nike Air Max React", price: 249.43, oldPrice: 499.33, rating: 5, image: "nike_image"),
        FavoriteModel(name: "Nike Air Max 270", price: 299.43, oldPrice: 534.33, rating: 4, image: "nike_image"),
        FavoriteModel(name: "FS - Nike Air Max React", price: 249.43, oldPrice: 499.33, rating: 5, image: "nike_image"),
        FavoriteModel(name: "Nike Air Max 270", price: 299.43, oldPrice: 534.33, rating: 4, image: "nike_image"),
        FavoriteModel(name: "FS - Nike Air Max React", price: 249.43, oldPrice: 499.33, rating: 5, image: "nike_image")

    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Настройка collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell

        let product = products[indexPath.row]
        cell.titleLabel.text = product.name
        cell.priceLabel.text = "$\(product.price)"
        cell.productImageView.image = UIImage(named: product.image)
        cell.oldPriceLabel.text = "$\(product.oldPrice)"
        
        // Расчет скидки
        let discount = 100 - (product.price * 100 / product.oldPrice)
        cell.oldPricePercentLabel.text = "\(String(format: "%.0f", discount))% off"

        // Настройка звезд рейтинга
        for (index, view) in cell.starStackView.arrangedSubviews.enumerated() {
            if let imageView = view as? UIImageView {
                imageView.image = UIImage(systemName: index < product.rating ? "star.fill" : "star")
                if index < product.rating {
                    imageView.tintColor = UIColor.systemYellow
                }
            }
            
            
        }

        return cell
    }
}//
//  FavoriteViewController.swift
//  Cobalt
//
//  Created by Akimbek Orazgaliev on 26.12.2024.
//

