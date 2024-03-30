//
//  ProductsView.swift
//  GhostClothing
//
//  Created by NIBMPC04PC06 on 2024-03-30.
//

import SwiftUI

struct ProductsView: View {
    @State private var search: String = ""
    @State private var isEditing = false
    @State private var selectedButton: String?
    @State private var showProductDetails = false
    let categoryName: String

    
    struct Product {
            let name: String
            let imageName: String
            let price: Double
        }

        let products: [Product] = [
            Product(name: "Rayon Printed Shirt",  imageName: "odelshirt", price: 2500.00),
            Product(name: "Casual T-shirt", imageName: "levistshirt",  price: 2000.00)
        ]
    var body: some View {
        VStack{
            
                Text("All Products").font(.system(size: 22))
                Text("Category: \(categoryName)")
       
            
            ZStack(alignment: .trailing) {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 0.5)
                            .frame(width: 350, height: 50)
                            .padding(.horizontal, 48)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .offset(x:60) // Adjust the padding as needed
                            
                            TextField("Search", text: $search, onEditingChanged: { editing in
                                isEditing = editing
                            })
                            .padding(.horizontal, 56)
                            .padding(.trailing, 48) 
                            // Adjust the padding as needed
                            
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

            
            ScrollView(.horizontal) {
                       HStack(spacing: 20) {
                           ForEach(["T-Shirts", "Shirts", "Over Sized Tees", "Jeans", "Track pants", "Shorts"], id: \.self) { title in
                               Button(action: {
                                   selectedButton = title
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
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                    ForEach(products, id: \.name) { product in
                        Button {
                            showProductDetails = true
                        } label: {
                            VStack {
                                Image(product.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 250)
                                    .cornerRadius(8)
                                Text(product.name)
                                    .padding(.bottom, 4)
                                    .background(Color.white)
                                Text("Rs.\(product.price, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .cornerRadius(8)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $showProductDetails) {
                            DetailedProductView()
                        }
                    }
                     }
                   }

            
            
            Spacer()
        }//end of top vstack
        .navigationBarBackButtonHidden(false)
    }

}

#Preview {
    ProductsView(categoryName: "") 
}
