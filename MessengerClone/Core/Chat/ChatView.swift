//
//  ChatView.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 08/07/24.
//

import SwiftUI

struct ChatView: View {
    @State var messageText = ""
    let user: User
    var body: some View {
        VStack {
            ScrollView {
                // Header
                VStack {
                    CircularProfileImageView(user: user, size: .xLarge)
                    
                    VStack(spacing: 4){
                        Text(user.fullName)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                }
                // Messages
                ForEach(0...12, id: \.self) { i in
                    ChatMessageCell(isFromCurrentUser: .random())
                }

            }
            // Message Input View
            ZStack(alignment: .trailing) {
                TextField("Message...", text: $messageText, axis: .vertical)
                    .font(.subheadline)
                    .padding(16)
                    .padding(.trailing,48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                Button(action: {}, label: {
                    Text("Send")
                        .fontWeight(.semibold)
                })
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    ChatView(user: User.MOCK_USER)
}
