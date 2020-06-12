//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by Ali Atakan AKMAN on 11.06.2020.
//  Copyright © 2020 Ali Atakan AKMAN. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }
    
    

    @IBAction func signInClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error") //Firebase'nin kendi error mesajını göstermek için.
                
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else {
            makeAlert(titleInput: "Error", messageInput: "Usernam/Password?")
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            //Firebase de kullanıcı oluşturmak için gerekli olan kod satırı, bu kadar kolay.
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error") //Firebase'nin kendi error mesajını göstermek için.
                    
                }else{
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                }
                
            }
            
        }else{
            
            makeAlert(titleInput: "Error", messageInput: "Usernam/Password?")
            
        }
    }
    
    func makeAlert(titleInput:String , messageInput:String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

