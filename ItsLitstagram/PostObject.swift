//
//  PostObject.swift
//  ItsLitstagram
//
//  Created by Sarah Gemperle on 3/17/17.
//  Copyright © 2017 Sarah Gemperle. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostObject: NSObject {
    
    var author: String?
    var media: PFFile?
    var caption: String?
    var likes: Int = 0
    var comments: Int = 0
    var isFavorited: Bool = false
    var id: String?
    
    init( media: PFFile!, caption: String?) {
        super.init()
        
        self.media = media
        self.caption = caption
    }
    
    func setLikes(likes: Int) {
        self.likes = likes
    }
    
    func setComments(comments: Int) {
        self.comments = comments
    }
    
    func setFavStatus(bool: Bool) {
        isFavorited = bool
    }
}
