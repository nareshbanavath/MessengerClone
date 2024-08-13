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
    static func observeMessages(chatPartner: User, completion: @escaping ([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        let query = messageCollection
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timeStamp", descending: false)
        
        query.addSnapshotListener { snapShot, error in
            if let error {
                debugPrint( error.localizedDescription )
            }
            guard let change = snapShot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = change.compactMap({ try? $0.document.data(as: Message.self) })
            
            for (index, message) in messages.enumerated() where !message.isFromCurrentUser {
                messages[index].user = chatPartner
            }
            completion(messages)
        }
        
    }
}
