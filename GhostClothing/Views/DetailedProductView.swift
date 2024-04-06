//
//  DetailedProductView.swift
//  GhostClothing
//
//  Created by NIBMPC04PC06 on 2024-03-30.
//

import SwiftUI
import URLImage

struct DetailedProductView: View {
    @State private var selectedButton: String?
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
            if let products = vm.products.first(where: {$0.id == id}) {
                URLImage(URL(string: products.image)!){ image in
                    image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 400) // Set the desired width and height for the larger image
                    .cornerRadius(10)
                    .padding()
                }

                VStack(alignment: .leading) {
                    Text(products.productName)
                        .font(.title)
                        .padding(.leading)
                        .background(Color.white)
                    
                    Text(products.categoryName)
                        .font(.subheadline)
                        .padding(.leading)
                        .foregroundColor(.gray)
                }//.offset(x:-50)
                
                // Ensure the HStack is visible and properly aligned
                HStack(spacing: 20) {
                    ForEach(["S", "M", "L", "XL", "XXL"], id: \.self) { title in
                        Button(action: {
                            selectedButton = title
                        }) {
                            Text(title)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .foregroundColor(selectedButton == title ? .white : .black)
                                .background(selectedButton == title ? Color.black : Color.white)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                        }
                    }
                }
                .padding(.bottom,55) // Add padding to ensure space between the HStack and the "Add Cart" button
            }
        }.frame(width: 350, height: 500) // Set the VStack to have a fixed width and height
        .padding()

            
        Button(action: {
            
        }, label: {
            Image(systemName: "heart").bold().font(.system(size: 25)).foregroundColor(.pink)
            Text("Add to Favourite").foregroundColor(.pink)
        }).padding()
            
            Button(action: {
                if let product = vm.products.first(where: {$0.id == id}) {
                    VMCart.addToCart(product)
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
            }.padding()
        NavigationLink(destination: CartView(), isActive: $isActive) {
                       EmptyView()
        }.hidden()
            .navigationBarBackButtonHidden(false)

            
            Spacer()

        }//end of top vstack
    }


/*struct DetailedProductView: View {
    let product: ProductModel
    
    var body: some View {
        // Display product details here
        Text(product.productName)
    }
}
*/


#Preview {
    DetailedProductView(id: "", vm: ProductViewModel(), VMCart: CartViewModel())
}


/*import SwiftUI

struct DetailedProductView: View {
    let product: ProductModel
    
    var body: some View {
        // Display product details here
        VStack {
            Text(product.productName)
            // Other product details
        }
    }
}*/
