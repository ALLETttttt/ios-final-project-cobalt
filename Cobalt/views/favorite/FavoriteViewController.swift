//
//  FavoriteViewController.swift
//  Cobalt
//
//  Created by Akimbek Orazgaliev on 26.12.2024.
//

import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var products: [ProductModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Настройка collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        loadData()
    }
    
    private var selectedProduct: ProductModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData() {
        NetworkManager.shared.fetchLikedProducts { [weak self] products, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error loading products:", error)
                    // Show error alert to user
                    return
                }
                
                guard let products = products else {
                    print("No products received")
                    return
                }
                
                print("Received \(products.count) products")
                self?.products = products
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else {
            return
        }
        detailVC.configure(with: selectedProduct)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell

        let product = products[indexPath.row]
        cell.titleLabel.text = product.name
        cell.priceLabel.text = "$\(product.price)"
        if let imageUrl = URL(string: product.image) {
            cell.productImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder"))
        } else {
            cell.productImageView.image = UIImage(named: "ferrari")
        }
        cell.oldPriceLabel.text = "$\(product.oldPrice)"
        
        // Расчет скидки
        let discount = 100 - (product.price * 100 / product.oldPrice)
        cell.oldPricePercentLabel.text = "\(String(format: "%.0f", discount))% off"

        // Настройка звезд рейтинга
        for (index, view) in cell.starStackView.arrangedSubviews.enumerated() {
            if let imageView = view as? UIImageView {
                imageView.image = UIImage(systemName: index < Int(product.rating) ? "star.fill" : "star")
                if index < Int(product.rating) {
                    imageView.tintColor = UIColor.systemYellow
                }
            }
            
            
        }

        return cell
    }
}

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProduct = products[indexPath.row]
        performSegue(withIdentifier: "detailedProductFavourite", sender: nil)
    }
}
