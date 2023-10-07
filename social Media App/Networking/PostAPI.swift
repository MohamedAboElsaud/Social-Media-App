//
//  PostAPI.swift
//  social Media App
//
//  Created by mohamed ahmed on 24/08/2023.
//

import Foundation
import Alamofire
import SwiftyJSON
class PostAPI{
    static let BaseURL="https://dummyjson.com/"
    static func getAllPosts(page:Int,limited:Int,tag:String?,completionHundler:@escaping ([Post],Int)->()){
        
        var URL=BaseURL+"posts"
        if let myTag=tag{
        URL+="/search?q=\(myTag)"
            
        }
        let params=[
            "page":String(page),
            "limit":String(limited)
        ]
        
        AF.request(URL,parameters: params,encoder: URLEncodedFormParameterEncoder.default).responseJSON{
            response in
            let jsonData=JSON(response.value)
            let posts=jsonData["posts"]
            let total=jsonData["total"].intValue
            let decoder=JSONDecoder()
            do{
                let posts=try decoder.decode([Post].self, from: posts.rawData())
                completionHundler(posts,total)
            }catch let error{
                print(error)
            }
        }
    }
    static func getPostComments(id:Int,completionHundler:@escaping([Comment])->()){
        let userUrl=BaseURL+"posts/"+String(id)+"/comments"
        AF.request(userUrl).responseJSON{
            response in
            let jsonData=JSON(response.value)
            let comments=jsonData["comments"]
            print(comments)
            
            let decoder=JSONDecoder()
            do{
                let comments=try decoder.decode([Comment].self, from: comments.rawData())
                
                completionHundler(comments)
            }catch let error{
                print(error)
            }}
        
    }
    
    static func createComment(userId:String,postId:String,message:String,completionHundler:@escaping (Comment?,String?)->() ){
        
        let userUrl=BaseURL+"comments/add"
        let params=[
            "userId": userId,
            "postId": postId,
            "body": message
        ]
        AF.request(userUrl,method: .post,parameters: params,encoder: JSONParameterEncoder.default).validate().responseJSON{
            response in
            switch response.result{
            case .success:
                let jsonData=JSON(response.value)
                
                let decoder=JSONDecoder()
                do{
                    let comment=try decoder.decode(Comment.self, from: jsonData.rawData())
                    print(comment)
                    completionHundler(comment,nil)
                }catch let error{
                    print(error)
                }
                
            case .failure(let error):
                let jsonData=JSON(response.data)
                let data=jsonData["data"]
                let err=jsonData.stringValue
                completionHundler(nil,"error"+err)
                
            }
            
        }
    }
    
}
