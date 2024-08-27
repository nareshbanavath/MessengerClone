//
//  ChatViewModel.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 12/08/24.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    @Published var messages = [Message]()
    let service: ChatService
    init(user: User) {
        self.service = ChatService(chatPartner: user)
        observeMessages()
    }
    
    func observeMessages() {
        service.observeMessages { messages in
            if messages.count + 1 == messages.count {
                withAnimation(.spring(.snappy, blendDuration: 0.250)) {
                    self.messages.append(contentsOf: messages)
                }
            } else {
                self.messages.append(contentsOf: messages)
            }
        }
    }
    func sendMessage() {
        let messageText = messageText
        self.messageText = ""
        service.sendMessage(messageText)
    }
}
