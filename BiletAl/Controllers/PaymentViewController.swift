//
//  PaymentViewController.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 13.05.2023.
//

import UIKit
import CoreData

class PaymentViewController: UIViewController {

    
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var toLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var hourLabel: UILabel!
    
    @IBOutlet weak var seatLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var mailTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var creditCardNoTextField: UITextField!
    
    @IBOutlet weak var creditCardExpirationDateTextField: UITextField!
    
    @IBOutlet weak var creditCardCCVTextField: UITextField!
    
    
    var ticketModel = TicketModel()
    var cartModel = CartModel()
    
    var text: String!
    var priceText: String!
    
    var name: String!
    var surname: String!
    var email: String!
    var password: String!
    var id: String!
    var payment_user_email: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ödeme Adımına Hoşgeldiniz"
        
        name = UserDefaults.standard.string(forKey: "name")
        surname = UserDefaults.standard.string(forKey: "surname")
        email = UserDefaults.standard.string(forKey: "email")
        id =  UserDefaults.standard.string(forKey: "id")
        password = UserDefaults.standard.string(forKey: "password")
        
        fromLabel.text = ticketModel.fromLocation + "(OTOGAR)"
        toLabel.text = ticketModel.toLocation + "(OTOGAR)"
        dateLabel.text = "\(ticketModel.dateDay)" + " / " + "\(ticketModel.dateMonth)" + " / " + "\(ticketModel.dateYear)"
        priceLabel.text = "\(ticketModel.totalSeatPrice * ticketModel.seatNumbers.count) TL"
        seatLabel.text = String(describing: ticketModel.seatNumbers.sorted().map { String($0) }.joined(separator: ","))
        mailTextField.text = self.email
        nameTextField.text = self.name + " " + self.surname
        hourLabel.text = ticketModel.hour
        
        let name = "Adiniz: \(String(describing: self.name))"
        let surname = "Soyadiniz: \(String(describing: self.surname))"
        let fromText = "Nereden: \(ticketModel.fromLocation)"
        let toText = "Nereye: \(ticketModel.toLocation)"
        let seatText = "Koltuk Numaraları: \(ticketModel.seatNumbers)"
        priceText = "Toplam Fiyat: \(String(describing: priceLabel.text))"
        let moveDate = "Ne zaman: \(ticketModel.dateDay)" + " / " + "\(ticketModel.dateMonth)" + " / " + "\(ticketModel.dateYear)"
        let hourText = "Saat Kaçta: \(ticketModel.hour)"
        let seperator = "\n"
        
        text = name + seperator + surname + seperator + fromText + seperator + toText + seperator + seatText + seperator + priceText + seperator + moveDate + seperator + hourText
        
        
    }
    func checkTextFields() -> Bool {
        
        if phoneNumberTextField.text != ""
            && mailTextField.text != ""
            && nameTextField.text != ""
            && creditCardNoTextField.text != ""
            && creditCardExpirationDateTextField.text != ""
            && creditCardCCVTextField.text != ""
            && creditCardNoTextField.text == "1234 1234 1234 1234"
            && creditCardExpirationDateTextField.text == "12/34"
            && creditCardCCVTextField.text == "123" {
            return true
        }
        
        return false
        
    }
    
    
    @IBAction func safetyPay(_ sender: Any) {
        if checkTextFields() {
            saveData()
            
            let presentTicketViewController = storyboard?.instantiateViewController(withIdentifier: "presentTicketVC") as! PresentTicketsViewController
            presentTicketViewController.modalPresentationStyle = .fullScreen
            navigationController?.setViewControllers([presentTicketViewController], animated: true)
            
        }else {
            self.showAlert(title: "Error", message: "Lütfen bütün alanları doldurun.")
            
        }

        }
    
    func saveData() {
        
        let qrImagePress = generateQrCode(from: text)?.jpegData(compressionQuality: 0.5)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // appdelegate'e erişiyoruz
        let context = appDelegate.persistentContainer.viewContext
        let saveData = NSEntityDescription.insertNewObject(forEntityName: "Ticket", into: context)
        
        saveData.setValue(ticketModel.fromLocation, forKey: "fromLocation")
        saveData.setValue(ticketModel.toLocation, forKey: "toLocation")
        saveData.setValue(ticketModel.seatNumbers, forKey: "seatNumbers")
        saveData.setValue(priceText, forKey: "price")
        saveData.setValue(phoneNumberTextField.text, forKey: "phoneNumber")
        saveData.setValue(ticketModel.dateDay, forKey: "dateDay")
        saveData.setValue(ticketModel.dateMonth, forKey: "dateMonth")
        saveData.setValue(ticketModel.dateYear, forKey: "dateYear")
        saveData.setValue(ticketModel.hour, forKey: "hour")
        saveData.setValue(email, forKey: "user_email")
        saveData.setValue(qrImagePress, forKey: "qrImage")
        
        do {
            try context.save()
            print("Success")
        }catch{
            print("Error")
        }
        
    }
    
    func generateQrCode(from string: String) -> UIImage? {
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            
            filter.setValue(text.data(using: .utf8), forKey: "inputMessage")
            
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
            
        }
        return nil
        
    }
    
    
}

