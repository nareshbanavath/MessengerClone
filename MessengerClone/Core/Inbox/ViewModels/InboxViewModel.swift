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
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let service = InboxService()
    private var allRecentMessages = [Message]()
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
        
        $searchText.sink { [weak self] text in
            guard let self else { return }
            guard text.count > 0 else { self.recentMessages = self.allRecentMessages; return }
            self.recentMessages = self.allRecentMessages.filter({$0.user?.fullName.contains(text) == true })
        }.store(in: &cancellables)
        
    }
    
    private func loadInitialMessages(fromChanges changes: [DocumentChange]) {
        let modified = changes.filter({$0.type == .modified})
        let added = changes.filter({$0.type == .added})
        guard !modified.isEmpty || !added.isEmpty else { return }
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self)  })
    
        /// put user object in messages

        let dispatchGroup = DispatchGroup()
        for i in 0..<messages.count {
            dispatchGroup.enter()
            UserService.fetchUser(withUid: messages[i].chatPartnerId) { user in
                messages[i].user = user
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if !added.isEmpty {
                /// add the element
                self.allRecentMessages.append(contentsOf: messages)
                
            } else if !modified.isEmpty {
                /// update the element
                let index: Int = (self.allRecentMessages.firstIndex(where: {$0.chatPartnerId == messages.first!.chatPartnerId})!)
                self.allRecentMessages[index] = messages.first!
            }
            self.allRecentMessages = self.allRecentMessages.sorted(by: {$0.timeStamp.dateValue() > $1.timeStamp.dateValue()})
            self.recentMessages = self.allRecentMessages
        }
    }
}
