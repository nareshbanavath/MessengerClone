//
//  RegistrationViewModel.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 22/07/24.
//

import SwiftUI
class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fullName: String = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullName: fullName)
    }
    
}
