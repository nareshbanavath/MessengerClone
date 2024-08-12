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
    var user: User? {
        viewModel.currentUser
    }
    var body: some View {
        NavigationStack{
            ScrollView {
                ActiveNowView()
                List {
                    ForEach(0...10, id: \.self) { message in
                        InboxRowView()
                    }
                }
                .listStyle(.plain)
                .frame(height: UIScreen.main.bounds.height - 120)
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
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
                    }, label: {
                       Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32,height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    })
                }
            }
            .fullScreenCover(isPresented: $showNewMessageView) {
               NewMessageView()
            }
        }
    }
}

#Preview {
    InboxView()
}
