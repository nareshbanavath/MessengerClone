//
//  LoginViewModel.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 22/07/24.
//

import SwiftUI
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func login() async throws { 
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
