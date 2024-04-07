//
//  CheckoutView.swift
//  GhostClothing
//
//  Created by NIBMPC04PC02 on 2024-03-23.
//

import SwiftUI

struct CheckoutView: View {
    @State private var isPaymentSuccessful = false
    let totalAmount: Int
    @State private var isShowingPaymentAlert = false
    
    var body: some View {
        VStack(spacing:25){
            Text("Checkout").font(.system(size: 25)).bold()
            ScrollView{
                VStack{
                    RoundedRectangle(cornerRadius: 10).frame(height:250).frame(width: 350)
                        .foregroundColor(.white)
                        .padding()
                        .shadow(radius: 2).overlay{
                            
                            HStack(alignment: .top, spacing: 120){
                                
                                Text("Summary").font(.system(size: 18)).bold()
                                
                                // Spacer()
                                
                                VStack(alignment: .trailing, spacing: 5) {
                                    Text("Total amount").font(.system(size: 16))
                                    Text("\(totalAmount) LKR").font(.system(size: 16)).bold().strikethrough()
                                    Text("Coupon applied").font(.system(size: 11)).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    Text("+Delivery charages").font(.system(size: 11))
                                    Text("\(totalAmount) LKR").font(.system(size: 20)).bold().foregroundColor(.blue)
                                    
                                    Text("Including tax").font(.system(size: 10)).foregroundColor(.gray)
                                    
                                }
                            }
                        }
                    
                    AddCardView()
                    
                    SavedCardView()
                    
                    Addressbar()
                    
                    VStack{
                        Button(action: {
                            isShowingPaymentAlert = true
                            UserDefaults.standard.removeObject(forKey: "cartItems")
                        }) {
                            
                            Text( "Make Payment")
                                .foregroundColor(.white)
                                .padding(20)
                                .background(.blue)
                                .cornerRadius(5)
                            
                        }
                    }
                    
                    Spacer()
                    
                    
                }
            }
        }
        .navigationBarHidden(true)
        .padding()
        .alert(isPresented: $isShowingPaymentAlert) {
            Alert(title: Text("Payment Successful"), message: Text("Your payment has been successful."), primaryButton: .default(Text("OK")) {
                // Restart the app to the Home Screen without a splash screen
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = UIHostingController(rootView: ContentView())
                    window.makeKeyAndVisible()
                }
            }, secondaryButton: .cancel())
        }
        
        Spacer()
    } 
}

struct AddCardView: View {
    @State private var isAddingNewCard = false
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var cvv = ""

    var body: some View {
        VStack {
            if isAddingNewCard {
                TextField("User Name", text: $cardNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                
                TextField("Card Number", text: $cardNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    


                TextField("Expiry Date", text: $expiryDate)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    

                TextField("CVV", text: $cvv)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                   
            }

            Button(action: {
                isAddingNewCard.toggle()
            }) {
                Image(systemName: "creditcard")
                    .foregroundColor(.blue).bold()
                Text(isAddingNewCard ? "Hide Card Details" : "Add New Card")
                    .foregroundColor(.blue)
                    
            }
        }
        .padding()
    }
}

struct SavedCardView: View {
        @State private var selectedCard: String?

        let creditCards = ["John Doe - **** **** **** 3456", "Alice Smith - **** **** **** 7654", "Bob Johnson - **** **** **** 6913"]

        var body: some View {
            VStack {
                if let selectedCard = selectedCard {
                    Text("Selected Card: \(selectedCard)")
                        .padding()
                }

                Button(action: {
                    // Show radio buttons
                    selectedCard = nil // Reset selection when button is pressed
                }) {
                    Image(systemName: "creditcard")
                        .foregroundColor(.blue).bold()
                    Text("Select Credit Card")
                        .foregroundColor(.blue)
                       
                }

                if selectedCard == nil {
                    Divider().padding()

                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(creditCards, id: \.self) { cardInfo in
                            let displayCardInfo = cardInfo
                            Toggle(isOn: Binding<Bool>(
                                get: { selectedCard == cardInfo },
                                set: { isSelected in
                                    if isSelected {
                                        selectedCard = cardInfo
                                    } else {
                                        selectedCard = nil
                                    }
                                })
                            ) {
                                Text(displayCardInfo)
                            }
                            .toggleStyle(RadioButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
    }

    struct RadioButtonStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                configuration.label
                Spacer()
                Image(systemName: configuration.isOn ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(configuration.isOn ? .blue : .gray)
                    .onTapGesture { configuration.isOn.toggle() }
            }
        }
    }


struct Addressbar: View {
    @State private var addressLine = ""
    var body: some View {
        HStack{
            VStack{
                TextField("Delivery address", text: $addressLine)
                    .padding(.horizontal)
                    .frame(height: 55)
               
                Divider().background(Color.blue)
                
                    
            }.frame(width: 300)
            Image(systemName: "pencil")
                .foregroundColor(.blue).bold()
        }.padding()
    }
}

#Preview {
    CheckoutView(totalAmount:0)
}
