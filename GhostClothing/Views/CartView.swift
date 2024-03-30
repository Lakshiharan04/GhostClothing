import SwiftUI

struct CartView: View {
    @ObservedObject var VMCart : CartViewModel = CartViewModel()
   
    
    var body: some View {
        NavigationView {
            VStack {
                StarterView()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(0..<3) { _ in
                            CartProductView()
                        }
                    }
                }
                .padding()
                Button(action: {
                    // Action when the button is tapped
                }) {
                    HStack {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                        
                        Text("Remove all")
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                }.padding()
                
                SummaryView()
                
                VStack {
                    Button(action: {
                        VMCart.isShowingCheckout = true
                    }) {
                        Text("Proceed to checkout").font(.system(size: 18))
                    }
                    .padding()
                    
                    NavigationLink(
                        destination: CheckoutView(),
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
    
    var body: some View {
        VStack(spacing: 10) {
            HStack (spacing:15){
                Image("dress1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                VStack(alignment: .leading) {
                    Text("Women's shirt")
                        .font(.system(size: 16))
                    
                    Text("Olive Green")
                        .font(.system(size: 13))
                    
                    Text("Size || M")
                        .font(.system(size: 12))
                }
                
                Spacer()
                VStack(spacing: 15){
                    StepperView(count: $count)
                    Button(action: {
                        // Action when the button is tapped
                    }) {
                        HStack{
                            Image(systemName: "trash")
                                .foregroundColor(.red)

                        }
                    }
                }
            }
            
            Divider()
        }
        .padding(.horizontal)
    }
}

struct StepperView: View {
    @Binding var count: Int
    
    var body: some View {
        HStack(spacing: 5) {
            Button(action: {
                count = max(count - 1, 1)
            }) {
                Image(systemName: "minus.circle")
            }
            .disabled(count == 1)
            
            Text("\(count)")
            
            Button(action: {
                count = min(count + 1, 5)
            }) {
                Image(systemName: "plus.circle")
            }
            .disabled(count == 5)
        }
        .font(.system(size: 18))
    }
}

struct SummaryView: View {
    @State private var isTextFieldVisible = false
    @State private var promoCode = ""
    @State private var isPromoApplied = false
    @State private var isShowingNewView = false
   

    var body: some View {
        VStack(spacing: 20) {
            
            HStack(alignment: .top, spacing: 5 ){
                
                Text("Summary").font(.system(size: 18)).bold().underline()
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Total amount").font(.system(size: 16))
                    Text("1950.00 LKR").font(.system(size: 18)).bold()
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

