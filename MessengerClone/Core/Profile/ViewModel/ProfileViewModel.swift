//
//  ProfileViewModel.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 07/07/24.
//

import SwiftUI
import PhotosUI

class ProfileViewModel : ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { try await loadImage() }}
    }
    @Published var profileImage: Image?
    
    @MainActor
    func loadImage() async throws {
        guard let item = selectedItem else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImge = UIImage(data: imageData) else { return }
        guard let data = uiImge.jpegData(compressionQuality: 0.01) else { return }
        try await uploadImage(data: data)
        self.profileImage = Image(uiImage: uiImge)
    }
    func settingsOptionTapped(type: SettingsOptionsViewModel) {
        switch type {
        case .darkMode:
            //DarkMode tapped
            if let window = UIApplication.shared.windows.first {
                window.overrideUserInterfaceStyle = .dark
            }
        default:
            debugPrint(type.title)
        }
    }
    func uploadImage(data: Data) async throws {
        let downlodURL = try await StorageService().uploadData(data: data)
        try await AuthService.shared.updateUserData(profileImgURL: downlodURL.absoluteString)
    }
}
