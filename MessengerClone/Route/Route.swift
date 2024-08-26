//
//  Route.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 19/08/24.
//

import Foundation
enum Route: Hashable {
    case profile(User)
    case chatView(User)
}
