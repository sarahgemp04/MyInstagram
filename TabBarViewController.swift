//
//  TabBarViewController.swift
//  ItsLitstagram
//
//  Created by Sarah Gemperle on 3/17/17.
//  Copyright © 2017 Sarah Gemperle. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.items![0].title = "Your Feed"
        self.tabBar.items![0].image = #imageLiteral(resourceName: "home-icon")
        self.tabBar.items![1].title = "Post"
        self.tabBar.items![1].image = #imageLiteral(resourceName: "image-add-button")
        self.tabBar.items![2].title = "Profile"
        self.tabBar.items![2].image = #imageLiteral(resourceName: "profile-icon")
        
       print("Is it cast or not?? \(self.viewControllers![1])")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
