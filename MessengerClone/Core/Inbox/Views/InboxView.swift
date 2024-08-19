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
            ScrollView {
                ActiveNowView()
                List {
                    ForEach(viewModel.recentMessages) { message in
                        InboxRowView(message: message)
                            .onTapGesture {
                                selectedUser = message.user
                            }
                    }
                }
                .listStyle(.plain)
                .frame(height: UIScreen.main.bounds.height - 120)
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
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
                        NavigationLink(value: user) {
                            CircularProfileImageView(user: user, size: .xSmall)
                        }
                           
                        Text("Charts")
                            .font(.title)
                            .fontWeight(.semibold)
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
