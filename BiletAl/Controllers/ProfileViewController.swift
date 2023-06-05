//
//  ProfileViewController.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 21.05.2023.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var ticketsButton: UIButton!
    @IBOutlet weak var logOffButton: UIButton!
    
    var name: String!
    var surname: String!
    var email: String!
    var id: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name = UserDefaults.standard.string(forKey: "name")
        surname = UserDefaults.standard.string(forKey: "surname")
        email = UserDefaults.standard.string(forKey: "email")
        
        
        fillInformation()
    }
    
    
    @IBAction func ticketsButtonClicked(_ sender: Any) {
        let presentTicketViewController = storyboard?.instantiateViewController(withIdentifier: "presentTicketVC") as! PresentTicketsViewController
        presentTicketViewController.modalPresentationStyle = .overFullScreen
        presentTicketViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.setViewControllers([presentTicketViewController], animated: true)
    }
    
    @IBAction func logOffButtonClicked(_ sender: Any) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
        
    }
    
    func fillInformation(){
        
        if let loggedInEmail = UserDefaults.standard.string(forKey: "loggedInEmail") {            
            nameTextField.text = self.name
            surnameTextField.text = self.surname
            emailTextField.text = self.email
        }
    }
}











/*
@IBOutlet weak var showTicketsButton: UIButton!

@IBOutlet weak var showTicketButton2: UIButton!



override func viewDidLoad() {
    super.viewDidLoad()
    //setupUI()
    // Do any additional setup after loading the view.
}



@IBAction func showTicketButton2Clicked(_ sender: Any) {
    
    fetchTicketsForLoggedInEmail()
}


func fetchTicketsForLoggedInEmail(){
    if let loggedInEmail = UserDefaults.standard.string(forKey: "loggedInEmail") {
        // Burada loggedInEmail değeri kullanıcının oturum açtığı email adresini temsil ediyor

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // CoreData'den kayıtları almak için gerekli işlemleri yapın (Örnek olarak bir NSFetchRequest kullanacağız)
        let fetchRequest: NSFetchRequest<Ticket> = Ticket.fetchRequest()
        let predicate = NSPredicate(format: "user_email == %@", loggedInEmail)
        fetchRequest.predicate = predicate
        
        do {
            let ticketRecords = try context.fetch(fetchRequest)
            
            // Eşleşen kayıtları ekrana yazdırma
            for ticket in ticketRecords {
                print("From: \(ticket.fromLocation)")
                print("To: \(ticket.toLocation)")
                print("Day: \(ticket.dateDay)")
                print("Month: \(ticket.dateMonth)")
                print("Year: \(ticket.dateYear)")
                //print("Seat Numbers: \(ticket.seatNumbers)")
                //print("Seat Price: \(ticket.totalSeatPrice)")
                print("Hour: \(ticket.hour)")
                print("Email: \(ticket.user_email)")
                // Diğer özellikleri de burada yazdırabilirsiniz
                print("----------------------")
            }
        } catch {
            print("Kayıt alınamadı: \(error.localizedDescription)")
        }
    } else {
        print("Oturum açılmamış")
    }
}

//showTicketButton
/*
 var passengers: [NSManagedObject] = []
 var tickets: [NSManagedObject] = []
 
 
 
 
 @IBAction func showTicketsButtonTapped(_ sender: Any) {
 fetchPassengers()
 printPassengers()
 }
 
 func setupUI() {
 showTicketsButton.setTitle("Show Passengers", for: .normal)
 showTicketsButton.addTarget(self, action: #selector(showTicketsButtonTapped), for: .touchUpInside)
 showTicketsButton.translatesAutoresizingMaskIntoConstraints = false
 
 view.addSubview(showTicketsButton)
 
 NSLayoutConstraint.activate([
 showTicketsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
 showTicketsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
 ])
 }
 
 func fetchPassengers() {
 guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
 return
 }
 let managedContext = appDelegate.persistentContainer.viewContext
 
 //let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Passenger")
 let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Ticket")
 
 do {
 tickets = try managedContext.fetch(fetchRequest)
 //passengers = try managedContext.fetch(fetchRequest)
 } catch let error as NSError {
 print("Could not fetch data: \(error), \(error.userInfo)")
 }
 }
 
 
 func printPassengers() {
 
 /*
  for passenger in passengers {
  let name = passenger.value(forKey: "name") as? String ?? ""
  let surname = passenger.value(forKey: "surname") as? String ?? ""
  let email = passenger.value(forKey: "email") as? String ?? ""
  
  print("Name: \(name), Surname: \(surname), Email: \(email)")
  }
  */
 for ticket in tickets {
 let fromLocation = ticket.value(forKey: "fromLocation") as? String ?? ""
 let toLocation = ticket.value(forKey: "toLocation") as? String ?? ""
 let dateDay = ticket.value(forKey: "dateDay") as? Int ?? 0
 let dateMonth = ticket.value(forKey: "dateMonth") as? Int ?? 0
 let dateYear = ticket.value(forKey: "dateYear") as? Int ?? 0
 let seatNumbers = ticket.value(forKey: "seatNumbers") as? [Int] ?? []
 let totalSeatPrice = ticket.value(forKey: "totalSeatPrice") as? Int ?? 0
 //let passengerName = ticket.value(forKeyPath: "passengerModel.name") as? String ?? ""
 //let passengerSurname = ticket.value(forKeyPath: "passengerModel.surname") as? String ?? ""
 //let passengerEmail = ticket.value(forKeyPath: "passengerModel.email") as? String ?? ""
 let hour = ticket.value(forKey: "hour") as? String ?? ""
 let user_email = ticket.value(forKey: "user_email") as? String ?? ""
 
 /*
  let passenger = Passenger(name: passengerName, surname: passengerSurname, email: passengerEmail, password: "", id: UUID())
  let ticket = Ticket(fromLocation: fromLocation, toLocation: toLocation, dateDay: dateDay, dateMonth: dateMonth, dateYear: dateYear, seatNumbers: seatNumbers, totalSeatPrice: totalSeatPrice, passengerModel: passenger, hour: hour)
  */
 
 
 print("From: \(fromLocation), To: \(toLocation), Date: \(dateDay)/\(dateMonth)/\(dateYear), Seat Numbers: \(seatNumbers), Total Seat Price: \(totalSeatPrice),  Hour: \(hour), Email: \(user_email)")
 //printTicket(ticket)
 // Passenger: \(passengerName) \(passengerSurname) (\(passengerEmail)),
 }
 }
 */
*/
