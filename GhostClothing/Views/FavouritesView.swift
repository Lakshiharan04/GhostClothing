import SwiftUI

struct FavouritesView: View {
    @State private var showProductDetails = false // Change variable name to start with lowercase
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HeadLineView()
                    .padding(.horizontal)
                
                VStack(spacing: 10) {
                    ForEach(0..<3) { _ in
                        Button(action: {
                            showProductDetails = true // Change variable name to start with lowercase
                        }) {
                            FavProductView()
                                .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $showProductDetails) { // Change variable name to start with lowercase
                            DetailedProductView()
                        }
                    }
                }
            }
        }
    }
}

struct HeadLineView: View {
    var body: some View {
        HStack {
            Image(systemName: "heart").bold().font(.system(size: 25)).foregroundColor(.blue)
            Text("Favourite Items")
                .font(.system(size: 25))
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
        }
        .padding(.vertical)
    }
}

struct FavProductView: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                Image("dress1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Women's shirt")
                        .font(.system(size: 16)).foregroundColor(.black)
                    
                    Text("Olive Green")
                        .font(.system(size: 13)).foregroundColor(.black)
                    
                    Text("Size || M")
                        .font(.system(size: 12)).foregroundColor(.black)
                    
                    Button(action: {
                        // Action to remove product
                    }) {
                        Text("Remove").foregroundColor(.red)
                    }
                    
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            Divider().background(Color.blue)
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}

