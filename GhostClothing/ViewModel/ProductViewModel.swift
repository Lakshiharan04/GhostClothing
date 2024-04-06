import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    @Published var selectedProduct: ProductModel?
    @Published var id: String?
    
    init() {
        self.getAllProducts()
    }
    
    func getAllProducts() {
        guard let url = URL(string: APIConstants.allProductsURL) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let products = try JSONDecoder().decode([ProductModel].self, from: data)
                DispatchQueue.main.async {
                    self.products = products
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func getRandomProducts(count: Int) -> [ProductModel] {
          var shuffledProducts = products.shuffled()
          return Array(shuffledProducts.prefix(count))
      }
    
    func getProductByID(for id: String) {
        guard let url = URL(string: APIConstants.productByIDURL + id) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let product = try JSONDecoder().decode(ProductModel.self, from: data)
                DispatchQueue.main.async {
                    self.selectedProduct = product
                    print("hit\(id)")
                }
            } catch {
                print("boom Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
  
}

