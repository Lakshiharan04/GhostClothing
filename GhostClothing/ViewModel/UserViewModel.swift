//
//  UserViewModel.swift
//  GhostClothing
//
//  Created by NIBMPC04PC02 on 2024-03-17.
//

import Foundation
import SwiftUI

class UserViewModel : ObservableObject{
    
    @Published var fullname : String = ""
    @Published var mobileno : String = ""
    @Published var emailadd : String = ""
    @Published var address : String = ""
    
    @Published var username : String = ""
    @Published var password : String = ""
    @Published var newpassword : String = ""
    
    
    
}
