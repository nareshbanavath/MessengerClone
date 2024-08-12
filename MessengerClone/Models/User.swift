//
//  User.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 08/07/24.
//

import Foundation
import FirebaseFirestoreSwift
struct User: Codable, Identifiable, Hashable {
    @DocumentID var uid: String?
    let fullName : String
    let email : String
    var profileImageURL : String?
    var id: String {
        return uid ?? UUID().uuidString
    }
}
extension User {
    static let MOCK_USER = User(fullName: "Naresh Banavath", email: "naresh.banavath@gmail.com", profileImageURL: "batman")
}
