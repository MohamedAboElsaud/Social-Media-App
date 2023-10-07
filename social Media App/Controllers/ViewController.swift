//
//  ViewController.swift
//  social Media App
//
//  Created by mohamed ahmed on 13/08/2023.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
    let url="https://dummyjson.com/"
    
    var postsArray:[Post]=[]
    var page=0
    var limited=20
    var total=0
    var tag:String?
    @IBOutlet weak var welcomeUser: UILabel!
    @IBOutlet weak var postsTableView: UITableView!
    
    @IBOutlet weak var closeButtonOutlet: UIButton!
    @IBOutlet weak var tagNameLabel: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        postsTableView.delegate=self
        postsTableView.dataSource=self
        
        NotificationCenter.default.addObserver(self, selector: #selector(userProfileTapped), name: NSNotification.Name(rawValue: "userInfoViewTapped"), object: nil)
        
        if let user = UserManager.userInLogged{
            welcomeUser.text="Welcome: "+user.firstName+user.lastName
        }
        if let myTag=tag{
            tagNameLabel.text=myTag
        }else{
            closeButtonOutlet.isHidden=true
            tagNameLabel.isHidden=true

        }
        
        // Do any additional setup after loading the view.
        getPosts()
    }
    func getPosts(){
        PostAPI.getAllPosts(page: page, limited: limited,tag: tag) { posts ,total in
            self.total=total
            self.postsArray.append(contentsOf: posts)
            self.postsTableView.reloadData()
        }
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    @objc func userProfileTapped(notification:Notification){
        if let cell=notification.userInfo?["cell"] as? UITableViewCell{
            if let indexPath=postsTableView.indexPath(for: cell){
                let post=postsArray[indexPath.row].userId
                print(post)
                let vc=storyboard?.instantiateViewController(identifier: "ProfileVC") as! ProfileVC
                vc.userid=post
                present(vc, animated: true)
            }
        }
    }
    
    @IBAction func Login_out(_ sender: Any) {
    dismiss(animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="logoutsegue"{
            UserManager.userInLogged=nil
        }
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        //post image
//       var x=String(self.postsArray[indexPath.row].reactions)
//        DispatchQueue.global().async {
//            if let url=URL(string: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/29.jpg"){
//                let imageData=(try?Data(contentsOf: url))!
//                let image=UIImage(data: imageData)
//                DispatchQueue.main.async {
//                    [weak self] in
//                    cell.postImageView.image=image
//                    cell.postReactionsLabel.text=x
//
//                }
//            }
//        }
        
        cell.postTitleLabel.text=postsArray[indexPath.row].title
        cell.tags=postsArray[indexPath.row].tags
        
        let userUrl=url+"users/"+String(postsArray[indexPath.row].userId)
        print(userUrl)
        DispatchQueue.global().async {
            [weak self] in
            let id=self!.postsArray[indexPath.row].userId
            UserAPI.getUserInfo(id: id) { user in
                DispatchQueue.main.async {
                    [weak self] in
                    cell.postUserLabel.text=user.firstName
                    cell.userImageView.setImageFromStringUrl(stringUrl: user.image!)
                    cell.userImageView.layer.cornerRadius=cell.userImageView.frame.width/2
                    cell.userImageView.makeCirclarImage()
                    
                }
            }
     
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 660
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let st=storyboard?.instantiateViewController(identifier: "PostDetailsVC") as! PostDetailsVC
        st.postId=postsArray[indexPath.row].id
        st.post=postsArray[indexPath.row]
        present(st, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row==postsArray.count-1 && postsArray.count<total{
            page+=1
            getPosts()
        }
    }
}

