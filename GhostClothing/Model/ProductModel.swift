//
//  ProductModel.swift
//  GhostClothing
//
//  Created by NIBM on 2024-03-31.
//

import Foundation

struct ProductModel: Codable, Identifiable{
    
    var id: String
    let productName: String
    let categoryName: String
    let price: Int
    let size: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case productName
        case categoryName
        case price
        case size
        case image = "imageUrl"
                
    }
}
struct APIConstants {
    static let baseURL = "https://ios-api-8vn0.onrender.com/"
        static let allProductsURL = baseURL + "products/get"
        static let productByIDURL = baseURL + "getid/"
}
