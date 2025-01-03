//
//  FavoriteCell.swift
//  Cobalt
//
//  Created by Akimbek Orazgaliev on 20.12.2024.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var oldPricePercentLabel: UILabel!
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.gray.cgColor // Set border color
        self.layer.borderWidth = 1.0 // Set border width
        self.layer.cornerRadius = 8.0 // Set corner radius for rounded edges
        self.layer.masksToBounds = true // Clip content within rounded edges
        self.layer.opacity = 0.9
    }
}
