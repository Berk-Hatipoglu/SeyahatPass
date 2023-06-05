//
//  TicketModel.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 13.05.2023.
//

import Foundation


struct TicketModel {
    
    var fromLocation: String
    var toLocation: String
    var dateDay: Int
    var dateMonth: Int
    var dateYear: Int
    var seatNumbers: [Int]
    var totalSeatPrice: Int
    var passengerModel: PassengerModel
    var hour: String
    var user_email: String
    
    init(fromLocation: String = "", toLocation: String = "", dateDay: Int = 31, dateMonth: Int = 12, dateYear: Int = 1970, seatNumbers: [Int] = [], totalSeatPrice: Int = 0, passenger: PassengerModel = PassengerModel(), hour: String = "", user_email: String = "") {
       
        self.fromLocation = fromLocation
        self.toLocation = toLocation
        self.dateDay = dateDay
        self.dateMonth = dateMonth
        self.dateYear = dateYear
        self.seatNumbers = seatNumbers
        self.totalSeatPrice = totalSeatPrice
        self.passengerModel = passenger
        self.hour = hour
        self.user_email = user_email
    }
    
}

