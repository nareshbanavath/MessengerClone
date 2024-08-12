//
//  ContentView.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 24/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        if viewModel.userSession?.uid != nil {
            InboxView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
