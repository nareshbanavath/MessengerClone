//
//  ChatService.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 13/08/24.
//

import Foundation
import Firebase
struct ChatService {
  
    let chatPartner: User
    
    func sendMessage(_ messageText: String) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerid = chatPartner.id
        
        let currentUserRef = FirebaseConstants.MessageCollection.document(currentUid).collection(chatPartnerid).document()
        let chatPatnerRef = FirebaseConstants.MessageCollection.document(chatPartnerid).collection(currentUid)
        let recentCurrentUserRef = FirebaseConstants.MessageCollection.document(currentUid).collection("recent-messages").document(chatPartnerid)
        let recentPartnerRef = FirebaseConstants.MessageCollection.document(chatPartnerid).collection("recent-messages").document(currentUid)
        
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
        
        recentCurrentUserRef.setData(messageData)
        recentPartnerRef.setData(messageData)
    }
     func observeMessages(completion: @escaping ([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
         let query = FirebaseConstants.MessageCollection
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
