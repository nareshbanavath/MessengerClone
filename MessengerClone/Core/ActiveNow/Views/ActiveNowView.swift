//
//  ActiveNowView.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 01/07/24.
//

import SwiftUI

struct ActiveNowView: View {
    @StateObject var viewModel = ActiveNowViewModel()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(viewModel.users) { user in
                    NavigationLink(value: Route.chatView(user)){
                        VStack {
                            ZStack(alignment: .bottomTrailing) {
                                CircularProfileImageView(user: user, size: .large)
                                ZStack {
                                    Circle()
                                        .frame(width: 18,height: 18)
                                        .foregroundStyle(.white)
                                    Circle()
                                        .frame(width: 12,height: 12)
                                        .foregroundStyle(.green)
                                }
                            }
                                
                            Text(user.firstName)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            .padding()
        }
        .frame(height: 106)
        
    }
}

#Preview {
    ActiveNowView()
}
