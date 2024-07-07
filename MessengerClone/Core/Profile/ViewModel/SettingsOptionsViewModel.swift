//
//  SettingsOptionsViewModel.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 07/07/24.
//


import SwiftUI

enum SettingsOptionsViewModel : Int, CaseIterable, Identifiable {
    case darkMode
    case activeStatus
    case accessibility
    case privacyAndSafety
    case Notifications
    var id: Int { self.rawValue }
    
    var title : String {
        switch self {
        case .darkMode:         "Dark Mode"
        case .activeStatus:     "Active Status"
        case .accessibility:    "Accessibility"
        case .privacyAndSafety: "Privacy and Safety"
        case .Notifications:    "Notifications"
        }
    }
    
    var imageName : String {
        switch self {
        case .darkMode:         "moon.circle.fill"
        case .activeStatus:     "message.badge.circle.fill"
        case .accessibility:    "person.circle.fill"
        case .privacyAndSafety: "lock.circle.fill"
        case .Notifications:    "bell.circle.fill"
        }
    }
    var imageBackgroundColor : Color {
        switch self {
        case .darkMode:         return .black
        case .activeStatus:     return Color(.systemGreen)
        case .accessibility:    return .black
        case .privacyAndSafety: return Color(.systemBlue)
        case .Notifications:    return Color(.systemPurple)
        }
    }
}

