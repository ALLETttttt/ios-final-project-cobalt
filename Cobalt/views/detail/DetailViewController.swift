import UIKit
import Kingfisher // Ensure you import Kingfisher for image loading

class DetailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var descriptionn: UILabel!
    @IBOutlet weak var likee: UIButton!

    private var model: ProductModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    func configure(with model: ProductModel?) {
        self.model = model
    }

    private func updateUI() {
        guard let model = model else {
            print("Model is nil")
            return
        }

        if let imageUrl = URL(string: model.image) {
            image.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder"))
        } else {
            image.image = UIImage(named: "ferrari")
        }

        name.text = model.name
//        rating.text = String(model.rating)
        price.text = "$" + String(model.price)
        oldPrice.text = String(model.oldPrice)
        discount.text = String(model.discount) + "% OFF"
        descriptionn.text = String(model.description)
    }
}
