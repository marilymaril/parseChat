//
//  ChatCell.swift
//  chatRoom
//
//  Created by Marilyn Florek on 10/1/18.
//  Copyright © 2018 Marilyn Florek. All rights reserved.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var messageTextField: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var bubbleTrailing: NSLayoutConstraint!
    @IBOutlet weak var bubbleLeading: NSLayoutConstraint!
    
    var chat: Message! {
        didSet {
            if chat.text != nil {
                messageTextField.text = chat.text
                if let user = chat.user {
                    self.usernameLabel.text = user.username
                } else {
                    // No user found, set default username
                    self.usernameLabel.text = "🤖"
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        bubbleView.layer.cornerRadius = 16
        bubbleView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
