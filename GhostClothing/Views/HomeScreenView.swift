//
//  HomeScreenView.swift
//  GhostClothing
//
//  Created by NIBMPC04PC02 on 2024-03-17.
//

import SwiftUI

struct HomeScreenView: View {
    @State private var text: String = ""

    
    var body: some View {
        VStack {
            VStack(spacing:30){
                HStack(spacing:225){
                    Text("GClothing").bold().font(.headline).foregroundStyle(.blue)
                    Button(action: {
                        // Action when the button is tapped
                      
                        
                    }) {
                        Image(systemName: "cart")
                            .foregroundColor(.blue).bold()
                  
                    }
               
                }
               
                HStack {
                    TextField("Search", text: $text)
                        .padding(8)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    Button(action: {
                        self.text = ""
                    }) {
                        /* Image(systemName: "xmark.circle.fill")
                         .foregroundColor(.gray)
                         .padding(.trailing, 8)*/
                    }
                }
                ScrollView(){
                HeaderView()
                CategoryView()
                    
                    
                    VStack(spacing:15){
                        
                        HStack(spacing:225){
                            Text("Just Arrived").bold().font(.headline).foregroundStyle(.blue)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.blue).bold()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing:10) {
                                ForEach(0..<10) { index in
                                    CardView(imageName: "dress\(index + 1)")
                                }
                            }
                            .padding()
                        }
                        
                        
                    }.padding()
                    
                VStack(spacing:15){
                        
                        HStack(spacing:180){
                            Text("Feature Products").bold().font(.headline).foregroundStyle(.blue)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.blue).bold()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing:10) {
                                ForEach(0..<10) { index in
                                    CardView(imageName: "dress\(index + 1)")
                                }
                            }
                            .padding()
                        }
                        
                        
                    }.padding()
                    
                }
            }
            
            Spacer()
        }
    }
}

struct HeaderView: View {
    var body: some View {
                Image("Header02")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding()
        
    
    }
}


struct CardView: View {
    var imageName: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).frame(height:200).frame(width: 150)
                .foregroundColor(.white)
                .padding(30)
                .shadow(radius: 2).overlay{
                    
                    VStack{
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 140)
                        
                        Text("Product details")
                            .font(.system(size:14)).fontWeight(.light)
                            .padding(.bottom,7)
                        
                        HStack(spacing:15) {
                            Button(action: {
                                // Action when the button is tapped
                            }) {
                                Image(systemName: "eye.fill")
                                
                                
                            }
                            Button(action: {
                                // Action when the button is tapped
                            }) {
                                
                                Image(systemName: "cart")
                                
                            }
                            
                        }
                    }
                }
        }
        
        .frame(width: 150, height: 150)
        .padding()
    }
    
}

struct CategoryView: View {
    var body: some View {
        VStack {
            HStack{
            RoundedRectangle(cornerRadius: 10).frame(height:50).frame(width: 50)
                .foregroundColor(.white)
                .padding()
                .shadow(radius: 3).overlay{
                    Image("pumaico")
                    
                }
                RoundedRectangle(cornerRadius: 10).frame(height:50).frame(width: 50)
                    .foregroundColor(.white)
                    .padding()
                    .shadow(radius: 3).overlay{
                        Image("nikeico")
                        
                    }
                RoundedRectangle(cornerRadius: 10).frame(height:50).frame(width: 50)
                    .foregroundColor(.white)
                    .padding()
                    .shadow(radius: 3).overlay{
                        Image("leviesico")
                        
                    }
                
                }
            HStack{
            RoundedRectangle(cornerRadius: 10).frame(height:50).frame(width: 50)
                .foregroundColor(.white)
                .padding()
                .shadow(radius: 3).overlay{
                    Image("pumaico")
                    
                }
                RoundedRectangle(cornerRadius: 10).frame(height:50).frame(width: 50)
                    .foregroundColor(.white)
                    .padding()
                    .shadow(radius: 3).overlay{
                        Image("pumaico")
                        
                    }
                RoundedRectangle(cornerRadius: 10).frame(height:50).frame(width: 50)
                    .foregroundColor(.white)
                    .padding()
                    .shadow(radius: 3).overlay{
                        Image("pumaico")
                        
                    }
                
                }
            
            
            
                }
    }
}

#Preview {
    HomeScreenView()
}
