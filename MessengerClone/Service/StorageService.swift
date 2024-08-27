//
//  StorageService.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 26/08/24.
//

import Foundation
import FirebaseStorage

class StorageService {
    
    func uploadData(data: Data) async throws -> URL {
        let randomId = UUID().uuidString
        let imageRef = Storage.storage().reference(withPath: "images/\(randomId).jpeg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        _ = try await imageRef.putDataAsync(data, metadata: metaData) { progress in
            print(progress?.fractionCompleted as Any)
        }
        let downloadURL = try await imageRef.downloadURL()
        return downloadURL

    }
}
