//
//  ProductVC.swift
//  heewapp
//
//  Created by Natthaphat on 7/22/17.
//  Copyright © 2017 Heew. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

class ProductVC: UIViewController {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var carryFee: UILabel!
    @IBOutlet weak var category: UILabel!
    
    var viewDetail: Post?
    
    //var postImages: UIImage?
    //var brands: String?
    //var prices: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //postImage.image = viewDetail?.imageUrl
        brand.text = viewDetail.brand
        price.text = viewDetail.price
        
        //1. REQUEST PERMISSION
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    
    @IBAction func requestBtnPressed(_ sender: Any) {
        //PENDING#1. sending notification to seeker/carrier
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error scheduling notification")
            }
        })
        
        //PENDING#2: alert to user that process is completed
            //all guard for all fields
        let alert = UIAlertController(title: "สำเร็จ", message: "คำขอให้เช็คสินค้าได้ถูกส่งไปยังผู้หิ้วแล้ว", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
            //Same VC to continue on PENDING 3 and 4
            //PENDING#3: showing the status
        
                //status.isHidden = false
        
            //PENDING#4: adding amount of request (seeker) +1
        
                //
                //amount.requestCheckAmount +1
        
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
        let notif = UNMutableNotificationContent()
        
        //Only for extension step 3
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "New Notification"
        notif.subtitle = "There are great!"
        notif.body = "The new notification option is in iOS 10"
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error)
                completion(false)
            } else {
                print("GUIDE: notification is sent")
                completion(true)
            }
        })
        
    }

    
}
