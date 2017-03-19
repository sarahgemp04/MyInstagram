//
//  User.swift
//  ItsLitstagram
//
//  Created by Sarah Gemperle on 3/11/17.
//  Copyright © 2017 Sarah Gemperle. All rights reserved.
//

import UIKit
import Parse

class User: NSObject {

    var username: String?
    var password: String?
    private var user: PFUser?
    
    init(username: String?, pass: String?) {
        self.username = username
        self.password = pass
        
        let user: PFUser = PFUser()
        user.username = username
        user.password = pass
        
        self.user = user
    }
    
    func parseSignUp(succ: @escaping (Bool) -> (), failure: @escaping (Error) -> ()) {
        
        let pfuser = self.user
        pfuser?.signUpInBackground(block: { (success: Bool, error: Error?) in
            if (success) {
                succ(success)
            } else {
                failure(error!)
            }
        })
    }
    
    func parseLogin(success:@escaping (PFUser) -> (), failure: @escaping (Error) -> () ) {
        PFUser.logInWithUsername(inBackground: self.username!, password: self.password!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print(PFUser.current())
                success(user!)
            } else {
                failure(error!)
            }
            
        }
    }
}
