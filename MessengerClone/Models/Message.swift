//
//  Message.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 12/08/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable, Hashable {
    @DocumentID var messageId: String?
    let fromId: String
    let toId: String
    let messageText: String
    let timeStamp: Timestamp
    
    var user: User?
    var id: String {
        messageId ?? UUID().uuidString
    }
    
    var chatPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    var isFromCurrentUser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    }
    var timeStampString: String {
        timeStamp.dateValue().timeStampString()
    }
}
