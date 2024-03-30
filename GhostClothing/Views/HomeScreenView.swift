import SwiftUI

struct HomeScreenView: View {
    @State private var text: String = ""
    @State private var showProductDetails = false
    @State private var isActive = false
    

    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 30) {
                    HStack(spacing: 225) {
                        Text("GClothing").bold().font(.system(size: 20)).foregroundColor(.blue)
                        Button(action: {
                            // Action when the button is tapped
                            exit(0)
                        }) {
                            Image(systemName: "door.left.hand.open")
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
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                        .padding(.trailing)
                    }
                    
                    
                    
                    ScrollView {
                        
                        HeaderView(images: ["Header01", "Header02"])
                        
                        CategoriesView()
                        
                        VStack(spacing: 15) {
                            HStack(spacing: 225) {
                                Text("Just Arrived").bold().font(.headline).foregroundColor(.blue)
                                Button(action: {
                                    isActive = true
                                    
                                }, label: {
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.blue).bold()
                                })
                            }
                            NavigationLink(destination: ProductsView(categoryName: "") , isActive: $isActive) {
                                EmptyView()
                            }
                            .hidden()
                            .navigationBarBackButtonHidden(true)
                        }
                        
        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(0..<10) { index in
                                    CardView(imageName: "dress\(index + 1)")
                                }
                            }
                            .padding()
                        }
                        .padding()
                        VStack(spacing: 15) {
                            HStack(spacing: 180) {
                                Text("Feature Products").bold().font(.headline).foregroundColor(.blue)
                                Button(action: {}, label: {
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.blue).bold()
                                })
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(0..<10) { index in
                                        CardView(imageName: "dress\(index + 1)")
                                    }
                                }
                                .padding()
                            }
                        }
                       
                    }
                    
                }
                
            }
        }
    }
}

struct HeaderView: View {
    let images: [String]
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect() // Change the time interval as needed

    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(0..<images.count, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .onReceive(timer) { _ in
                currentIndex = (currentIndex + 1) % images.count
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


struct CardView: View {
    var imageName: String
    @State private var showProductDetails = false

    var body: some View {
        ZStack {
            Button(action: {
                showProductDetails = true
            }) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 200)
                    .frame(width: 150)
                    .foregroundColor(.white)
                    .padding(30)
                    .shadow(radius: 2)
                    .overlay {
                        VStack {
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 140)
                            VStack(alignment: .leading) {
                                Text("Women's shirt")
                                    .font(.system(size: 16))
                                Text("Olive Green")
                                    .font(.system(size: 13))
                                Text("LKR 2500.00")
                                    .font(.system(size: 12))
                            }
                        }
                    }
            }
            .buttonStyle(PlainButtonStyle())
            .sheet(isPresented: $showProductDetails) {
                DetailedProductView()
            }
        }
        .frame(width: 150, height: 150)
        .padding()
    }
}
struct CategoryButton: View {
    let categoryName: String
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Text(categoryName)
                .foregroundColor(.blue)
                .padding()
                .font(.system(size: 12))
                .border(Color.blue)
                .background(.white)
                .cornerRadius(2)
        }
    }
}



    struct CategoriesView: View {
        let categories = ["T-Shirts", "Shirts", "Over Sized Tees", "Jeans", "Track pants", "Shorts"]
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

        var body: some View {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(categories, id: \.self) { category in
                        CategoryButton(categoryName: category) {
                            // Navigate to all products view with category name
                            // You can replace NavigationLink with your own navigation method
                            NavigationLink(destination: ProductsView(categoryName: category)) {
                                Text(category)
                            }
                        }
                    }
                }
                .padding()
            }
        }

    }



struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}

