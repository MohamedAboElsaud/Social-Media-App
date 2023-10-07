//
//  PostCell.swift
//  social Media App
//
//  Created by mohamed ahmed on 13/08/2023.
//

import UIKit

class PostCell: UITableViewCell {

    var tags:[String]=[]
    @IBOutlet weak var postTagCV: UICollectionView!{
        didSet{
            postTagCV.delegate=self
            postTagCV.dataSource=self
        }
    }
    @IBOutlet weak var postReactionsLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var postUserLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var userInfoView: UIView!{
        didSet{
            userInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userInfoViewTapped)))
            
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
    @objc func userInfoViewTapped(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"userInfoViewTapped"), object: nil,userInfo: ["cell" : self])
    }

}
extension PostCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "PostTagCell", for: indexPath) as! PostTagCell
        cell.tagNameLabel.text=tags[indexPath.row]
        return cell
    }
    
    
}
