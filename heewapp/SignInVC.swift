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
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("GUIDE: ID found in keychain")
            performSegue(withIdentifier: "FeedVC", sender: nil)
        }
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
                print("GUIDE: Successfully authenticated with Firebase/Facebook")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
        })
    }
    
    // FIREBASE AUTHENTICATION
    @IBAction func signInPressed(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("GUIDE: Successfully email user authenticated with Firebase (Sign in)")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    // SIGNUP FIREBASE
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("GUIDE: Unable to authenticate with Firebase using email -\(error)")
                        } else {
                            print("GUIDE: Successfully email user authenticated with Firebase (Sign up)")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("GUIDE: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "FeedVC", sender: nil)
    }
}

