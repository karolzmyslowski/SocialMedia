//
//  ViewController.swift
//  SocialMedia
//
//  Created by Karol Zmyslowski on 06.02.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FBSDKCoreKit
import SwiftKeychainWrapper

class SingInVC
: UIViewController {
    
    
    @IBOutlet weak var emailField: FancyFT!
    @IBOutlet weak var pwdField: FancyFT!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
    if let _ = KeychainWrapper.standard.string(forKey: "uid"){
        performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
   
    @IBAction func facebookBtnTapper(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, err) in
            if err != nil {
                print("Karol: Unable to authenticate with Facebook")
            } else if result?.isCancelled == true {
                print("Karol: User cancelled Facebook authentication")
            } else {
                print("Karol: Successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
               self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, err) in
            if err != nil {
                print("Karol: Ubanle to authenticate with Firebase")
            } else {
                print("Karol: Successfully authenticated with Firebase")
                if let user = user {
                    let userData = ["provider": credential.provider]
                    self.completeSingIN(id: user.uid, userData: userData)
                }
                
            }
        }
    }

    @IBAction func singInTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("Karol: Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSingIN(id: user.uid, userData: userData)
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("Karol: Unable to authenticate with Firebase")
                        } else {
                            print("Karol: Successfully authenticate with Firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.completeSingIN(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSingIN(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseUser(uid: id, userData: userData)
            KeychainWrapper.standard.set(id, forKey: "uid")
            performSegue(withIdentifier: "goToFeed", sender: nil)
    }
}

