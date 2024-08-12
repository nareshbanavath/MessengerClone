//
//  NewMessageViewModel.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 12/08/24.
//

import Foundation
@MainActor
class NewMessageViewModel: ObservableObject{
    @Published var users = [User]()
    init() {
        Task{ try await fetchAllUsers() }
    }
    func fetchAllUsers() async throws {
        guard let currentUserID = UserService.shared.currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers()
        self.users = users.filter({ $0.uid != currentUserID  })
        
    }
}
