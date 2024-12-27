//
//  Favorite.swift
//  Cobalt
//
//  Created by Akimbek Orazgaliev on 20.12.2024.
//

struct FavoriteModel {
    let name: String
    let price: Double
    let oldPrice: Double
    let rating: Int
    let image: String
}

struct OfferModel: Decodable {
    let hours: String
    let minutes: String
    let seconds: String
    let descriptionText: String // Новое описание
    let imageName: String       // Новое имя изображения
    let percent: String
    let countdown: Int
    
    enum CodingKeys: String, CodingKey {
        case hours               // Matches backend's "id"
        case minutes            // Matches backend's "name"
        case seconds           // Matches backend's "price"
        case descriptionText = "description_text"  // Matches backend's "old_price"
        case imageName = "image_name"           // Matches backend's "image"
        case percent        // Matches backend's "discount"
        case countdown          // Matches backend's "rating"
    }
}
