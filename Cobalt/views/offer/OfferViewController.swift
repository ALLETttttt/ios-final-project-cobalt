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
    
    var offers: [OfferModel] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadData()
    }

    // MARK: - Setup
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func loadData() {
        NetworkManager.shared.fetchOffers { [weak self] offers, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error loading products:", error)
                    // Show error alert to user
                    return
                }
                
                guard let offers = offers else {
                    print("No products received")
                    return
                }
                
                print("Received \(offers.count) products")
                self?.offers = offers
                self?.collectionView.reloadData()
            }
        }
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
        cell.configure(with: offer, countdown: offer.countdown)
        return cell
    }

    // MARK: - Collection View Delegate Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 150)
    }
}
