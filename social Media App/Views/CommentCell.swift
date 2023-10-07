//
//  CommentCell.swift
//  social Media App
//
//  Created by mohamed ahmed on 17/08/2023.
//

import UIKit

class CommentCell: UITableViewCell {

    
    @IBOutlet weak var userCommentLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
