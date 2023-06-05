//
//  CustomTicketsTableViewCell.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 19.05.2023.
//

import UIKit

class CustomTicketsTableViewCell: UITableViewCell {

    @IBOutlet weak var QrImageView: UIImageView!
    
    @IBOutlet weak var hourTextLabel: UILabel!
    
    @IBOutlet weak var dateTextLabel: UILabel!
    
    @IBOutlet weak var passengerName: UILabel!
    
    @IBOutlet weak var seatsTextLabel: UILabel!
    
    @IBOutlet weak var fromTextLabel: UILabel!
    
    @IBOutlet weak var toTextLabel: UILabel!
    
    func setup(_ ticketModel: TicketModel, _ qrModel: QrModel){
        
        fromTextLabel.text = ticketModel.fromLocation
        toTextLabel.text = ticketModel.toLocation
        hourTextLabel.text = ticketModel.hour
        dateTextLabel.text = "\(ticketModel.dateDay)/\(ticketModel.dateMonth)/\(ticketModel.dateYear)"
        QrImageView.image = qrModel.qrImage
        seatsTextLabel.text = "\(ticketModel.seatNumbers)"
        passengerName.text = ticketModel.passengerModel.name + " " + ticketModel.passengerModel.surname
    }

}
