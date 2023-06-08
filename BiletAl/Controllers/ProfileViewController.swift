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

