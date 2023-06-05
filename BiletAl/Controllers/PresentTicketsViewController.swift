//
//  PresentTicketsViewController.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 18.05.2023.
//

import UIKit
import CoreData

class PresentTicketsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var count: Int!
    var fromText: String!
    var toText: String!
    var hourText: String!
    var dateDayText: Int!
    var dateYearText: Int!
    var dateMonthText: Int!
    var priceText: Int!
    var phoneNumberText: String!
    var qrImage: UIImage!
    var seatNumbers: [Int]!
    var ticketModel = TicketModel()
    var qrImageModel = QrModel()
    var name: String!
    var surname: String!
    var email: String!
    var password: String!
    var id: String!
    
    var ticketModelArray = [TicketModel]()
    var qrImageModelArray = [QrModel]()
    
    
    override func  viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "🎟️ Biletlerinize Aşağıdan Ulaşabilirsiniz 🎟️"
        
        let nib = UINib(nibName: "CustomTicketsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        name = UserDefaults.standard.string(forKey: "name")
        surname = UserDefaults.standard.string(forKey: "surname")
        email = UserDefaults.standard.string(forKey: "email")
        id =  UserDefaults.standard.string(forKey: "id")
        password = UserDefaults.standard.string(forKey: "password")
        
        getData()
        
    }
    
    
    @IBAction func backToHomePage(_ sender: Any) {
        let homeViewController = storyboard?.instantiateViewController(identifier: "homeViewController") as! HomeViewController
        homeViewController.modalPresentationStyle = .fullScreen
        navigationController?.setViewControllers([homeViewController], animated: true)
    }
    
    func getData(){
        if let loggedInEmail = UserDefaults.standard.string(forKey: "loggedInEmail"){
            // Burada loggedInEmail değeri kullanıcının oturum açtığı email adresini temsil ediyor
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            // CoreData'den kayıtları almak için gerekli işlemleri yapın (Örnek olarak bir NSFetchRequest kullanacağız)
            let fetchRequest: NSFetchRequest<Ticket> = Ticket.fetchRequest()
            let predicate = NSPredicate(format: "user_email == %@", loggedInEmail)
            fetchRequest.predicate = predicate
            
            do {
                let results = try context.fetch(fetchRequest)
                count = results.count
                for result in results as [NSManagedObject] { 
                    
                    if let fromLocation = result.value(forKey: "fromLocation") as? String {
                        fromText = fromLocation
                    }
                    if let toLocation = result.value(forKey: "toLocation") as? String {
                        toText = toLocation
                    }
                    if let dateDay = result.value(forKey: "dateDay") as? Int {
                        dateDayText = dateDay
                    }
                    if let dateMonth = result.value(forKey: "dateMonth") as? Int {
                        dateMonthText = dateMonth
                    }
                    if let dateYear = result.value(forKey: "dateYear") as? Int {
                        dateYearText = dateYear
                    }
                    if let qrImageimage = result.value(forKey: "qrImage") as? Data {
                        qrImage = UIImage(data: qrImageimage)
                    }
                    if let moveHour = result.value(forKey: "hour") as? String {
                        hourText = moveHour
                    }
                    if let seatText = result.value(forKey: "seatNumbers") as? [Int]{
                        seatNumbers = seatText
                    }
                    if let phoneText = result.value(forKey: "phoneNumber") as? String{
                        phoneNumberText = phoneText
                    }
                    setupTicket()
                    
                }
                
            } catch {
                
            }
            
            
        }
        
        func setupTicket() {
            
            ticketModel = TicketModel(fromLocation: fromText,
                                      toLocation: toText,
                                      dateDay: dateDayText,
                                      dateMonth: dateMonthText,
                                      dateYear: dateYearText,
                                      seatNumbers: seatNumbers,
                                      passenger: PassengerModel(name: name ,surname: surname ,email: email ,password: password,id: UUID(uuidString: id)!),
                                      hour: hourText)
            qrImageModel = QrModel(qrImage: self.qrImage)
            
            ticketModelArray.append(ticketModel)
            qrImageModelArray.append(qrImageModel)
            
        }
        
        
        
    }
}

extension PresentTicketsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTicketsTableViewCell
        
        cell.setup(ticketModelArray.reversed()[indexPath.row], qrImageModelArray.reversed()[indexPath.row])
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 180
    }
    
}
