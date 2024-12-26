import Foundation

struct ProductModel: Decodable {
    let id: Int
    let name: String
    let price: Float
    let oldPrice: Float?
    let image: String
    let discount: Float
    let rating: Float
    let description: String
    var isLiked: Bool
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case id               // Matches backend's "id"
        case name            // Matches backend's "name"
        case price           // Matches backend's "price"
        case oldPrice = "old_price"  // Matches backend's "old_price"
        case image           // Matches backend's "image"
        case discount        // Matches backend's "discount"
        case rating          // Matches backend's "rating"
        case description     // Matches backend's "description"
        case isLiked = "is_liked"  // Matches backend's "is_liked"
        case category        // Matches backend's "category"
    }
}

struct Category: Decodable {
    let id: Int
    let name: String
}

// NetworkManager.swift
import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "http://127.0.0.1:8000/api"  // Replace with your Django backend URL
    
    func fetchProducts(completion: @escaping ([ProductModel]?, Error?) -> Void) {
        AF.request("\(baseURL)/products/", method: .get)
            .responseData { response in
                if let data = response.data, let json = String(data: data, encoding: .utf8) {
                    print("Received JSON:", json)
                }
            }
            .responseDecodable(of: [ProductModel].self) { response in
                switch response.result {
                case .success(let products):
                    completion(products, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    
    func fetchCategories(completion: @escaping ([Category]?, Error?) -> Void) {
        AF.request("\(baseURL)/categories/", method: .get)
            .responseDecodable(of: [Category].self) { response in
                switch response.result {
                case .success(let categories):
                    completion(categories, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    
    func toggleLike(productId: Int, completion: @escaping (Bool?, Error?) -> Void) {
        AF.request("\(baseURL)/products/\(productId)/like/", method: .post)
            .responseDecodable(of: [String: Bool].self) { response in
                switch response.result {
                case .success(let result):
                    completion(result["is_liked"], nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
}
