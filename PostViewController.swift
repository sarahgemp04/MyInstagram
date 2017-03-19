//
//  PostViewController.swift
//  ItsLitstagram
//
//  Created by Sarah Gemperle on 3/12/17.
//  Copyright © 2017 Sarah Gemperle. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UINavigationController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var image: UIImage?
    var caption: String?
    private var imagePicker: UIImagePickerController!
    
    
    //@IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var postView: UIImageView!
    @IBOutlet weak var startOverButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set up UI
        postView.image = self.image
        postButton.layer.cornerRadius = 5
        postButton.layer.borderColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.6).cgColor
        
        selectButton.layer.cornerRadius = 5
        startOverButton.layer.cornerRadius = 5
        selectButton.layer.shadowRadius = 4
        selectButton.layer.shadowColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.6).cgColor
        startOverButton.layer.borderColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.6).cgColor
        
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
    
    
    @IBAction func onSelectImage(_ sender: AnyObject) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func updateUI() {
        if(image == nil) {
            startOverButton.isHidden = true
            postView.isHidden = true
            selectButton.isHidden = false
        } else {
            startOverButton.isHidden = true
            postView.isHidden = true
            selectButton.isHidden = false
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.image = originalImage
        updateUI()
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onPostClick(_ sender: AnyObject) {
        
        //let caption = self.captionField.text
        //let image = postView.image
        
        //PostObject.postUserImage(image: image, withCaption: caption, withCompletion: nil)
        print("called Post")
    }

    @IBAction func editingBegan(_ sender: AnyObject) {
       // self.captionField.textColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)
    }
    
    @IBAction func editingEnd(_ sender: AnyObject) {
        //if(self.captionField.text == "" || self.captionField.text == nil) {
       //     self.captionField.text = "Write a caption..."
        //    self.captionField.textColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)
        
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
