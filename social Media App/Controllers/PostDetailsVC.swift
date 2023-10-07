//
//  PostDetailsVC.swift
//  social Media App
//
//  Created by mohamed ahmed on 17/08/2023.
//

import UIKit
import Alamofire
import SwiftyJSON
class PostDetailsVC: UIViewController {
    var post:Post! = nil
    var user:User! = nil
    var postId:Int = 1
    var commentsArray:[Comment]=[]
    
    @IBOutlet weak var sendButtonOutlet: UIButton!
    @IBOutlet weak var messageCommentUserPost: UITextField!
    @IBOutlet weak var tableViewComment: UITableView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postUserNameLabel: UILabel!
    @IBOutlet weak var PostUserPicture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewComment.delegate=self
        tableViewComment.dataSource=self
        DispatchQueue.global().async {
            [weak self] in
            
            PostAPI.getPostComments(id: self!.postId) {  comments in
                self?.commentsArray=comments
                self?.tableViewComment.reloadData()
            }
        }
        
        //        postUserNameLabel.text=user.firstName
        postTextLabel.text=post.body
        postTitleLabel.text=post.title
        if UserManager.userInLogged==nil{
            sendButtonOutlet.isHidden=true
            messageCommentUserPost.isHidden=true
            
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func commentSendButton(_ sender: Any) {
        PostAPI.createComment(userId: String((UserManager.userInLogged?.id!)!), postId:String( self.postId), message: messageCommentUserPost.text!) { comment, error in
            if comment != nil{
                let alert=UIAlertController(title: "succes", message: "created new comment" ,preferredStyle: .alert)
                let action=UIAlertAction(title: "Ok", style: .default,handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true)
                self.commentsArray.append(comment!)
                self.tableViewComment.reloadData()
                
            }else{
                let alert=UIAlertController(title: "fail", message: error!, preferredStyle: .alert)
                let action=UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)

            }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
extension PostDetailsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count
        print(commentsArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellComment=tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        cellComment.userNameLabel.text=commentsArray[indexPath.row].user.username
        cellComment.userCommentLabel.text=commentsArray[indexPath.row].body
        
        return cellComment
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 129
    }
    
}
