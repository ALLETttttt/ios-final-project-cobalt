//
//  OfferViewController.swift
//  Cobalt
//
//  Created by Akimbek Orazgaliev on 26.12.2024.
//

import UIKit

class OfferViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties
    private var offers: [OfferModel] = [
        OfferModel(hours: "08", minutes: "34", seconds: "52", descriptionText: "Limited Offer!", imageName: "example_image1",percent: "70%",countdown: 3600),
        OfferModel(hours: "12", minutes: "15", seconds: "10", descriptionText: "Special Deal!", imageName: "example_image1",percent: "30%", countdown: 7200),
        OfferModel(hours: "02", minutes: "44", seconds: "30", descriptionText: "Hurry Up!", imageName: "example_image1",percent: "20%",countdown: 14400)
    ]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    // MARK: - Setup
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

    // MARK: - Collection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCell", for: indexPath) as? OfferCell else {
            return UICollectionViewCell()
        }
        let offer = offers[indexPath.item]
        cell.configure(with: offer,countdown: offer.countdown)
        return cell
    }

    // MARK: - Collection View Delegate Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 150)
    }
}
