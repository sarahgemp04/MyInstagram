//
//  InstaCell.swift
//  ItsLitstagram
//
//  Created by Sarah Gemperle on 3/11/17.
//  Copyright © 2017 Sarah Gemperle. All rights reserved.
//

import UIKit
import AFNetworking
import ParseUI

class InstaCell: UITableViewCell {

    var post: PostObject?
    
    @IBOutlet weak var instaImageView: PFImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let likeTapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InstaCell.onLikeTap))
        
        likeImageView.addGestureRecognizer(likeTapRecognizer)
    
    }
    
    func setup() {
        
        if let post = post {
            print("post successfully loaded in instaCell")
            //instaUser?.username = post.author
            instaImageView.file = post.media!
            
            instaImageView.loadInBackground()
            captionLabel.text = post.caption
            
            //handleLabel.text = post.author
            
            print(instaImageView.file)
            likesLabel.text = "\(post.likes) likes"
            if (post.isFavorited) {
                likeImageView.image = #imageLiteral(resourceName: "favor-icon-red")
            } else {
                likeImageView.image = #imageLiteral(resourceName: "favor-icon")
            }
            
        } else {
            //Post has not been initialized yet.
            
        }

    }
    
    func onLikeTap() {
        if(self.post!.isFavorited) {
            likeImageView.image = #imageLiteral(resourceName: "favor-icon")
            post?.likes = post!.likes - 1
            post?.isFavorited = false
            self.likesLabel.text = "\(self.post!.likes) likes"

        } else {
            post?.likes = post!.likes + 1
            post?.isFavorited = true
            self.likesLabel.text = "\(self.post!.likes) likes"
            likeImageView.image = #imageLiteral(resourceName: "favor-icon-red")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }

}
