//
//  ExploreViewController.swift
//  Cobalt
//
//  Created by Бакдаулет on 22.12.2024.
//

import UIKit

struct Product {
    let name: String
    let imageName: String
}

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var productListCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var products: [Product] = [
        Product(name: "Apple", imageName: "ferrari"),
        Product(name: "Banana", imageName: "ferrari"),
        Product(name: "Cherry", imageName: "ferrari"),
        Product(name: "Date", imageName: "ferrari"),
        Product(name: "Eggfruit", imageName: "ferrari")
    ]
    
    var filteredProducts: [Product] = []
    var isSearchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProductListCollectionView()
    }
    
    func setupProductListCollectionView() {
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        searchBar.delegate = self
        
        productListCollectionView.register(UINib(nibName: "AllProductsListViewCell", bundle: nil), forCellWithReuseIdentifier: "AllProductsListViewCell")
    }
    
}

extension ExploreViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearchActive ? filteredProducts.count: products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let allProductsListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllProductsListViewCell", for: indexPath) as? AllProductsListViewCell else {return UICollectionViewCell()}
        
        let product = isSearchActive ? filteredProducts[indexPath.row] : products[indexPath.row]
        
        allProductsListCell.configure(with: product)
        
        return allProductsListCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) / 2
        return CGSize(width: width, height: width + 30)
    }
}

extension ExploreViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearchActive = false
            filteredProducts = products
        } else {
            isSearchActive = true
            filteredProducts = products.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        productListCollectionView.reloadData()
    }
}
