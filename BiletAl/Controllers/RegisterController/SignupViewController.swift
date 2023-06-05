//
//  SignupViewController.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 9.05.2023.
//

import UIKit
import CoreData

class SignupViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
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

    @IBAction func signupButtonClicked(_ sender: Any) {
        // Veri Kaydetme İşlemi
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // appdelegate'e erişiyoruz
        let context = appDelegate.persistentContainer.viewContext
        let saveData = NSEntityDescription.insertNewObject(forEntityName: "Passenger", into: context)
        
        if (nameTextField.text != "" && passwordTextField.text != "" && emailTextField.text != "" && surnameTextField.text != ""){
       
            saveData.setValue(nameTextField.text!, forKey: "name")
            saveData.setValue(surnameTextField.text!, forKey: "surname")
            saveData.setValue(emailTextField.text!, forKey: "email")
            saveData.setValue(passwordTextField.text!, forKey: "password")
            saveData.setValue(UUID(), forKey: "id")
            
            
        } else {
            self.showAlert(title: "Error", message: "Lütfen bütün alanları doldurun.")

        }
        
        
         do {
            try context.save()
                print("Success")
             let loginNavigationController = storyboard?.instantiateViewController(identifier: "loginNavigationController") as! LoginViewController
             loginNavigationController.modalPresentationStyle = .fullScreen
             navigationController?.setViewControllers([loginNavigationController], animated: true)
             
        }catch{
            print("Error")
        }
    }


}
