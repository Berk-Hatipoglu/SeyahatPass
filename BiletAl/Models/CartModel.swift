//
//  CartModel.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 26.05.2023.
//

import Foundation

struct CartModel {
    
    var number: String
    var expiration: String
    var cvc: String
    
    
    init(number: String = "", expiration: String = "" , cvc: String = "") {
        self.number = number
        self.expiration = expiration
        self.cvc = cvc
    }
}
