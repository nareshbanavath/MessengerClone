//
//  InboxViewModel.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 09/08/24.
//

import Foundation
import Combine
import Firebase

@MainActor
class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var recentMessages = [Message]()
    
    private var cancellables = Set<AnyCancellable>()
    private let service = InboxService()
    init(){
        setupSubscribers()
        service.observeRecentMessages()
    }
    private func setupSubscribers(){
        UserService.shared.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }.store(in: &cancellables)
        
        service.$documentChanges.sink { [weak self] changes in
            self?.loadInitialMessages(fromChanges: changes)
        }.store(in: &cancellables)
    }
    
    private func loadInitialMessages(fromChanges changes: [DocumentChange]) {
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self)  })
        
        for i in 0..<messages.count {
            let message = messages[i]
            UserService.fetchUser(withUid: message.chatPartnerId) {[weak self] user in
                messages[i].user = user
                self?.recentMessages.append(messages[i])
            }
        }
    }
}
