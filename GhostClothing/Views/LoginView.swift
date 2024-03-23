//
//  LoginView.swift
//  GhostClothing
//
//  Created by NIBMPC04PC02 on 2024-03-16.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var VMLogin : LoginViewModel = LoginViewModel()
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color("Blue"),Color.blue.opacity(0.6)],startPoint: .bottomTrailing,endPoint: .topLeading).ignoresSafeArea()
            
            VStack{
                Text("Ghost Clothing").bold().font(.system(size: 32)).foregroundStyle(.white)
                Spacer()
                RoundedRectangle(cornerRadius: 14).foregroundColor(.white).frame(height: 400).padding(30)
                    .overlay{
                        VStack(spacing:15) {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 0.2)
                                .frame(height:50).padding(.horizontal,48)
                                .overlay{
                                    HStack{
                                        Image(systemName: "person")
                                            .foregroundColor(.gray)
                                        TextField("Username",text:$VMLogin.username)
                                    }.padding(.horizontal,56)
                                }
                            
                            
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 0.2)
                                .frame(height:50).padding(.horizontal,48)
                                .overlay{
                                    HStack{
                                        Image(systemName: "lock")
                                            .foregroundColor(.gray)
                                        SecureField("Password",text:$VMLogin.password)
                                    }.padding(.horizontal,56)
                                    
                                }
                         
                                    Button(action:{
                                        VMLogin
                                        .verifyLogin()}
                                           ,label: {
                                        RoundedRectangle(cornerRadius: 25).frame(height:50).frame(width: 250)
                                            .padding(.horizontal,47)
                                            .padding(.top)
                                            .foregroundStyle(LinearGradient(colors:[Color.blue,Color.teal.opacity(0.7)],startPoint: .bottom,endPoint: .top)
                                            )}).overlay{
                                                Text("Login").bold()
                                                    .foregroundStyle(.white)
                                                    .padding(.top)
                                            }
                
                        }
                        
                    }
                Spacer()
                if VMLogin.showError {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 100).padding(40)
                        .foregroundColor(.white)
                        .shadow(radius : 10)
                        .overlay {
                            Text(VMLogin.errorMessage)
                                .bold().foregroundStyle(.red)
                                .padding(48)
                        }
                }
                
               NavigationLink("", isActive: $VMLogin.success)
               {Text("Hello lakshi")}
            }
        }
    }
}

#Preview {
    LoginView()
}
