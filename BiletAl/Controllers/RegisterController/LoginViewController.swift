//
//  LoginViewController.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 9.05.2023.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var passengerModel = PassengerModel()
    var isControl = false
    var isFinished = false
    var iconClick = false
    let imageicon = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageicon.image = UIImage(named: "eye-close")
        
        let contentView = UIView()
        contentView.addSubview(imageicon)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "eye-close")!.size.width, height: UIImage(named: "eye-close")!.size.height)
        
        imageicon.frame = CGRect(x: -10, y: 0, width: UIImage(named: "eye-close")!.size.width, height: UIImage(named: "eye-close")!.size.height)

        passwordTextField.rightView = contentView
        passwordTextField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        imageicon.isUserInteractionEnabled = true
        passwordTextField.isSecureTextEntry = true
        imageicon.addGestureRecognizer(tapGestureRecognizer)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func imageTapped(tapGestureRecognizer:UITapGestureRecognizer) {
        
        let TappedImage = tapGestureRecognizer.view as! UIImageView
        
        if iconClick
        {
            iconClick = false
            TappedImage.image = UIImage(named: "eye-open")
            passwordTextField.isSecureTextEntry = false
        }
        
        else
        {
            iconClick = true
            TappedImage.image = UIImage(named: "eye-close")
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    
    
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        filteredValueFromData()
       
            if isControl {
                
                let homeViewController = storyboard?.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
                homeViewController.passengerModel = passengerModel
                homeViewController.modalPresentationStyle = .fullScreen
                
                navigationController?.setViewControllers([homeViewController], animated: true)
                       
        }
    }
    

    @IBAction func signupButtonClicked(_ sender: Any) {
        let signupNavigationController = storyboard?.instantiateViewController(identifier: "signUpController") as! SignupViewController
        signupNavigationController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(signupNavigationController, animated: true)
    }
    
    private func filteredValueFromData() {
        
        // Core Data verileri Buraya Gelecek
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Passenger")
        //Filtreleme
        
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", argumentArray: [emailTextField.text!,passwordTextField.text!])
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                
                guard let name = result.value(forKey: "name") as? String,
                      let surname = result.value(forKey: "surname") as? String,
                      let email  = result.value(forKey: "email") as? String,
                      let password = result.value(forKey: "password") as? String,
                      let id = result.value(forKey: "id") as? UUID else { return }
                        
                passengerModel.name = name
                passengerModel.surname = surname
                passengerModel.email = email
                passengerModel.id = id
                passengerModel.password = password
                
                UserDefaults.standard.set(name, forKey: "name")
                UserDefaults.standard.set(surname, forKey: "surname")
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(id.uuidString, forKey: "id")
                UserDefaults.standard.set(password, forKey: "password")
                UserDefaults.standard.set(email, forKey: "loggedInEmail") // 23.05.2023 eklendi
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
                isControl = true
            }
            
            if results.isEmpty {
                self.showAlert(title: "Error", message: "Yanlış şifre veya Mail Adresi")
            }
            
        } catch {
            
            isControl = false
            print("Veri çekerken sıkıntı oldu")
            
        }
    }
}
