//
//  CartView.swift
//  GhostClothing
//
//  Created by NIBMPC04PC02 on 2024-03-17.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        VStack{
            HStack(spacing:110){
                Text("My Cart").bold().font(.title).foregroundStyle(.blue).frame(alignment: .leading)
                
                HStack{
                    
                    Button(action: {
                        // Action when the button is tapped
                    }) {
                        
                        Image(systemName: "xmark.bin.fill").foregroundColor(.red)
                        Text("Remove all").bold().font(.system(size: 15)).foregroundStyle(.red).frame(alignment: .leading)
                        
                        
                    }
                }
            }
           
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing:2) {
                            ForEach(0..<5) { index in
                                
                                RoundedRectangle(cornerRadius: 10).frame(height:120).frame(width: 350)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .shadow(radius: 5).overlay{
                                        
                                        CartProductView()
                                        
                                    }
                            }
                    }
                       
                    }.frame(height: 400).padding()
                        
                SummaryView()
               
            
        }
        Spacer()
  
        }
        
    }


struct CartProductView: View {
    @State private var count = 1
    var body: some View {
        
        VStack {
            VStack {
                HStack(spacing:10){
                    Image("dress1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 120)
                    VStack(alignment: .leading){
                        Text("Women's shirt").font(.system(size: 18))
                        Text("Olive Green").font(.system(size: 13))
                        Text("Size || M").font(.system(size: 13))
                    }
                    VStack(spacing:10){
                        HStack (alignment: .center, spacing:12){
                            Button(action: {
                                // Decrease count by 1
                                if count > 1 {
                                    count -= 2
                                }
                            }) {
                                Image(systemName: "minus.circle")
                                    .font(.system(size: 15))
                            }.disabled(count == 1)
                            
                            Text("\(count)") .font(.system(size: 16))
                            
                            Button(action: {
                                // Increase count by 1
                                count += 1
                            }) {
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 15))
                            }.disabled(count == 5)
                            
                        }
                        Button(action: {
                            // Action when the button is tapped
                        }) {
                            
                            Image(systemName: "xmark.bin.fill").foregroundColor(.red).font(.system(size: 15))
                            Text("Remove").bold().font(.system(size: 12)).foregroundStyle(.red)
                        }
                    }
                    
                    
                }
                
            }.frame(width: 320)
            
            
            
            
            
        }
        }
 
}

struct SummaryView:View {
    @State private var isTextFieldVisible = false
    var body: some View {
        VStack{
            
            RoundedRectangle(cornerRadius: 10).frame(height:120).frame(width: 350)
                .foregroundColor(.white)
                .padding(10)
                .shadow(radius: 5).overlay{
                    
                    VStack{
                        Text("Add promo code").font(.system(size: 15)).onTapGesture {
                            isTextFieldVisible.toggle()
                        }
                        
                        if isTextFieldVisible {
                            TextField("Enter code here", text: .constant("")).font(.system(size: 15))
                                .textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: 200)
                                
                        }
                    }
             
                }
        }
        
        
        
        
    }
    
    
}
#Preview {
    CartView()
}
