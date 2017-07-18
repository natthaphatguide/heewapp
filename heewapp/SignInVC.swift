//
//  SignInVC.swift
//  heewapp
//
//  Created by Natthaphat on 7/18/17.
//  Copyright © 2017 Heew. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    //FACEBOOK AUTHENTICATION
    @IBAction func facebookBtnPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) {(result, error) in
            
            if error != nil {
                print("GUIDE: Unable to authenticate with Facebook -\(error)")
            } else if result?.isCancelled == true {
                print("GUIDE: User   authenticate with Facebook")
            } else {
                print("GUIDE: Successfully authenticate with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential, completion: {(user, error) in
            
            if error != nil {
                print("GUIDE: Unable to authenticate with Firebase/Facebook -\(error)")
            } else {
                print("GUIDE: Successfully authenticate with Firebase/Facebook")
            }
        })
    }
        
}

