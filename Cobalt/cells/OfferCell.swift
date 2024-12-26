import UIKit

class OfferCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var percent: UILabel!
    
    private var timer: Timer?
    private var secondsRemaining: Int = 0

    // MARK: - Configure Method
    func configure(with model: OfferModel, countdown: Int) {
        hoursLabel.text = model.hours
        minutesLabel.text = model.minutes
        secondsLabel.text = model.seconds
        descriptionLabel.text = model.descriptionText
        customImageView.image = UIImage(named: model.imageName)
        percent.text = model.percent
        
        self.secondsRemaining = countdown

        startTimer()

    }
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        guard secondsRemaining > 0 else {
            timer?.invalidate()
            timer = nil
            return
        }
        
        secondsRemaining -= 1
        updateLabels()
    }
    
    private func updateLabels() {
        let hours = secondsRemaining / 3600
        let minutes = (secondsRemaining % 3600) / 60
        let seconds = secondsRemaining % 60
        
        hoursLabel.text = String(format: "%02d", hours)
        minutesLabel.text = String(format: "%02d", minutes)
        secondsLabel.text = String(format: "%02d", seconds)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timer?.invalidate()
        timer = nil
    }
}

