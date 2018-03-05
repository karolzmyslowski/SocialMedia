//
//  DataService.swift
//  SocialMedia
//
//  Created by Karol Zmyslowski on 01.03.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_Base = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = DB_Base
    private var _REF_POSTS = DB_Base.child("posts")
    private var _REF_USERS = DB_Base.child("users")
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_POST_IMAGE: StorageReference{
        return _REF_POST_IMAGES
    }
    
    var REF_USER_CURRENT: DatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: "uid")
        let user = REF_USERS.child(uid!)
        return user
    }
    
    func createFirebaseUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
