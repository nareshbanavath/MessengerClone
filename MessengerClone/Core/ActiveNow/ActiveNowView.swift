//
//  ActiveNowView.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 01/07/24.
//

import SwiftUI

struct ActiveNowView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(0..<10, id: \.self) { user in
                    VStack {
                        ZStack(alignment: .bottomTrailing) {
                            CircularProfileImageView(user: .MOCK_USER, size: .large)
                            ZStack {
                                Circle()
                                    .frame(width: 18,height: 18)
                                    .foregroundStyle(.white)
                                Circle()
                                    .frame(width: 12,height: 12)
                                    .foregroundStyle(.green)
                            }
                        }
                            
                        Text("User \(user)")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
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
