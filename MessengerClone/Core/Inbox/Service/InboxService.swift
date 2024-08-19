//
//  InboxService.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 19/08/24.
//

import Foundation
import Firebase

class InboxService {
   @Published var documentChanges = [DocumentChange]()
    
    func observeRecentMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let query = FirebaseConstants
            .MessageCollection
            .document(uid)
            .collection("recent-messages")
            .order(by: "timeStamp", descending: true)
        
        query.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added || $0.type == .modified }) else { return }
            self.documentChanges = changes
        }
    }
}
