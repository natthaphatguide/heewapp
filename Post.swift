//
//  Post.swift
//  heewapp
//
//  Created by Natthaphat on 7/19/17.
//  Copyright © 2017 Heew. All rights reserved.
//

import Foundation

class Post {
        
    private var _imageUrl: String!
    private var _brand: String!
    private var _price: String!
    private var _postKey: String!

    var imageUrl: String {
        return _imageUrl
    }
    
    var brand: String {
        return _brand
    }
    
    var price: String {
        return _price
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(imageUrl: String, brand: String, price: String) {
        self._imageUrl = imageUrl
        self._brand = brand
        self._price = price
    }
    
    init(postKey: String, postData: Dictionary<String,Any>) {
        self._postKey = postKey
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let brand = postData["brand"] as? String {
            self._brand = brand
        }
        
        if let price = postData["price"] as? String {
            self._price = price
        }
        
    }
}
