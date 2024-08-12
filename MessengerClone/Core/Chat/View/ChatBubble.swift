//
//  ChatBubble.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 15/07/24.
//

import SwiftUI

struct ChatBubble: Shape {
    let isCurrentUser: Bool
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, 
                                byRoundingCorners: [
                                    .topRight,
                                    .topLeft,
                                    isCurrentUser ? .bottomLeft : .bottomRight],
                                cornerRadii: .init(width: 16.0, height: 16.0))
        return Path(path.cgPath)
    }
}

#Preview {
    ChatBubble(isCurrentUser: true)
}
