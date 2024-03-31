import SwiftUI
import URLImage

struct ProductsView: View {
    @State private var search: String = ""
    @State private var isEditing = false
    @State private var selectedButton: String? = "All"
    @State private var showProductDetails = false
    @StateObject var productViewModel = ProductViewModel()
    @State public var id: String
    let categories = ["All", "T-shirt", "Shirts", "Over sized tee", "Jeans", "Track pants", "Shorts"]
    let categoryName: String
    
    var filteredProducts: [ProductModel] {
        var filtered = productViewModel.products
        let selectedCategory = selectedButton
        if  selectedCategory != "All" {
            filtered = filtered.filter { $0.categoryName == selectedCategory }
        }
        
        if !search.isEmpty {
            filtered = filtered.filter { $0.productName.lowercased().contains(search.lowercased()) }
        }
        if !search.isEmpty {
            filtered = filtered.filter { $0.categoryName.lowercased().contains(search.lowercased()) }
        }
        
        return filtered
    }
    
   
    
    var body: some View {
        VStack {
            Text("All Products").font(.system(size: 22))
            Text("Category: \(selectedButton ?? "All")")
            
            // Search Bar
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 0.5)
                    .frame(width: 350, height: 50)
                    .padding(.horizontal, 48).foregroundColor(.blue)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.blue)
                        .offset(x:60) // Adjust the padding as needed
                    
                    TextField("Search", text: $search, onEditingChanged: { editing in
                        isEditing = editing
                    })
                    .padding(.horizontal, 56)
                    .padding(.trailing, 48)
                    
                    if isEditing && !search.isEmpty {
                        Button(action: {
                            search = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.blue)
                        }
                        .offset(x:-70) // Adjust the padding as needed
                    }
                }
            }
            
            // Category Buttons
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(categories, id: \.self) { title in
                        Button(action: {
                            selectedButton = title
                            // Implement category filtering logic here
                        }) {
                            Text(title)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .foregroundColor(selectedButton == title ? .white : .black)
                                .background(selectedButton == title ? Color.blue : Color.white)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.blue, lineWidth: 0.5)
                                )
                        }
                    }
                }.padding()
            }
            
            // Product Grid
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                    ForEach(filteredProducts) { product in
                        Button(action: {
                            // Show product details
                            showProductDetails = true
                        }) {
                            NavigationLink(destination: DetailedProductView(id: product.id)){
                            VStack {
                                // Product Image (Placeholder)
                                URLImage(URL(string: product.image)!) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 250)
                                        .cornerRadius(8)
                                }
                                
                                Text(product.productName)
                                    .padding(.bottom, 4)
                                    .background(Color.white)
                                Text(product.categoryName)
                                    .padding(.bottom, 4)
                                    .background(Color.white)
                                
                                Text("Rs.\(product.price)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .cornerRadius(8)
                        }
                        }
                        .buttonStyle(PlainButtonStyle())
                        //.sheet(isPresented: $showProductDetails) {
                            //DetailedProductView(productID: product.id)
                            // You need to create DetailedProductView and pass the selected product
                        //}
                    }
                }
            }
        }
        .onAppear {
            // Fetch all products when the view appears
            productViewModel.getAllProducts()
        }
        .navigationBarBackButtonHidden(false)
    }
}

#Preview {
    ProductsView(id: "", categoryName: "")
        .environmentObject(ProductViewModel())
}

