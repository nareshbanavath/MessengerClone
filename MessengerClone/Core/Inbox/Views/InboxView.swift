//
//  InboxView.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 01/07/24.
//

import SwiftUI

struct InboxView: View {
    @State private var showNewMessageView : Bool = false
    @StateObject var viewModel = InboxViewModel()
    @State var selectedUser: User?
    @State var showChat: Bool = false
    var user: User? {
        viewModel.currentUser
    }
    var body: some View {
        NavigationStack{
            List {
                ActiveNowView()
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical)
                    .padding(.horizontal, 4)
                
                ForEach(viewModel.recentMessages) { message in
                    ZStack {
                        NavigationLink(value: message) {
                            EmptyView()
                        }.opacity(0.0)
                        InboxRowView(message: message)
                    }
                }
            }
            .navigationTitle("Charts")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .navigationDestination(for: Message.self, destination: { message in
                if let user = message.user {
                    ChatView(user: user)
                }
            })
            .navigationDestination(for: Route.self, destination: { route in
                switch route {
                case .profile(let user):
                    ProfileView(user: user)
                case .chatView(let user):
                    ChatView(user: user)
                }
            })
            .navigationDestination(isPresented: $showChat, destination: {
                if let user = selectedUser {
                    ChatView(user: user)
                }
            })
            .onChange(of: selectedUser) {
                showChat = selectedUser != nil
            }
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        if let user {
                            NavigationLink(value: Route.profile(user)) {
                                CircularProfileImageView(user: user, size: .xSmall)
                            }
                        }
                        
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showNewMessageView.toggle()
                        selectedUser = nil
                    }, label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32,height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    })
                }
            }
            .fullScreenCover(isPresented: $showNewMessageView) {
                NewMessageView(selectedUser: $selectedUser)
            }
        }
    }
}

#Preview {
    InboxView()
}
