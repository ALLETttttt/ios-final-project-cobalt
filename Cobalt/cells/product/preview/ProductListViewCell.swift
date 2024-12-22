//
//  ProductListViewCell.swift
//  Cobalt
//
//  Created by Бакдаулет on 21.12.2024.
//

import UIKit

class ProductListViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleProductLabel: UILabel!
    @IBOutlet weak var imageProductView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Add a gray border to the cell
        self.layer.borderColor = UIColor.gray.cgColor // Set border color
        self.layer.borderWidth = 1.0 // Set border width
        self.layer.cornerRadius = 8.0 // Set corner radius for rounded edges
        self.layer.masksToBounds = true // Clip content within rounded edges
        self.layer.opacity = 0.9
        // Initialization code
    }
    
}
