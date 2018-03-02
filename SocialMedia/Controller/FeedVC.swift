//
//  FeedVC.swift
//  SocialMedia
//
//  Created by Karol Zmyslowski on 13.02.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value) { (snapshot) in
            print(snapshot.value ?? "Error")
        }
    }


    @IBAction func singOutTapped(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: "uid")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSingIn", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
