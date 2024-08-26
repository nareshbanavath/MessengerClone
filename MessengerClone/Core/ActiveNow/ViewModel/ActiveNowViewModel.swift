//
//  ActiveNowViewModel.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 19/08/24.
//

import Foundation
import Firebase

class ActiveNowViewModel: ObservableObject {
    @Published var users = [User]()
    init() {
        Task { try await fetchAllUsers()  }
    }
    
    @MainActor
    private func fetchAllUsers() async throws{
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers(limit: 10)
        self.users = users.filter({$0.uid != currentUid})
        
        
    }
}
