//
//  UserAPI.swift
//  social Media App
//
//  Created by mohamed ahmed on 24/08/2023.
//

import Foundation
import Alamofire
import SwiftyJSON
class UserAPI:PostAPI{
    static func getUserInfo(id:Int,completionHundler:@escaping (User)->()){
        let userUrl=BaseURL+"users/"+String(id)
        AF.request(userUrl).responseJSON{
            response in
            let jsonData=JSON(response.value)
            
            let decoder=JSONDecoder()
            do{
                let user=try decoder.decode(User.self, from: jsonData.rawData())
                
                completionHundler(user)
            }catch let error{
                print(error)
            }
        }
    }
    
    static func createUser(firstName:String,lastName:String,email:String,completionHundler:@escaping (User?,String?)->() ){
        
        let userUrl=BaseURL+"users/add"
        let params=[
            "firstName": firstName,
            "lastName": lastName,
            "email": email
        ]
        AF.request(userUrl,method: .post,parameters: params,encoder: JSONParameterEncoder.default).validate().responseJSON{
            response in
            switch response.result{
            case .success:
                let jsonData=JSON(response.value)
                
                let decoder=JSONDecoder()
                do{
                    let user=try decoder.decode(User.self, from: jsonData.rawData())
                    print(user)
                    completionHundler(user,nil)
                }catch let error{
                    print(error)
                }
                
            case .failure(let error):
                let jsonData=JSON(response.data)
                let data=jsonData["data"]
                let email=data["email"].stringValue
                print("error",email)
                completionHundler(nil,"error"+email)
                
            }
            
        }
    }
    static func getUser(firstName:String,lastName:String,completionHundler:@escaping (User?,String?)->() ){
        
        let userUrl=BaseURL+"users"
        AF.request(userUrl).validate().responseJSON{
            response in
            switch response.result{
            case .success:
                let jsonData=JSON(response.value)
                let jsonUsers=jsonData["users"]
                let decoder=JSONDecoder()
                do{
                    let users=try decoder.decode([User].self, from: jsonUsers.rawData())
                    var userfounded:User?
                    for user in users{
                        if user.firstName==firstName&&user.lastName==lastName{
                           userfounded=user
                            completionHundler(user,nil)
                            break
                            
                        }
                    }
                    if userfounded == nil{
                        completionHundler(nil,"not correct the user please register new user")
                        
                    }
                }catch let error{
                    
                    print(error)
                }
            case .failure(let error):
                completionHundler(nil,"not correct the user please register new user")
            }
        }
        
    }
}
