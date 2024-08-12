//
//  AuthService.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 22/07/24.
//

import Foundation
import Firebase
import FirebaseFirestore

class AuthService {
    @Published var user : FirebaseAuth.User?
    static let shared = AuthService()
    private init() {
        self.user = Auth.auth().currentUser
        loadCurrentUserData()
        debugPrint("DEBUG: current user id \(user?.uid)")
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let resut = try await Auth.auth().signIn(withEmail: email, password: password)
            self.user = resut.user
            loadCurrentUserData()
        }catch {
            debugPrint("DEBUG: Error singIn the user \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.user = result.user
            try await uploadUserData(email: email, fullName: fullName, id: result.user.uid)
            loadCurrentUserData()
        }catch {
            debugPrint("DEBUG: error \(error.localizedDescription)")
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            UserService.shared.currentUser = nil
            
        } catch {
            debugPrint("DEBUG: error logout \(error.localizedDescription)")
        }
    }
    private func uploadUserData(email: String, fullName: String, id: String) async throws {
        let user = User(fullName: fullName, email: email, profileImageURL: nil)
        guard let encodeUser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(encodeUser)
    }
    private func loadCurrentUserData(){
        Task { try await UserService.shared.fetchCurrentUser() }
    }
}
