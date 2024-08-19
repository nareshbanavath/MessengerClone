//
//  UserService.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 08/08/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
class UserService {
    @Published var currentUser: User?
    static let shared = UserService()
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapShot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapShot.data(as: User.self)
        self.currentUser = user
        debugPrint("DEBUG: current User in Service \(user)")
     }
    static func fetchAllUsers() async throws -> [User] {
        let snapShot = try await Firestore.firestore().collection("users").getDocuments()
        let users = snapShot.documents.compactMap({ try? $0.data(as: User.self) })
        return users
    }
    static func fetchUser(withUid uid: String, completion: @escaping (User) -> Void) {
        FirebaseConstants.UserCollection.document(uid).getDocument { snapShot, error in
            guard let user = try? snapShot?.data(as: User.self) else { return }
            completion(user)
        }
    }
}
