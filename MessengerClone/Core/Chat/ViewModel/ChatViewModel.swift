//
//  ChatViewModel.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 12/08/24.
//

import Foundation
class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    let user: User
    init(user: User) {
        self.user = user
    }
    
    
    func sendMessage() {
        MessageService.sendMessage(messageText, toUser: user)
    }
}
