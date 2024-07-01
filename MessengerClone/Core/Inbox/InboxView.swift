//
//  InboxView.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 01/07/24.
//

import SwiftUI

struct InboxView: View {
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
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                           
                        Text("Charts")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                       Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32,height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    })
                }
            }
        }
    }
}

#Preview {
    InboxView()
}
