//
//  LoginViewController.swift
//  ItsLitstagram
//
//  Created by Sarah Gemperle on 3/10/17.
//  Copyright © 2017 Sarah Gemperle. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    var gradient: CAGradientLayer = CAGradientLayer()
    var grad2: CAGradientLayer = CAGradientLayer()
    var colors: [CGColor]?

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var litstaLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Make password field have dots..
        passwordField.isSecureTextEntry = true
        passwordField.backgroundColor = UIColor.white
        userNameField.backgroundColor = UIColor.white
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.borderWidth = 2
        signinButton.layer.borderWidth = 2
        signinButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.zPosition = 100
        signinButton.layer.zPosition = 100
        passwordField.layer.zPosition = 100
        userNameField.layer.zPosition = 100
        litstaLabel.layer.zPosition = 100
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        
        //Cool animated background color
        gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.init(red: 0.93, green: 0.33, blue: 0.82, alpha: 0.8).cgColor, //Pinkish/purple grad
            UIColor.init(red: 0.92, green: 0.67, blue: 0.87, alpha: 0.8).cgColor //Pinkish/purple grad
        ]
        colors = gradient.colors as? [CGColor]
        
        gradient.locations = [
            0.0, // start gradating at top of view
            1.0  // end gradating at bottom of view
        ]
        gradient.frame = view.bounds

        
        grad2 = CAGradientLayer()
        grad2.colors = [
            UIColor.init(red: 0.42, green: 0.91, blue: 0.76, alpha: 0.8).cgColor, //turquoise-green/blue grad
            UIColor.init(red: 0.57, green: 0.72, blue: 0.92, alpha: 0.8).cgColor //Pinkish/purple grad
        ]

        grad2.locations = [
            0.0, // start gradating at top of view
            1.0  // end gradating at bottom of view
        ]
        grad2.frame = view.bounds
        
        print(gradient)
        print(grad2)

        view.layer.addSublayer(grad2)
        
        //startAnimation(index: 0)
        
    }

    /*func startAnimation(index: Int) {
        
        UIView.animate(withDuration: 100000, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            if(index % 2 == 0) {
                self.gradient.colors = self.grad2.colors
            } else {
                self.gradient.colors = self.colors
            }
        }) { (finished) in
            var currentIndex = index + 1
            if currentIndex == 2 { currentIndex = 0 }
            self.startAnimation(index: currentIndex)
        }
    }*/

    @IBAction func dragOutsideTextField(_ sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    @IBAction func onLoginClick(_ sender: AnyObject) {
        
        let user = User(username: userNameField.text, pass:  passwordField.text)

        user.parseLogin(success: { (user: PFUser) in
            print("Success logging in!")
           
            self.performSegue(withIdentifier: "toTabBar", sender: self)
            
            

        }) { (error: Error) in
                print("error logging in")
                print(error.localizedDescription)
        }
        
    }
    
    @IBAction func onSignupClick(_ sender: AnyObject) {
        
        if(userNameField.text == nil || passwordField.text == nil) {
            print("didn't enter name addd a subview later")
            return
        }
        
        let newUser = User(username: userNameField.text, pass: passwordField.text)
        
        
        newUser.parseSignUp(succ: { (result: Bool) in
            if(result) {
                newUser.parseLogin(success: { (user: PFUser) in
                    //call over next view and set its user to current user.
                    print("success signing up and logging in")
                    self.performSegue(withIdentifier: "toTabBar", sender: self)
                    }, failure: { (failure: Error) in
                        print(failure.localizedDescription)
                })
            }
        }) { (error: Error) in
        }
        
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
