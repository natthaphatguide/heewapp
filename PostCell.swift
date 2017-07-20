//
//  PostCell.swift
//  heewapp
//
//  Created by Natthaphat on 7/19/17.
//  Copyright © 2017 Heew. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var brand: UILabel!  //(caption = brand)
    @IBOutlet weak var price: UILabel!  //(likesLbl = price)
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    } 

    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.brand.text = post.brand
        self.price.text = "\(post.price)"
        
        //Section 158: Downloading files from Firebase Storage
        if img != nil {
            self.postImg.image = img
        } else {
            let ref = Storage.storage().reference(forURL: post.imageUrl)
            ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error !=  nil {
                    print("GUIDE: Unable to download image from Firebase Storage")
                } else {
                    print("GUIDE: Image downloaded from Firebase Storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                }
            })
        }
    }

}
