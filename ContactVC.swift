//
//  ContactVC.swift
//  heewapp
//
//  Created by Natthaphat on 7/26/17.
//  Copyright © 2017 Heew. All rights reserved.
//

import UIKit

class ContactVC: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var birthDayField: UITextField!
    
    @IBOutlet weak var addressField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        //Update userdata in firebase
    }
    
}
