//
//  SeatStub.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 13.05.2023.
//

import Foundation

struct SeatStub: Codable {
    var id: String
    var number: Int
    var salable: Bool
    var gender: Bool
    var hall: Bool
}

class MockSeatCreater {

    func create(count: Int) -> [SeatStub] {
        var list = [SeatStub]()
        (1...count).forEach { (count) in
            let isHall = (count - 2) % 5 == 1
            let stub = SeatStub(id: UUID().uuidString,
                                number: count,
                                salable: Bool.random(),
                                gender: Bool.random(),
                                hall: isHall)
            list.append(stub)
        }
        return list
    }
    
}


