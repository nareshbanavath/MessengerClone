//
//  InboxRowView.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 01/07/24.
//

import SwiftUI

struct InboxRowView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundStyle(Color(.systemGray4))
            VStack(alignment: .leading){
                Text("Naresh Nayak")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("Some text message need to sent through this medium")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
            }
            HStack(alignment: .center, spacing: 4) {
                Text("Yesterday")
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
        .frame(height: 72)
       
    }
}

#Preview {
    InboxRowView()
        .padding()
}
