//
//  UploadViewController.swift
//  InstaCloneFirebase
//
//  Created by Ali Atakan AKMAN on 12.06.2020.
//  Copyright © 2020 Ali Atakan AKMAN. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Kullanıcı resimle etkileşimi ve resim seçme.
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
    }
    
    
    //Upload işlemleri
    @IBAction func uploadBtnClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        //Resmi sıkıştırarak data ya dönüştürmek için kullanılır.
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString  // String şeklinde unic ıd
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    //Resmin kayıt olduğu url adresini görmek için yapılan işlemler.
                    imageReference.downloadURL { (url, error) in
                        
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            
                            
                            
                            //DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference? = nil
                            let firestorePost = ["imageUrl": imageUrl! , "postedBy": Auth.auth().currentUser!.email , "postComment" : self.commentTextField.text!, "date" : FieldValue.serverTimestamp() , "likes" : 0] as [String : Any]  // Dictionary oluştuurupyruz ve mevcut kullanıcının e mailini kaydediyoruz.
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost , completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                }else {
                                    
                                    self.imageView.image = UIImage(named: "selectImage.jpg")
                                    self.commentTextField.text = ""
                                    self.tabBarController?.selectedIndex = 0  //Tabbar daki index
                                    
                                    
                                }
                            })
                            
                            
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
      
        
    }
    
    
    @objc func selectImage(){
           
           let picker = UIImagePickerController()   //Toplayıcı oluşturuyoruz.
           picker.delegate = self
           picker.sourceType = .photoLibrary
           picker.allowsEditing = true
           present(picker, animated: true, completion: nil)
           
       }
       
        //Resim seçtikten sonra olan fonksiyon.
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

           imageView.image = info[.originalImage] as? UIImage
           
           self.dismiss(animated: true, completion: nil)
       }
       
       func makeAlert(titleInput:String , messageInput:String){
           
           let alert = UIAlertController(title:titleInput , message: messageInput, preferredStyle: UIAlertController.Style.alert)
           let okButton = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil)
           alert.addAction(okButton)
           self.present(alert, animated: true, completion: nil)
          
           
       }
    
    
}
