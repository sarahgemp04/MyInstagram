//
//  PostObject.swift
//  ItsLitstagram
//
//  Created by Sarah Gemperle on 3/12/17.
//  Copyright © 2017 Sarah Gemperle. All rights reserved.
//

import UIKit
import Parse

class ParseClient {
    
    static let sharedInstance = PFQuery(className: "Post")
    var posts: [PFObject]?
    static var returnPosts: [PFObject]?

    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        
        let post = PFObject(className: "Post")
        print("This is post \(post)")
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["author"] = PFUser.current()// Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        post["isFavorited"] = false
        
        // Save object (following function will save the object in Parse asynchronously)
        print("Made it in post")
        post.saveInBackground(block: completion)
        
    }
    
        
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            print("Made it to getPFFile")
            // get image data and check if that is not nil
            if let imageData = UIImageJPEGRepresentation(image, 0.7) {
                print(imageData)
                
                return PFFile(name: "image.jpg", data: imageData)
            }
        }
        return nil
    }
    
    
    
    
}

