//
//  RegistrationView.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 25/06/24.
//

import SwiftUI

struct RegistrationView: View {
    @State var emailField: String = ""
    @State var fullNameField: String = ""
    @State var passwordField: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
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
                    TextField("Enter your fullname", text: $fullNameField)
                    SecureField("Enter your fullname", text: $passwordField)
                    
                }
                .font(.subheadline)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal,24)
            }
            //4. login button
            Button {
                print("Handle Login")
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(10.0)
            }
            .padding(.vertical)
            Spacer()
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
                .foregroundStyle(Color(.systemBlue))
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    RegistrationView()
}
