//
//  HomeView.swift
//  GhostClothing
//
//  Created by NIBMPC04PC02 on 2024-03-16.
//

import SwiftUI

struct HomeView: View {
    @State private var isTabViewHidden = false
    var body: some View {
         VStack {
             if !isTabViewHidden {
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
                 .navigationBarBackButtonHidden(true)
             }
         }
     }
 }
            

struct FirstView: View {
    var body: some View {
        HomeScreenView(isTabViewHidden: .constant(false))
    }
}

struct SecondView: View {
    var body: some View {
        ProfileView()
    }
}

struct ThirdView: View {
    var body: some View {
      FavouritesView()
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


