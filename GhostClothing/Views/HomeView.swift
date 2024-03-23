//
//  HomeView.swift
//  GhostClothing
//
//  Created by NIBMPC04PC02 on 2024-03-16.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
       
            
        
            TabView {
                FirstView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                SecondView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Account")
                    }
                
                
                ThirdView()
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favourits")
                    }
                
                FourthView()
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Cart")
                    }
                
            }
            .tabViewStyle(DefaultTabViewStyle())
            .edgesIgnoringSafeArea(.all)
        
            
            
        }
    
            
    }
struct FirstView: View {
    var body: some View {
        HomeScreenView()
    }
}

struct SecondView: View {
    var body: some View {
        ProfileView()
    }
}

struct ThirdView: View {
    var body: some View {
      Text("favourits")
    }
}

struct FourthView: View {
    var body: some View {
    //Text("Third view")
    CartView()
       
    }
}

#Preview {
    HomeView()
}


