//
//  AllProductsListViewCell.swift
//  Cobalt
//
//  Created by Бакдаулет on 22.12.2024.
//

import UIKit
import Kingfisher

class AllProductsListViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productLike: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.gray.cgColor // Set border color
        self.layer.borderWidth = 1.0 // Set border width
        self.layer.cornerRadius = 8.0 // Set corner radius for rounded edges
        self.layer.masksToBounds = true // Clip content within rounded edges
        self.layer.opacity = 0.9
    }
    
    func configure(with product: ProductModel) {
        productNameLabel.text = product.name
        if let imageUrl = URL(string: product.image) {
            productImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder"))
        } else {
            productImage.image = UIImage(named: "ferrari")
        }
        productPriceLabel.text = "55$"
    }

}
