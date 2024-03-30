//
//  SplashScreen.swift
//  GhostClothing
//
//  Created by NIBMPC04PC06 on 2024-03-30.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
        
    var body: some View {
        
            if isActive {
                        LoginView()
                    } else {
                        VStack {
                            VStack(spacing: 16) {
                                Image(systemName: "hare.fill")
                                    .font(.system(size: 80))
                                    .foregroundColor(.blue)
                                Text("GHOST CLOTHING")
                                    .font(Font.custom("julius sans one", size: 26))
                                    .foregroundColor(.black.opacity(0.80))
                            }
                            .scaleEffect(size)
                            .opacity(opacity)
                            .onAppear {
                                withAnimation(.easeIn(duration: 5.5)) {
                                    self.size = 0.9
                                    self.opacity = 1.00
                                }
                            }
                        }
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                withAnimation {
                                    self.isActive = true
                                }
                            }
                        }
                    }
      
    }
}

#Preview {
    SplashScreen()
}
