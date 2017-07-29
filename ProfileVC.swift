//
//  ProfileVC.swift
//  heewapp
//
//  Created by Natthaphat on 7/19/17.
//  Copyright © 2017 Heew. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signOutPressed(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("GUIDE: ID removed from keychain \(keychainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "SignInVC", sender: nil)
    }
    
    
    @IBAction func editContactBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "ContactVC", sender: nil)
    }

}
