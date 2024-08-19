//
//  Constants.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 13/08/24.
//

import Foundation
import Firebase

struct FirebaseConstants{
    static let UserCollection = Firestore.firestore().collection("users")
    static let MessageCollection = Firestore.firestore().collection("messages")
}
