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
        let modified = changes.filter({$0.type == .modified})
        let added = changes.filter({$0.type == .added})
        guard !modified.isEmpty || !added.isEmpty else { return }
        
        if !added.isEmpty {
            //add the element
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self)  })
            
            for i in 0..<messages.count {
                let message = messages[i]
                UserService.fetchUser(withUid: message.chatPartnerId) {[weak self] user in
                    messages[i].user = user
                    self?.recentMessages.append(messages[i])
                    guard let self else { return }
                    self.recentMessages = self.recentMessages.sorted(by: {$0.timeStamp.dateValue() > $1.timeStamp.dateValue()})
                }
            }
           
            
        } else if !modified.isEmpty {
            //modify the element
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self)  })
            for i in 0..<messages.count {
                let message = messages[i]
                UserService.fetchUser(withUid: message.chatPartnerId) {[weak self] user in
                    messages[i].user = user
                    guard let self else { return }
                    let index: Int = (self.recentMessages.firstIndex(where: {$0.chatPartnerId == messages.first!.chatPartnerId})!)
                    self.recentMessages[index] = messages.first!
                    self.recentMessages = self.recentMessages.sorted(by: {$0.timeStamp.dateValue() > $1.timeStamp.dateValue()})
                    
                }
            }
        }
        
      

    }
}
