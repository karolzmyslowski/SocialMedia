//
//  PostCell.swift
//  SocialMedia
//
//  Created by Karol Zmyslowski on 15.02.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbn: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    
    var post: Post!
    var likesref: DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likeImg.addGestureRecognizer(tap)
        likeImg.isUserInteractionEnabled = true
        
    }

    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        likesref = DataService.ds.REF_USER_CURRENT.child("like").child(post.postKey)
        self.caption.text = post.caption
        self.likesLbn.text = "\(post.likes)"
        
        if img != nil {
            self.postImg.image = img
        } else {
            let ref = Storage.storage().reference(forURL: post.imageUrl)
            ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Unable to download image from Firebase storage")
                } else {
                    if let imgData = data {
                        if let img = UIImage(data: imgData){
                           self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                        
                    }
                }
            })
        }
        likesref.observeSingleEvent(of: .value) { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "like (1)")
            } else {
                self.likeImg.image = #imageLiteral(resourceName: "like")
            }
        }
    }
    @objc func likeTapped(sender: UITapGestureRecognizer){
        likesref.observeSingleEvent(of: .value) { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = #imageLiteral(resourceName: "like")
                self.post.adjustLikes(addLike: true)
                self.likesref.setValue(true)
            } else {
                self.likeImg.image = UIImage(named: "like (1)")
                 self.post.adjustLikes(addLike: false)
                self.likesref.removeValue()
            }
        }
    }

}
