//
//  NewMessageView.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 03/07/24.
//

import SwiftUI

struct NewMessageView: View {
    @Environment(\.dismiss) var dismiss
    @State var searchText : String = ""
    var body: some View {
        NavigationStack {
            ScrollView {                
                TextField("To: ", text: $searchText)
                    .frame(height: 44)
                    .padding(.leading, 8)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius:4.0))
                    .padding(8)
                Text("CONTACTS")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                ForEach(0...10, id: \.self){ index in
                    VStack {
                        HStack {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(Color(.systemGray4))
                            Text("User Numer \(index)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        Divider()
                            .padding(.leading,40)
                    }
                    .padding(.leading)
                }
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("Cancel")
                                .font(.headline)
                                .foregroundStyle(.black)
                        })
                    }
                }
               
            }
        }
    }
}

#Preview {
    NewMessageView()
}
