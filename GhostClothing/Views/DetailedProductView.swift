import SwiftUI
import URLImage

struct DetailedProductView: View {
    @State private var selectedSize: String = "S"
    @StateObject private var vm: ProductViewModel = ProductViewModel()
    @StateObject private var VMCart: CartViewModel = CartViewModel()
    @State private var isActive = false
    let id: String
    
    init(id: String, vm: ProductViewModel, VMCart: CartViewModel){
        self.id = id
        _vm = StateObject(wrappedValue: vm)
        _VMCart = StateObject(wrappedValue: VMCart)
        vm.getProductByID(for: id)
    }
    
    var body: some View {
        VStack {
            if let product = vm.products.first(where: {$0.id == id}) {
                URLImage(URL(string: product.image)!){ image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 400)
                        .cornerRadius(10)
                        .padding()
                }.frame(width: 350, height: 400)

                VStack(alignment: .leading) {
                    Text(product.productName)
                        .font(.title)
                        .padding(.leading)
                        .background(Color.white)
                    
                    Text(product.categoryName)
                        .font(.subheadline)
                        .padding(.leading)
                        .foregroundColor(.gray)
                        Text("Price: \(adjustedPrice) LKR")
                        .font(.system(size: 11)).bold().padding(.leading)
                }
                
                HStack(spacing: 20) {
                    ForEach(["S", "M", "L", "XL", "XXL"], id: \.self) { size in
                        Button(action: {
                            selectedSize = size
                        }) {
                            Text(size)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .foregroundColor(selectedSize == size ? .white : .blue)
                                .background(selectedSize == size ? Color.blue : Color.white)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.blue, lineWidth: 1)
                                )
                        }
                    }
                }
                .padding(.bottom,55)
                
                //
            }
        }
        .frame(width: 350, height: 500)
        .padding()
        
      /*  Button(action: {
            // Add to Favourite logic here
        }) {
            Image(systemName: "heart").bold().font(.system(size: 25)).foregroundColor(.pink)
            Text("Add to Favourite").foregroundColor(.pink)
        }.padding(.leading)*/
        
        Button(action: {
            if let product = vm.products.first(where: { $0.id == id }) {
                              let adjustedPrice = calculateAdjustedPrice(for: product, selectedSize: selectedSize)
                              VMCart.addToCart(product, selectedSize: selectedSize, adjustedPrice: adjustedPrice)
                              isActive = true
            }
        }) {
            Text("Add Cart")
                .padding()
                .frame(width: 330)
                .background(Color.blue)
                .foregroundColor(.white)
                .font(.headline)
                .cornerRadius(10)
        }.padding(.leading)
        
        NavigationLink(destination: CartView(), isActive: $isActive) {
            EmptyView()
        }.hidden()
        .navigationBarBackButtonHidden(false)
        
        Spacer()
    }
    
    var adjustedPrice: Int {
        let basePrice = vm.products.first(where: {$0.id == id})?.price ?? 0
        switch selectedSize {
        case "S":
            return basePrice
        case "M":
            return basePrice + 600
        case "L":
            return basePrice + 200
        case "XL":
            return basePrice + 300
        case "XXL":
            return basePrice + 400
        default:
            return basePrice
        }
    }
    
    private func calculateAdjustedPrice(for product: ProductModel, selectedSize: String) -> Int {
        let basePrice = product.price
        switch selectedSize {
        case "S":
            return basePrice
        case "M":
            return basePrice + 600
        case "L":
            return basePrice + 200
        case "XL":
            return basePrice + 300
        case "XXL":
            return basePrice + 400
        default:
            return basePrice
        }
    }
}

struct DetailedProductView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedProductView(id: "exampleProductID", vm: ProductViewModel(), VMCart: CartViewModel())
    }
}
