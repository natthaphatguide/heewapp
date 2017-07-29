//
//  NotificationVC.swift
//  heewapp
//
//  Created by Natthaphat on 7/26/17.
//  Copyright © 2017 Heew. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var segmented: UISegmentedControl!
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmented.selectedSegmentIndex
        {
        case 0:
            NSLog("Popular selected")
        //show popular view
        case 1:
            NSLog("History selected")
        //show history view
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

}
