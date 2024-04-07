import SwiftUI
import URLImage

struct CartView: View {
    @ObservedObject var VMCart : CartViewModel = CartViewModel()
    @State private var totalAmount: Int = 0
    @State private var isShowingEmptyCartAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                StarterView()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(VMCart.cartItems, id: \.id) { cartItem in
                            CartProductView(cartItem: cartItem, cartViewModel: VMCart)
                        }

                    }
                }
                .padding()
             
                Divider()
                
                SummaryView(VMCart: VMCart)
                
                VStack {
                    Button(action: {
                        if VMCart.cartItems.isEmpty {
                                                   isShowingEmptyCartAlert = true // Show empty cart alert
                                               } else {
                                                   VMCart.isShowingCheckout = true
                                               }
                    }) {
                        Text("Proceed to checkout").font(.system(size: 18))
                    }
                    .padding()
                    .alert(isPresented: $isShowingEmptyCartAlert) {
                                            Alert(title: Text("Empty Cart"), message: Text("Your cart is empty."), dismissButton: .default(Text("OK")))
                                        }
                    
                    NavigationLink(
                        destination: CheckoutView(totalAmount:VMCart.calculateTotalAmount() ),
                        isActive: $VMCart.isShowingCheckout,
                        label: {
                            EmptyView()
                        }
                    )
                    .hidden()
                }
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .navigationTitle("Back")
            .onAppear{
                VMCart.loadCartState()
            }
        }
    }
}

struct StarterView: View {
    var body: some View {
        HStack {
            Text("My Cart")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
     
        }
    }
}

struct CartProductView: View {
    @State private var count = 1
    @ObservedObject var VMCart: CartViewModel
    @State private var quantity: Int
    var cartItem: CartViewModel.CartItem

    
    init(cartItem: CartViewModel.CartItem, cartViewModel: CartViewModel) {
        self.cartItem = cartItem
        self.VMCart = cartViewModel
        self._quantity = State(initialValue: cartViewModel.cartQuantities[cartItem.product.id + cartItem.selectedSize] ?? 1)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack (spacing:15){
                URLImage(URL(string: cartItem.product.image)!) { image in
                    image
                        .resizable()
                        .scaledToFit()
                }
                .frame(width: 100, height: 100)
                
                VStack(alignment: .leading) {
                    Text(cartItem.product.productName)
                        .font(.system(size: 16))
                    Text("Q: \(quantity)")
                        .font(.system(size: 13))
                    
                    Text(cartItem.product.categoryName)
                        .font(.system(size: 13))
                    
                    Text("Rs.\(cartItem.adjustedPrice)")
                        .font(.system(size: 12))
                }
                
                Spacer()
                VStack(spacing: 15) {
                    Stepper("", value: $quantity, in: 1...Int.max) {_ in
                                            Text("Qty: \(quantity)")
                                            updateCartQuantity()
                                        }
                    Button(action: {
                        // Action when the button is tapped
                        removeFromCart()
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
            
            Divider()
        }
        .padding(.horizontal)
    }
    
    private func updateCartQuantity() {
            VMCart.updateQuantity(productID: cartItem.product.id, selectedSize: cartItem.selectedSize, quantity: quantity)
        }
    private func removeFromCart() {
            VMCart.removeFromCart(productID: cartItem.product.id, selectedSize: cartItem.selectedSize)
        }
    
}


struct SummaryView: View {
    @State private var isTextFieldVisible = false
    @State private var promoCode = ""
    @State private var isPromoApplied = false
    @State private var isShowingNewView = false
    @ObservedObject var VMCart: CartViewModel
    
    /*private var totalAmount: Int {
           VMCart.cartItems.reduce(0) { total, cartItem in
               total + (cartItem.adjustedPrice * (VMCart.cartQuantities[cartItem.product.id + cartItem.selectedSize] ?? 1))
           }
       }*/


    var body: some View {
        VStack(spacing: 20) {
            
            HStack(alignment: .top, spacing: 5 ){
                
                Text("Summary").font(.system(size: 18)).bold().underline()
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Total amount").font(.system(size: 16))
                    
                    
                    Text("\(VMCart.calculateTotalAmount()) LKR").font(.system(size: 18)).bold()
                    Text("+Delivery charages").font(.system(size: 11))
                    Text("Including tax").font(.system(size: 10)).foregroundColor(.gray)
                    
                }
                
                
            }
            Divider()
            
            
            HStack(spacing:55) {
                
                Button(action: {
                    isTextFieldVisible.toggle()
                }) {
                    HStack {
                        Image(systemName: "percent").foregroundColor(.green).font(.system(size: 15))
                        Text("Add promo code").foregroundColor(.green).font(.system(size: 15))
                    }
                    
                }
            }
            
            if isTextFieldVisible {
                HStack {
                    TextField("Enter promo code", text: $promoCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .onChange(of: promoCode) { _ in
                            isPromoApplied = false // Reset flag when text changes
                        }
                    
                    Button(action: {
                        isPromoApplied = true
                        
                    }) {
                        Image(systemName: "checkmark.circle")
                        Text("Check").font(.system(size: 12))
                        
                    }
                    
                }
                
                
            }
            
            if isPromoApplied {
                
                Text("Promo code applied: \(promoCode)")
                    .foregroundColor(.green)
            }
            
        }
        
       
    }
 
}



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            CartView()
                .navigationBarTitle("", displayMode: .inline)
        }
    }
}

