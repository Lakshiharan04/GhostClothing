import SwiftUI

struct LoginView: View {
    @ObservedObject var vmLogin: LoginViewModel = LoginViewModel()
    @State private var showSignupScreen = false

    var body: some View {
        ZStack {
            
            VStack {
                
                Text("Hey there!")
                    .bold()
                    .font(Font.custom("julius sans one", size: 36))
                    .offset(y: 45)
                Text("Welcome to Srilanka's most popular men's clothing platform!")
                    .font(Font.custom("julius sans one", size: 12))
                    .foregroundColor(.black.opacity(0.80))
                    .offset(y: 50)

                VStack(spacing: 25) {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.blue)
                        .frame(height: 50)
                        .padding(.horizontal, 48)
                        .overlay {
                            HStack {
                                Image(systemName: "person")
                                    .foregroundColor(.blue)
                                TextField("Username", text: $vmLogin.username)
                            }
                            .padding(.horizontal, 56)
                        }

                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.blue)
                        .frame(height: 50)
                        .padding(.horizontal, 48)
                        .overlay {
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.blue)
                                SecureField("Password", text: $vmLogin.password)
                            }
                            .padding(.horizontal, 56)
                        }

                    Button(action: {
                        vmLogin.verifyLogin()
                    }) {
                        RoundedRectangle(cornerRadius: 35)
                            .frame(height: 50)
                            .padding(.horizontal, 47)
                            .padding(.top)
                            .foregroundColor(.blue)
                            .overlay {
                                Text("Get Inside")
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.top)
                            }
                    }
                    .offset(y: 20)

                    if vmLogin.showError {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(height: 100)
                            .padding(40)
                            .foregroundColor(.black)
                            .shadow(radius: 10)
                            .overlay {
                                Text(vmLogin.errorMessage)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(45)
                            }
                    }
                    Spacer()
                }
                .offset(y: 200)

                NavigationLink("",isActive: $vmLogin.success)
                {
                    HomeView()

                }

                Button(action: {}) {
                    Text("Forgotten Password?")
                        .foregroundColor(.red)
                }

                HStack {
                    Text("Don't have an Account?")
                    Button(action: {
                        showSignupScreen = true

                    }) {
                        Text("Create Now!")
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .sheet(isPresented: $showSignupScreen) {
                        SignupView()
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

