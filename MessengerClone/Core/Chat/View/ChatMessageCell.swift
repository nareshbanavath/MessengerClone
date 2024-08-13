//
//  ChatMessageCell.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 15/07/24.
//

import SwiftUI

struct ChatMessageCell: View {
    let message: Message
    private var isFromCurrentUser: Bool {
        message.isFromCurrentUser
    }
    var body: some View {
        HStack {
            if isFromCurrentUser {
                HStack(alignment: .bottom, spacing: 0) {
                    Spacer()
                    Text(message.messageText)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemBlue))
                        .foregroundStyle(.white)
                        .clipShape(ChatBubble(isCurrentUser:  isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.5, alignment: .trailing)
                }
            } else {
                HStack(alignment: .bottom, spacing: 8.0) {
                    CircularProfileImageView(user: message.user, size: .xxSmall)
                    Text(message.messageText)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .foregroundStyle(.black)
                        .clipShape(ChatBubble(isCurrentUser:  isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.5, alignment: .leading)
                    Spacer()
                    
                }
            }
            
        }
        .padding(.horizontal)
        
    }
}

