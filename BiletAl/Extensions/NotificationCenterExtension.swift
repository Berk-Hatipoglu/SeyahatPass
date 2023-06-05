//
//  NotificationCenterExtension.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 13.05.2023.
//

import Foundation

extension NSNotification.Name {
    
    static let maxSelected = Notification.Name(rawValue: "maxSelected")
    static let seatNumbers = Notification.Name(rawValue: "seatNumbers")
    static let nextButton = Notification.Name(rawValue: "nextButton")
    static let seatNumbersInController = Notification.Name(rawValue: "seatNumbersInController")
    static let emptySeat = Notification.Name(rawValue: "emptySeat")
}
