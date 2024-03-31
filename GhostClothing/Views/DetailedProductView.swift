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
    @State private var vm: ProductViewModel = ProductViewModel()
    let id: String
    
    init(id: String){
        self.id = id
        self.vm = ProductViewModel()
        vm.getProductByID(for: id)
    }
    var body: some View {
        VStack{
            if let products = vm.products.first(where: {$0.id == id}){
                URLImage(URL(string: products.image)!){ image in
                        image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 500) // Set the desired width and height for the larger image
                        .cornerRadius(10)
                        .padding()
                }
      
                VStack(alignment: .leading) {
                    Text(products.productName)
                        .font(.title)
                        .padding(.bottom, 4)
                        .background(Color.white)
                    
                    Text(products.categoryName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }.offset(x:-50)
                
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
            }
        }
            
                Button(action: {
                    
                }, label: {
                    Image(systemName: "heart").bold().font(.system(size: 25)).foregroundColor(.pink)
                    Text("Add to Favourite").foregroundColor(.pink)
                }).padding()
            
            Button(action: {
                
            }) {
                Text("Add Cart")
                    .padding()
                    .frame(width: 330)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
            }
            
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
    DetailedProductView(id: "")
        
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
