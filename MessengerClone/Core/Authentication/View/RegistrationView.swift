//
//  RegistrationView.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 25/06/24.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
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
                    TextField("Enter your email", text: $viewModel.email)
                    TextField("Enter your fullname", text: $viewModel.fullName)
                    SecureField("Enter your password", text: $viewModel.password)
                }
                .textInputAutocapitalization(.never)
                .font(.subheadline)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal,24)
            }
            //4. SignUp
            Button {
                Task { try await viewModel.createUser()  }
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
