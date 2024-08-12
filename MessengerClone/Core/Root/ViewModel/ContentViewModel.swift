//
//  ContentViewModel.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 08/08/24.
//

import Foundation
import Firebase
import Combine

class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers(){
        AuthService.shared.$user.sink { [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancellables)
    }
}
