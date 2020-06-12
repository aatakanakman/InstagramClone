//
//  FeedCell.swift
//  InstaCloneFirebase
//
//  Created by Ali Atakan AKMAN on 12.06.2020.
//  Copyright © 2020 Ali Atakan AKMAN. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    @IBAction func likeBtnClicked(_ sender: Any) {
        
        
        
    }
    
}
