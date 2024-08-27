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
    let user : User
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
                        CircularProfileImageView(user: user, size: .xLarge)
                    }
                }
                Text(user.fullName)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                List {
                    Section {
                        ForEach(SettingsOptionsViewModel.allCases) { option in
                            Button {
                                viewModel.settingsOptionTapped(type: option)
                            } label: {
                                HStack {
                                    Image(systemName: option.imageName)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(option.imageBackgroundColor)
                                    Text(option.title)
                                        .font(.subheadline)
                                }
                                .foregroundStyle(Color(UIColor.systemWhite))
                            }
                        }
                    }
                    Section {
                        Button("Logout") {
                            AuthService.shared.signOut()
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
    ProfileView(user: .MOCK_USER)
}
extension UIColor {
    static var systemWhite: UIColor {
        UIColor { traitColleciton in
            traitColleciton.userInterfaceStyle == .dark ? .white : .black
        }
    }
}
