//
//  ChatView.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 08/07/24.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel : ChatViewModel
    let user: User
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
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
                LazyVStack {
                    ForEach(viewModel.messages) { message in
                        ChatMessageCell(message: message)
                    }
                }

            }
            // Message Input View
            ZStack(alignment: .trailing) {
                TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                    .font(.subheadline)
                    .padding(16)
                    .padding(.trailing,48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                Button(action: {
                    viewModel.sendMessage()
                    viewModel.messageText  = ""
                    
                }, label: {
                    Text("Send")
                        .fontWeight(.semibold)
                })
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle(user.fullName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ChatView(user: User.MOCK_USER)
}
