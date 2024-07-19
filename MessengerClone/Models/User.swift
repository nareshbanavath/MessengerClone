//
//  User.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 08/07/24.
//

import Foundation
struct User: Codable, Identifiable, Hashable {
    var id : String = UUID().uuidString
    let fullName : String
    let email : String
    var profileImageURL : String?
}
extension User {
    static let MOCK_USER = User(fullName: "Naresh Banavath", email: "naresh.banavath@gmail.com", profileImageURL: "batman")
}
