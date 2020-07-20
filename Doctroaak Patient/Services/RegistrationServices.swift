//
//  RegistrationServices.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/4/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import Alamofire

class RegistrationServices {
    
    static let shared = RegistrationServices()
    
    func mainAllRegister(photo:UIImage?,name:String,email:String,phone:String,password:String,gender:String,birthdate:String,address:String,insuranceCode:Int ,completion: @escaping (MainRegisterlModel?, Error?) -> Void)  {
        
        let urlString = baseUrl+"patient_register"
        let postString =   urlString.toSecrueHttps()+"?name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&address=\(address)&gender=\(gender)&birthdate=\(birthdate)"
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let data = photo?.pngData() {
                multipartFormData.append(data, withName: "photo", fileName: "asd.jpeg", mimeType: "image/jpeg")
            }
            
            
            
        }, to:postString)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                    print(progress)
                })
                
                upload.responseJSON { response in
                    //print response.result
                    print(response.result)
                    guard let data = response.data else {return}
                    
                    do {
                        let objects = try JSONDecoder().decode(MainRegisterlModel.self, from: data)
                        // success
                        completion(objects,nil)
                    } catch let error {
                        completion(nil,error)
                    }
                }
                
            case .failure( let encodingError):
                completion(nil,encodingError)
                break
                //print encodingError.description
            }
        }
        
    }
    
    func MainLoginUser(phone:String,password:String,completion:@escaping (MainLoginModel?,Error?)->Void)  {
        let nnn = "patient_login"
        let urlString = baseUrl+nnn
        guard  let url = URL(string: urlString.toSecrueHttps()) else { return  }
        let postString = "phone=\(phone)&password=\(password)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    //
    func MainForgetPassword(phone:String,completion:@escaping (MainAddFavoriteModel?,Error?)->Void)  { ////baseusermodel
        let nnn = "patient_forget_password"
        let urlString = baseUrl+nnn
        guard  let url = URL(string: urlString.toSecrueHttps()) else { return  }
        let postString = "phone=\(phone)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    
    func MainUpdateUsingSMSPassword(phone:String,old_password:String,new_password:String,completion:@escaping (MainAddFavoriteModel?,Error?)->Void) {
        let nnn = "patient_update_password"
        let urlString = "\(baseUrl)\(nnn)".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "phone=\(phone)&old_password=\(old_password)&new_password=\(new_password)" // old_password is smscode
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func MainReceiveSmsCode(user_id:Int,sms_code:String,completion:@escaping (MainVerificationSMScODEModel?,Error?)->Void)  {
        let nnn = "patient_verify_account"
        
        let urlString = "\(baseUrl)\(nnn)".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        
        let postString = "user_id=\(user_id)&sms_code=\(sms_code)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func MainResendSmsCodeAgain(user_id:Int,completion:@escaping (MainVerificationSMScODEModel?,Error?)->Void)  {
        let nnn = "patient_resend"
        
        let urlString = baseUrl+nnn
        guard  let url = URL(string: urlString.toSecrueHttps()) else { return  }
        
        let postString = "user_id=\(user_id)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
}
