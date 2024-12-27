import UIKit
import Kingfisher


class AllProductsListViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productLike: UIButton!

    private var product: ProductModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.gray.cgColor // Set border color
        self.layer.borderWidth = 1.0 // Set border width
        self.layer.cornerRadius = 8.0 // Set corner radius for rounded edges
        self.layer.masksToBounds = true // Clip content within rounded edges
        self.layer.opacity = 0.9
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        guard let product = product else { return }
                
        // Disable button during network request
        productLike.isEnabled = false
                
        NetworkManager.shared.toggleLike(productId: product.id) { [weak self] isLiked, error in
            DispatchQueue.main.async {
                // Re-enable button
                self?.productLike.isEnabled = true
                
                if let error = error {
                    print("Error toggling like: \(error)")
                    return
                }
                
                if let isLiked = isLiked {
                    self?.updateLikeButtonState(isLiked: isLiked)
                    self?.product?.isLiked = isLiked
                    
                }
            }
        }
    }
    
    private func updateLikeButtonState(isLiked: Bool) {
        let image = isLiked ? UIImage(named: "heart") : UIImage(named: "empty_heart")
        productLike.setImage(image, for: .normal)
        productLike.tag = isLiked ? 1 : 0
    }
    
    func configure(with product: ProductModel) {
        self.product = product
        productNameLabel.text = product.name
        
        if let imageUrl = URL(string: product.image) {
            productImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder"))
        } else {
            productImage.image = UIImage(named: "ferrari")
        }
        
        productPriceLabel.text = String(format: "$%.2f", product.price)
        
        updateLikeButtonState(isLiked: product.isLiked)
    }
}
