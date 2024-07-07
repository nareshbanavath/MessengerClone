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
    
    func loadImage() async throws {
        guard let item = selectedItem else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImge = UIImage(data: imageData) else { return }
        self.profileImage = Image(uiImage: uiImge)
    }
}
