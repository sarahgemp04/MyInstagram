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
    var refreshControl: UIRefreshControl!

    
    static var currentUser: PFUser? = PFUser.current()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Setup Tableview */
        tableView.delegate = self
        tableView.dataSource = self
         self.navigationController?.navigationBar.tintColor = UIColor.init(red:0.91 , green: 0.59 , blue: 0, alpha: 0.9)
        self.tabBarController?.navigationItem.rightBarButtonItem = logoutButton
        self.tabBarController?.navigationItem.leftBarButtonItem?.tintColor = UIColor.init(white: 1, alpha: 0)

        
        
        /* Setup Refresh Control */
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        /* Call method to load in posts*/
        setupPosts()
        
    }
   
    //On refresh for refresh Control.
    func onRefresh() {
        
        self.setupPosts()
        
    }
    
    // Implement the delay method
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    
    func setupPosts() {
        
        ParseClient.sharedInstance.findObjectsInBackground { (posts: [PFObject]?,
            error: Error?) in
            //If successful set posts var.
            if let posts = posts {
                
                self.posts = posts
                print("Inside setup \(self.posts)")
                self.tableView.reloadData()
            self.refreshControl.endRefreshing()
               
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
        performSegue(withIdentifier: "toLogin", sender: self)
       

        
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
