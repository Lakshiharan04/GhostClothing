//
//  LoginViewModel.swift
//  GhostClothing
//
//  Created by NIBMPC04PC02 on 2024-03-16.
//

import Foundation
import SwiftUI

class LoginViewModel : ObservableObject {
    @Published var username : String = ""
    @Published var password : String = ""
    @Published var showError : Bool = false
    @Published var errorMessage : String = ""
    @Published var success : Bool = false
   
    
    func verifyLogin(){
        if username.isEmpty || password.isEmpty {
            showError = true
            errorMessage = "User Name and Password cannot be an empty!"
        } else if (username.lowercased() == "abc" && password == "123" ){
            showError = false
            success = true
        }else{
            showError = true
            errorMessage = "Username and password mismatched. Please try again!!"
        }
            
        }

    }

