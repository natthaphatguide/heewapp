//
//  PostVC.swift
//  heewapp
//
//  Created by Natthaphat on 7/19/17.
//  Copyright © 2017 Heew. All rights reserved.
//

import UIKit
import Firebase

class PostVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageAdd: UIImageView!
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    
    var imageSelected = false
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageAdd.image = image
            imageSelected = true
        } else {
            print ("GUIDE: A valide image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func addImagePressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    //Section 159: Upload/Post data
    @IBAction func postBtnPressed(_ sender: Any) {
        
        guard let brand = brandField.text, brand != "" else {
            print("GUIDE: Brand must be entered")
            return
        }
        
        guard let price = priceField.text, price != "" else {
            print("GUIDE: Price must be entered")
            return
        }
        
        guard let img = imageAdd.image, imageSelected == true else {
            print("GUIDE: Image must be selected")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            let imgUid = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMAGES.child(imgUid).putData(imgData, metadata: metadata, completion: { (metadata, error) in
                if error != nil {
                    print("GUIDE: Unable to upload image to Firebase Storage")
                } else {
                    print("GUIDE: Successfully uploaded image to Firebase Storage")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        self.postToFirebase(imgUrl: url)
                    }
                }
            })
        }
        
    }
    
    //Section160: Make post works
    func postToFirebase(imgUrl:String) {
        
        let post: Dictionary<String, Any> = [
            "imageUrl": imgUrl,
            "brand": brandField.text!,
            "price": 0           //How to post number??
        ]
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        imageSelected = false
        imageAdd.image = UIImage(named: "placeholder")
        brandField.text = ""
        priceField.text = ""
        
        //tableView.reloadData()
        
    }
    
    
    
    
}


