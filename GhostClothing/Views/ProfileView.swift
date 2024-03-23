//
//  ProfileView.swift
//  GhostClothing
//
//  Created by NIBMPC04PC02 on 2024-03-17.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var VMUser : UserViewModel = UserViewModel()
    var body: some View {
        VStack {
            Button(action: {
            })
            { Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .foregroundColor(.blue)
                    .padding()
                
            }
            HStack{
                Button(action: {
                })
                {
                    Image(systemName: "square.and.arrow.up").bold()
                    
                }
                Button(action: {
                })
                {
                    Image(systemName: "trash").bold()
                    
                }
            }
            ScrollView{
                RoundedRectangle(cornerRadius: 10).frame(height:300).frame(width: 350)
                    .foregroundColor(.white)
                    .padding(30)
                    .shadow(radius: 5).overlay{
                        VStack(spacing:25){
                            
                            VStack{
                                TextField("FullName",text: $VMUser.fullname)
                                    .padding(.horizontal)
                                
                                Divider()
                                    .background(Color.blue)
                            }.frame(width: 300)
                            VStack{
                                TextField("Address",text: $VMUser.address)
                                    .padding(.horizontal)
                                    .frame(height: 55)
                                
                                Divider()
                                    .background(Color.blue)
                            }.frame(width: 300)
                            
                            VStack{
                                TextField("Mobile Number",text: $VMUser.fullname)
                                    .padding(.horizontal)
                                
                                Divider()
                                    .background(Color.blue)
                            }.frame(width: 300)
                            VStack{
                                TextField("Email Id",text: $VMUser.fullname)
                                    .padding(.horizontal)
                                
                                Divider()
                                    .background(Color.blue)
                            }.frame(width: 300)
                            
                        }.padding(.all)
                    }
                
                RoundedRectangle(cornerRadius: 10).frame(height:200).frame(width: 350)
                    .foregroundColor(.white)
                    .padding(30)
                    .shadow(radius: 5).overlay{
                        VStack(spacing:25){
                            
                            VStack{
                                TextField("User Name",text: $VMUser.username)
                                    .padding(.horizontal)
                                
                                Divider()
                                    .background(Color.blue)
                            }.frame(width: 300)
                            VStack{
                                TextField("Current Password",text: $VMUser.password)
                                    .padding(.horizontal)
                                    
                                
                                Divider()
                                    .background(Color.blue)
                            }.frame(width: 300)
                            
                            VStack{
                                TextField("New Password",text: $VMUser.newpassword)
                                    .padding(.horizontal)
                                
                                Divider()
                                    .background(Color.blue)
                            }.frame(width: 300)
                        }
                    }
                
                HStack{
                    Button(action: {
                    })
                    {
                        Text("Save")
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(Color.blue)
                                        .cornerRadius(5)
                    }
                    Button(action: {
                    })
                    {
                        Text("Logout")
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(Color.red)
                                        .cornerRadius(5)
                    }
                }
        
                
            }
                    Spacer()
                }
    }
}

#Preview {
    ProfileView()
}
