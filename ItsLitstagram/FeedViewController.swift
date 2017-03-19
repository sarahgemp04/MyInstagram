//
//  FeedViewController.swift
//  ItsLitstagram
//
//  Created by Sarah Gemperle on 3/11/17.
//  Copyright © 2017 Sarah Gemperle. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    var posts: [PFObject]?
    
    static var currentUser: PFUser? = PFUser.current()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Setup Tableview */
        tableView.delegate = self
        tableView.dataSource = self
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor.init(red:0.91 , green: 0.59 , blue: 0.93, alpha: 0.9)
        
        /* Call method to load in posts*/
        setupPosts()
        
    }
   
    func setupPosts() {
        
        ParseClient.sharedInstance.findObjectsInBackground { (posts: [PFObject]?,
            error: Error?) in
            //If successful set posts var.
            if let posts = posts {
                
                self.posts = posts
                print("Inside setup \(self.posts)")
                self.tableView.reloadData()
               
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func addedPostReload() {
        self.setupPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "instaCell") as! InstaCell
        
        print("Inside tableView func \(self.posts)")
        
        if let posts = posts {
            let post = posts[indexPath.row]
            let newPost: PostObject = PostObject( media: post["media"] as! PFFile, caption: post["caption"] as? String)
            
            newPost.setLikes(likes: post["likesCount"] as! Int)
            newPost.setFavStatus(bool: post["isFavorited"] as! Bool)
            
            cell.post = newPost
            cell.setup()
            
        } else {
            print("Posts count is 0!!")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return number of posts
        if let posts = posts{
            print("Printing count \(posts.count)")
            return posts.count
        } else {
            return 0
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(_ sender: AnyObject) {
        PFUser.logOutInBackground { (error: Error?) in
            //Logout -> set PFCurrentUser to nil
        }
        //Send user back to login screen once logged out.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "loginViewController")
        self.present(vc, animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
