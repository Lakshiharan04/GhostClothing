import SwiftUI
import URLImage

struct HomeScreenView: View {
    @State private var text: String = ""
    @State private var showProductDetails = false
    @State private var isActive = false
    @ObservedObject var viewModel = ProductViewModel()
    @Binding var isTabViewHidden: Bool
    

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
                   
                    
                    
                    ScrollView {
                        
                        HeaderView(images: ["Slider01", "Slider02","Slider03"])
                        
                            //CategoriesView()
                            IntroductionView()
                        
                        VStack(spacing: 15) {
                            HStack(spacing: 25) {
                                Text("Feature Products!").bold().font(.headline).foregroundColor(.black)
                               
                            }
                            NavigationLink(destination: ProductsView(id:"",categoryName: "") , isActive: $isActive) {
                                EmptyView()
                            }
                            .hidden()
                            .navigationBarBackButtonHidden(true)
                        }
                        
        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                                         HStack(spacing: 10) {
                                             ForEach(viewModel.getRandomProducts(count: 10), id: \.id) { product in
                                                 CardView(product: product)
                                             }
                                         }
                                         .padding()
                                     }
                                     .padding()
     
                    }
                    
                }
                
            }
        }
    }
}

struct HeaderView: View {
    let images: [String]
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect() 
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    ForEach(0..<images.count, id: \.self) { index in
                        Image(images[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width)
                            .tag(index)
                    }
                }
                .frame(width: UIScreen.main.bounds.width * CGFloat(images.count), alignment: .leading)
            }
            .onReceive(timer) { _ in
                withAnimation {
                    let nextIndex = (currentIndex + 1) % images.count
                    currentIndex = nextIndex
                }
            }
        }.padding()
    }
}

struct IntroductionView: View {
    var body: some View {
        VStack{
            Text("Welcome to Ghost clothing").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.leading).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Text("Discover the latest trends, shop stylish outfits, and elevate your wardrobe effortlessly. Enjoy a seamless shopping experience tailored just for you. Let's redefine your style, one tap at a time")
                .font(.system(size: 13))
                .padding().foregroundColor(.gray)
            
            
            
        }
    }
}

struct CardView: View {
    var product: ProductModel
    @State private var showProductDetails = false

    var body: some View {
        NavigationLink(destination: DetailedProductView(id: product.id, vm: ProductViewModel(), VMCart: CartViewModel())){
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 200)
                    .frame(width: 160)
                    .foregroundColor(.white)
                    .padding(30)
                    .shadow(radius: 2)
                    .overlay {
                        VStack {
                            URLImage(URL(string: product.image)!) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 140)
                            }
                            VStack(alignment: .leading) {
                                Text(product.productName) // Assuming ProductModel has a name property
                                    .font(.system(size: 12))
                                    .frame(width: 80, height: 10)
                                Text(product.categoryName) // Assuming ProductModel has a description property
                                    .font(.system(size: 13))
                                Text("\(product.price) LKR") // Assuming ProductModel has a price property
                                    .font(.system(size: 12))
                            }
                        }
                    }
            }
            .frame(width: 150, height: 150)
            .padding()
        }
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
        @State private var isActive = false
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
                            NavigationLink(destination: ProductsView(id: "", categoryName: category), isActive: $isActive) {
                                EmptyView()
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
        HomeScreenView(isTabViewHidden: .constant(false))
           
    }
}

