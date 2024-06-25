//
//  LoginView.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 24/06/24.
//

import SwiftUI

struct LoginView: View {
    @State var emailField : String = ""
    @State var passwordField : String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                //1. logo image
                Image(.messengerIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150,height: 150)
                    .padding()
                
                //2. textfields
                
                VStack {
                    Group {
                        TextField("Enter your email", text: $emailField)
                        SecureField("Enter your password", text: $emailField)
                    }
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal,24)
                    
                   
                }
                
                //3. forgotPassword button
                
                Button(action: {
                    print("for got password")
                }, label: {
                    Text("Forgot password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                
                //4. login button
                Button {
                    print("Handle Login")
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 360, height: 44)
                        .background(Color(.systemBlue))
                        .cornerRadius(10.0)
                }
                .padding(.vertical)

                
                // Divider
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                    Text("OR")
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                }
                .padding(.top)
                .foregroundStyle(.gray)
                
                //5. facebook login
                
                HStack {
                    Image(.facebookIcon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                    Text("Continue with facebook")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.systemBlue))
                }
                Spacer()
                //6. signup link
                Divider()
                    
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Dont't have an account?")
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                    .foregroundStyle(Color(.systemBlue))
                }
                .padding(.vertical)

            }
        }
    }
}

#Preview {
    LoginView()
}
