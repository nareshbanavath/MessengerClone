//
//  ChatMessageCell.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 15/07/24.
//

import SwiftUI

struct ChatMessageCell: View {
    let isFromCurrentUser: Bool
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                Text("This text is from current user, so adjust its length")
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundStyle(.white)
                    .clipShape(ChatBubble(isCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
            } else {
                HStack(alignment: .bottom, spacing: 8.0) {
                    CircularProfileImageView(user: .MOCK_USER, size: .xxSmall)
                    Text("This text is from  other user")
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .foregroundStyle(.black)
                        .clipShape(ChatBubble(isCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.5, alignment: .leading)
                    Spacer()
                    
                }
            }
            
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    ChatMessageCell(isFromCurrentUser: false)
}
