//
//  CustomBusTableViewCell.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 13.05.2023.
//

import UIKit
import ALBusSeatView

class CustomBusTableViewCell: UITableViewCell {

    
    var dataManager = SeatDataManager()
    
    @IBOutlet weak var brandName: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var ticketPrice: UILabel!
    @IBOutlet weak var moveHour: UILabel!
    
    @IBOutlet weak var busSeatView: ALBusSeatView!
    
    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var outView: UIView!
    
    @IBOutlet weak var bottomStackView: UIStackView!
    
    var check: Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        outView.layer.borderWidth = 2
        outView.layer.borderColor = .none
        
        busSeatView.delegate = dataManager
        busSeatView.dataSource = dataManager

        busSeatView.config = ExampleSeatConfig()
        
        
        let mock = MockSeatCreater()
        let first = mock.create(count: 45)
        dataManager.seatList = [first]
        busSeatView?.reload()
        
        // For Seat Numbers
        NotificationCenter.default.addObserver(self, selector: #selector(seatNumbers), name: .seatNumbers, object: nil)
        
    }
    
    @objc func seatNumbers() {
        
        let seatNumbers = dataManager.seatNumber
        let count = dataManager.seatNumber.count
        let ticketPrice = Int((ticketPrice?.text)!)!
        let totalPrice = count * ticketPrice
        
        if !seatNumbers.isEmpty {
            seatLabel.text = "Seçilen Koltuklar = \(seatNumbers.map { String($0) }.joined(separator: ","))"
            priceLabel.text = "Toplam Fiyat = \(totalPrice) TL"
        }else {
            seatLabel.text = "Seçilen Koltuklar"
            priceLabel.text = "Toplam Fiyat"
        }
        
        NotificationCenter.default.post(name: .seatNumbersInController, object: nil, userInfo: ["seatNumber": dataManager.seatNumber])
        
    }
    
    func setup(_ busInformation: BusInformationModel){
        
        brandName.text = busInformation.brandName
        moveHour.text = busInformation.moveHour
        ticketPrice.text = busInformation.ticketPrice
        brandImage.image = busInformation.brandImage
        actionLabel.text = busInformation.fromLocation + " (Otogar)" + " > " + busInformation.toLocation + " (Otogar)"
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        
        if dataManager.selectedSeatlist.isEmpty {
           NotificationCenter.default.post(name: .emptySeat, object: nil)
            check = true
            
        } else {
            check = false
        }
         UserDefaults.standard.set(check, forKey: "check")
         NotificationCenter.default.post(name: .nextButton, object: nil)
        
    }
    
    
}
