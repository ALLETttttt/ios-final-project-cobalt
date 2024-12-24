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
}
