//
//  ProfileView.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 07/07/24.
//

import SwiftUI
import PhotosUI
struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        VStack {
            // Header
            VStack {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    if let profileImage = viewModel.profileImage {
                        profileImage
                            .resizable()
                            .frame(width: 80, height: 80)
                            .scaledToFit()
                            .clipShape(Circle())
                    }else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color(.systemGray4))
                    }
                }
                Text("Naresh Nayak")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                List {
                    Section {
                        ForEach(SettingsOptionsViewModel.allCases) { option in
                            HStack {
                                Image(systemName: option.imageName)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(option.imageBackgroundColor)
                                Text(option.title)
                                    .font(.subheadline)
                            }
                        }
                    }
                    Section {
                        Button("Logout") {
                            
                        }
                        Button("Delete Account") {
                            
                        }
                    }
                    .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
