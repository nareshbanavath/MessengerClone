//
//  Date + Extension.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 19/08/24.
//

import Foundation
extension Date {
    
    private var timeFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    private var dayFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "MM/dd/yy"
        return formatter
    }
    
    private func timeString() -> String {
        return timeFormatter.string(from: self)
    }
    
    private func dayString() -> String {
        return dayFormatter.string(from: self)
    }
    
    func timeStampString() -> String {
        if Calendar.current.isDateInToday(self) {
            return timeString()
        } else if Calendar.current.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            return dayString()
        }
    }
    
}
