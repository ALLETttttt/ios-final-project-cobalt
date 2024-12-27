//
//  ViewController.swift
//  Cobalt
//
//  Created by Бакдаулет on 15.12.2024.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    
    @IBOutlet weak var categoryListCollectionView: UICollectionView!
    @IBOutlet weak var productListCollectionView: UICollectionView!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var seeMoreLabel: UILabel!
    
    private var selectedProduct: ProductModel?
    
    let categoryIconImageList = ["Electronics", "Jewellery", "Men`s clothing", "Women`s clothing"]
    var products: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadData()
        setupPreviewImage()
        setupSeeMoreLabel()
    }
    
    func setupSeeMoreLabel() {
        seeMoreLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(seeMoreTapped))
        seeMoreLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func seeMoreTapped() {
        performSegue(withIdentifier: "ExploreViewController", sender: nil)
    }
    
    func setupPreviewImage() {
        previewImage.layer.cornerRadius = 10.0
        previewImage.layer.masksToBounds = true
    }
    
    func loadData() {
        NetworkManager.shared.fetchProducts { [weak self] products, error in
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
                self?.productListCollectionView.reloadData()
            }
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else {
            return
        }
        detailVC.configure(with: selectedProduct)
    }
    
}

extension ViewController:
    UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productListCollectionView {
            print("Number of products:", products.count)
            return products.count
        } else if collectionView == categoryListCollectionView {
            return categoryIconImageList.count
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        if collectionView == productListCollectionView {
            let productListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListViewCell", for: indexPath) as! ProductListViewCell
            
            let product = products[indexPath.item]
            productListCell.titleProductLabel.text = product.name
            
            if let imageUrl = URL(string: product.image) {
                productListCell.imageProductView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder"))
            } else {
                productListCell.imageProductView.image = UIImage(named: "ferrari")
            }
            
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


extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProduct = products[indexPath.row]
        performSegue(withIdentifier: "detailedProductPreview", sender: nil)
    }
}
