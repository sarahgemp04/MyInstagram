//
//  User.swift
//  
//
//  Created by Sarah Gemperle on 3/11/17.
//
//

import UIKit
import Parse

class User: PFUser {

    var username: String?
    var password: String?
    
    init(name: String?, pass: String?) {
        self.username = name
        self.password = pass
        
    }
    
    //Sign up function
    static func signUp(username: String?, password: String?, success: (LitstaUser) -> (), failure: (Error?) -> ()) {
        
        print(username)
        print(password)
        
        let newUser = User(username, password)
        
        
        
    }

}
