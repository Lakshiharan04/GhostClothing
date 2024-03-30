//
//  SignupView.swift
//  GhostClothing
//
//  Created by NIBMPC04PC06 on 2024-03-30.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var VMSignupVm : SignupViewModel = SignupViewModel()
    
    
    var body: some View {
        VStack{
            Text("Sign Up").bold().offset(x:-0).font(.system(size: 36))
            
            VStack(spacing:25) {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.blue)
                    .frame(height:50).padding(.horizontal,48)
                    .overlay{
                        HStack{
                            Image(systemName: "person")
                                .foregroundColor(.blue)
                            TextField("Username",text:$VMSignupVm.username)
                        }.padding(.horizontal,56)
                    }
                
                
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
                    .frame(height:50).padding(.horizontal,48)
                    .foregroundColor(.blue)
                    .overlay{
                        HStack{
                            Image(systemName: "envelope")
                                .foregroundColor(.blue)
                            TextField("Email",text:$VMSignupVm.email)
                        }.padding(.horizontal,56)
                        
                    }
                
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.blue)
                    .frame(height:50).padding(.horizontal,48)
                    .overlay{
                        HStack{
                            Image(systemName: "lock")
                                .foregroundColor(.blue)
                            SecureField("Password",text:$VMSignupVm.password)
                        }.padding(.horizontal,56)
                        
                    }
                
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.blue)
                    .frame(height:50).padding(.horizontal,48)
                    .overlay{
                        HStack{
                            Image(systemName: "lock")
                                .foregroundColor(.blue)
                            SecureField("Confirm Password",text:$VMSignupVm.con_password)
                        }.padding(.horizontal,56)
                        
                    }
                
                Button(action:{
                }
                       ,label: {
                    RoundedRectangle(cornerRadius: 35).frame(height:50)
                        .padding(.horizontal,47)
                        .padding(.top)
                    .foregroundColor(.blue)})
                .overlay{
                    Text("Register Now").bold()
                        .foregroundStyle(.white)
                        .padding(.top)
                }
            }.offset(y:20)
            
            
            Spacer()
            
            
        }
        .offset(y:100)
        
        Text("Already have an Account?").font(.system(size: 22))
        HStack{
            Text("Just Swipe down and Login")
            Image(systemName: "arrow.down").bold()
            
        }
    }
}

#Preview {
    SignupView()
}
