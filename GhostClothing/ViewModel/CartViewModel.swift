/*import Foundation
import SwiftUI

class CartViewModel: ObservableObject {
    @Published var isShowingCheckout = false
    @Published var cartItems: [ProductModel] = []
    @Published var cartQuantities: [String: Int] = [:] // Dictionary to store product IDs and their quantities

    func addToCart(_ product: ProductModel) {
          if let index = cartItems.firstIndex(where: { $0.id == product.id }) {
              // Product exists, update quantity
              cartQuantities[product.id] = (cartQuantities[product.id] ?? 0) + 1
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
}*/

import Foundation
import SwiftUI

class CartViewModel: ObservableObject {
    @Published var isShowingCheckout = false
    @Published var cartItems: [CartItem] = []
    @Published var cartQuantities: [String: Int] = [:]
    
    struct CartItem: Identifiable, Codable {
            var id: String
            var product: ProductModel
            var selectedSize: String
            var adjustedPrice: Int
        }
    
    func calculateTotalAmount() -> Int {
            return cartItems.reduce(0) { total, cartItem in
                total + Int(cartItem.adjustedPrice) * Int(cartQuantities[cartItem.product.id + cartItem.selectedSize] ?? 1)
            }
        }
    
    func addToCart(_ product: ProductModel, selectedSize: String, adjustedPrice: Int) {
           let cartItem = CartItem(id: product.id, product: product, selectedSize: selectedSize, adjustedPrice: adjustedPrice)
           
           if cartItems.contains(where: { $0.id == product.id && $0.selectedSize == selectedSize }) {
               // Product with the same size exists, update quantity
               cartQuantities[product.id + selectedSize] = (cartQuantities[product.id + selectedSize] ?? 0) + 1
           } else {
               // Product with the same size does not exist, add to cart
               cartItems.append(cartItem)
               cartQuantities[product.id + selectedSize] = 1
           }
           saveCartState()
       }

    func saveCartState() {
        let encoder = PropertyListEncoder()
        if let encodedItems = try? encoder.encode(cartItems),
           let encodedQuantities = try? encoder.encode(cartQuantities) {
            UserDefaults.standard.set(encodedItems, forKey: "cartItems")
            UserDefaults.standard.set(encodedQuantities, forKey: "cartQuantities")
        }
    }

    func loadCartState() {
          if let savedItemsData = UserDefaults.standard.data(forKey: "cartItems"),
             let savedQuantitiesData = UserDefaults.standard.data(forKey: "cartQuantities") {
              let decoder = PropertyListDecoder()
              if let loadedItems = try? decoder.decode([CartItem].self, from: savedItemsData),
                 let loadedQuantities = try? decoder.decode([String: Int].self, from: savedQuantitiesData) {
                  cartItems = loadedItems
                  cartQuantities = loadedQuantities
              }
          }
      }

    func updateQuantity(productID: String, selectedSize: String, quantity: Int) {
        cartQuantities[productID] = quantity
        saveCartState()
    }

    func removeFromCart(productID: String, selectedSize: String) {
        cartItems.removeAll(where: { $0.id == productID })
        cartQuantities[productID] = nil
        saveCartState()
    }
}
