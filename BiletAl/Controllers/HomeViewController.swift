//
//  HomeViewController.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 10.05.2023.
//

import UIKit
import Lottie

class HomeViewController: UIViewController {


    @IBOutlet weak var fromTextLabel: UITextField!
    @IBOutlet weak var toTextLabel: UITextField!
    @IBOutlet weak var dateTextLabel: UITextField!
    
    var datePicker =  UIDatePicker()
    var toPicker =  UIPickerView()
    var fromPicker =  UIPickerView()
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var locationView: UIView!
    
    var passengerModel = PassengerModel()
    var moveModel = MoveModel()

    
    let cities = ["Adana", "Adıyaman", "Afyonkarahisar", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin", "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkâri", "Hatay", "Isparta", "Mersin", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Kahramanmaraş", "Mardin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Şanlıurfa", "Uşak", "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman", "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"]

    
    var fromLocation = "Adana"
    var toLocation = "Adana"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        datePicker.minimumDate = Date()
        
        guard let name = UserDefaults.standard.string(forKey: "name") else {return}
        guard let surname = UserDefaults.standard.string(forKey: "surname") else {return}
        
        title = "Hoşgeldiniz, " +  name + " " + surname
        
        dateView.layer.cornerRadius = 10
        dateView.layer.borderWidth = 2
        dateView.layer.shadowColor = CGColor(red: 231, green: 70, blue: 70, alpha: 1)
        
        locationView.layer.cornerRadius = 10
        locationView.layer.borderWidth = 2
        
        fromTextLabel.inputView = fromPicker
        fromTextLabel.layer.cornerRadius = 5
        fromTextLabel.layer.borderColor = .none
        fromTextLabel.placeholder = "Lütfen Bir Yer Seçiniz"
        
        toTextLabel.inputView = toPicker
        toTextLabel.layer.cornerRadius = 5
        toTextLabel.layer.borderColor = .none
        toTextLabel.placeholder = "Lütfen Bir Yer Seçiniz"
        
        dateTextLabel.placeholder = "Lütfen Tarih Seçiniz"
                
        createDatePicker()
    }
    
    func setup() {
        
        fromPicker.delegate = self
        fromPicker.dataSource = self
        
        toPicker.delegate = self
        toPicker.dataSource = self
        
        fromPicker.tag = 1
        toPicker.tag = 2
    }
    
    
    func createToolBar() -> UIToolbar {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        return toolbar
    }
    
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        dateTextLabel.textAlignment = .center
        dateTextLabel.inputView = datePicker
        dateTextLabel.inputAccessoryView = createToolBar()
        
    }
    
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        
        self.dateTextLabel.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    func getMoveData() {
        
        let date = datePicker.calendar.dateComponents([.day , .month, .year], from: datePicker.date)
        
        moveModel.fromLocation = fromLocation
        moveModel.toLocation = toLocation
        moveModel.dateDay = date.day!
        moveModel.dateMonth = date.month!
        moveModel.dateYear = date.year!
        
    }
    
    
    @IBAction func findBusTicketButton(_ sender: Any) {
        
        if fromLocation == toLocation {
            self.showAlert(title: "Error", message: "Lütfen farklı şehirler seçiniz.")
        }else {
            getMoveData()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let busViewController = storyboard.instantiateViewController(withIdentifier: "busStoryboard") as! BusViewController
            busViewController.moveModel = moveModel
            busViewController.passengerModel = passengerModel
            busViewController.modalPresentationStyle = .fullScreen
            
            navigationController?.pushViewController(busViewController, animated: true)
            
        }
    }
    
    
    @IBAction func profileButton(_ sender: Any) {
        let profileViewController = storyboard?.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
        profileViewController.modalPresentationStyle = .fullScreen
        navigationController?.setViewControllers([profileViewController], animated: true)
    }
 
}

 
extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
            
        case 1:
            return cities.count
        case 2:
            return cities.count
            
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
            
        case 1:
            return cities[row]
        case 2:
            return cities[row]
            
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        switch pickerView.tag {
            
        case 1:
            fromLocation = cities[row]
            fromTextLabel.text = cities[row]
            fromTextLabel.resignFirstResponder()
        case 2:
            toLocation = cities[row]
            toTextLabel.text = cities[row]
            toTextLabel.resignFirstResponder()
        default:
            return
        }
    }
    
}


