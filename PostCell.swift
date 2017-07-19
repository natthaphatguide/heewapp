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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    } 

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
