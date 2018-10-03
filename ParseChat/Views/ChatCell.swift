//
//  ChatCell.swift
//  ParseChat
//
//  Created by Danny on 9/30/18.
//  Copyright © 2018 Danny Rivera. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var message: String! {
        didSet {
            messageLabel.text = message
        }
    }
    
    var username: String! {
        didSet {
            usernameLabel.text = username
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
