//
//  FeedVC.swift
//  heewapp
//
//  Created by Natthaphat on 7/19/17.
//  Copyright © 2017 Heew. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.posts = []
        
        //SECTION 154-155: Getting data from firebase
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary <String, Any> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Section 156: Display firebase on UI
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
        } else {
            return PostCell()
        }
    }
    
    // Guide:
    
    
   // func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   //     selectedPost = self.post[indexPath.row]
   //     performSegue(withIdentifier: "ProductVC", sender: self)
   //  }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if segue.identifier == "showDetailVC" {
                let selectItem = posts[indexPath.row]
                let destination = segue.destination as! ProductVC
                //selectItem.เมมเบอร์ในคลาส
                destination.viewDetail? = selectItem
                
                
                //destination.postImages = selectItem.imageUrl
                //destination.brands = selectItem.brand
                //destination.prices = selectItem.price
            }
        }
    }
    
}
