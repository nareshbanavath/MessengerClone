//
//  MessageService.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 12/08/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
struct MessageService {
    static let messageCollection = Firestore.firestore().collection("messages")
    static func sendMessage(_ messageText: String, toUser user: User) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerid = user.id
        
        let currentUserRef = messageCollection.document(currentUid).collection(chatPartnerid).document()
        let chatPatnerRef = messageCollection.document(chatPartnerid).collection(currentUid)
        
        let messageId = currentUserRef.documentID
        let message = Message(
            messageId: messageId,
            fromId: currentUid,
            toId: chatPartnerid,
            messageText: messageText,
            timeStamp: Timestamp()
        )
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        currentUserRef.setData(messageData)
        chatPatnerRef.document(messageId).setData(messageData)
    }
}
