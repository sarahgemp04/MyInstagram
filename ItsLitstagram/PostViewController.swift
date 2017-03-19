//
//  PostViewController.swift
//  ItsLitstagram
//
//  Created by Sarah Gemperle on 3/12/17.
//  Copyright © 2017 Sarah Gemperle. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var image: UIImage?
    var caption: String?
    private var imagePicker: UIImagePickerController!
   
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var postView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var startOverButton: UIButton!
    @IBOutlet weak var checkImageView: UIImageView!
    
    
      override func viewDidLoad() {
        super.viewDidLoad()
        //Set up UI
        postButton.layer.cornerRadius = 5
        postButton.layer.borderColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.6).cgColor
        postButton.layer.borderWidth = 1
        
        selectButton.layer.borderWidth = 1
        selectButton.layer.borderColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.6).cgColor
        selectButton.layer.cornerRadius = 5
        startOverButton.layer.cornerRadius = 5
        selectButton.layer.shadowRadius = 10
        selectButton.layer.shadowColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.6).cgColor
        checkImageView.image = #imageLiteral(resourceName: "checked-symbol")
        checkImageView.isHidden = true
        self.view.backgroundColor = UIColor.white
        self.tabBarController?.navigationItem.leftBarButtonItem?.tintColor = UIColor.init(white: 1, alpha: 0)
        
        image = nil
        
        
        updateUI()
        
        
        // Set the imagePickerController for selecting images.
        self.imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onStartOver(_ sender: AnyObject) {
        image = nil
        updateUI()
    }
    
    @IBAction func onSelectImage(_ sender: AnyObject) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func updateUI() {
    if(image == nil) {
            startOverButton.isHidden = true
            postView.isHidden = true
            postView.image = nil
            selectButton.isHidden = false
            checkImageView.isHidden = true
        } else {
            startOverButton.isHidden = false
            postView.isHidden = false
            postView.image = self.image
            selectButton.isHidden = true
            checkImageView.isHidden = true
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        print(info)
        guard let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("Guard image fell throug. Can't cast to UIImage")
            dismiss(animated: true, completion: nil)
            return
        }
        self.image = originalImage
        updateUI()
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onPostClick(_ sender: AnyObject) {
        
        let caption = self.captionField.text
        let image = postView.image
        
        //UI show progress while posting.
        //MBProgressHUD.showAdded(to: self.view, animated: true)

        
        ParseClient.postUserImage(image: image, withCaption: caption, withCompletion: nil)
        
        //MBProgressHUD.hide(for: self.view, animated: true)
        
        //UI Show checked arrow.
        showArrow()
            }
    
    func showArrow() {
        checkImageView.isHidden = false
    }
    
    @IBAction func editingBegan(_ sender: AnyObject) {
         self.captionField.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.8)
        self.captionField.text = ""
    }
    
    @IBAction func editingEnd(_ sender: AnyObject) {
        if(self.captionField.text == "" || self.captionField.text == nil) {
             self.captionField.text = "Write a caption..."
            self.captionField.textColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)
        
        }
    }
    
    /*
     // MARK: - Navigatitio
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
