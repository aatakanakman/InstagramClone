//
//  FeedViewController.swift
//  InstaCloneFirebase
//
//  Created by Ali Atakan AKMAN on 12.06.2020.
//  Copyright © 2020 Ali Atakan AKMAN. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
        
    }
    
    
    func getDataFromFirestore(){
        
        let fireStoreDatabase = Firestore.firestore()
        
        /*let settings = fireStoreDatabase.settings //Firestore databasein ayarlarını değiştirmek için kullanılan bir yöntem.
        settings.areTimestampsInSnapshotsEnabled = true
        fireStoreDatabase.settings = settings*/
        
        fireStoreDatabase.collection("Posts").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("Error")
            }else{
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    //Database deki dökümanları bize veriyor.
                    for document in snapshot!.documents {
                        let documentId =  document.documentID
                        
                        
                        if let postedBy = document.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String {
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int{
                            self.likeArray.append(likes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.userImageArray.append(imageUrl)
                        }
                    }
                    self.tableView.reloadData()
                    
                    
                }
                
                
                
                
            }
        }
        
        
        
    }
    

    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    //Açtığımız coco sınıfını bu şekilde özel bir cell olarak değişkene atıyoruz. (157. Ders)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.userImageView?.image = UIImage(named: "selectimage.png")
      
        return cell
    }
    
    

}
