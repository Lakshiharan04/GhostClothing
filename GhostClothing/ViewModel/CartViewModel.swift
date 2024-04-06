//
//  CartViewModel.swift
//  GhostClothing
//
//  Created by NIBMPC04PC02 on 2024-03-23.
//

import Foundation
import SwiftUI


class CartViewModel :ObservableObject{
    @Published var isShowingCheckout = false
    @Published var cartItems: [ProductModel] = []
       @Published var cartQuantities: [String: Int] = [:] // Dictionary to store product IDs and their quantities

    func addToCart(_ product: ProductModel) {
        if let index = cartItems.firstIndex(where: { $0.id == product.id }) {
            // Product exists, update quantity
            if let quantity = cartQuantities[product.id] {
                cartQuantities[product.id] = quantity + 1
            } else {
                cartQuantities[product.id] = 1
            }
        } else {
            // Product does not exist, add to cart
            cartItems.append(product)
            cartQuantities[product.id] = 1
        }
        saveCartState()
    }


       // Method to save cart state to UserDefaults
       func saveCartState() {
           // Convert cartItems and cartQuantities to Data and save
           let encoder = JSONEncoder()
           if let encodedItems = try? encoder.encode(cartItems),
              let encodedQuantities = try? encoder.encode(cartQuantities) {
               UserDefaults.standard.set(encodedItems, forKey: "cartItems")
               UserDefaults.standard.set(encodedQuantities, forKey: "cartQuantities")
           }
       }

       // Method to load cart state from UserDefaults
    func loadCartState() {
        // Load Data and decode to cartItems and cartQuantities
        if let savedItemsData = UserDefaults.standard.data(forKey: "cartItems"),
           let savedQuantitiesData = UserDefaults.standard.data(forKey: "cartQuantities") {
            let decoder = JSONDecoder()
            if let loadedItems = try? decoder.decode([ProductModel].self, from: savedItemsData),
               let loadedQuantities = try? decoder.decode([String: Int].self, from: savedQuantitiesData) {
                cartItems = loadedItems
                cartQuantities = loadedQuantities
            }
        }
    }
    func updateQuantity(productID: String, quantity: Int) {
        // Update the quantity in cartQuantities
        cartQuantities[productID] = quantity
        saveCartState()
  }
    func removeFromCart(productID: String) {
        cartItems.removeAll(where: { $0.id == productID })
        cartQuantities[productID] = nil
        saveCartState()
    }
    
    
    
    
    
}


