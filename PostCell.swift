//
//  PostCell.swift
//  heewapp
//
//  Created by Natthaphat on 7/19/17.
//  Copyright © 2017 Heew. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var brand: UILabel!  //(caption = brand)
    @IBOutlet weak var price: UILabel!  //(likesLbl = price)
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    } 

    func configureCell(post: Post) {
        self.post = post
        self.brand.text = post.brand
        self.price.text = "\(post.price)"
    }

}
