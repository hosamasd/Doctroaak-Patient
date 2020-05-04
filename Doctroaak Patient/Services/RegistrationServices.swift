//
//  RegistrationServices.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/4/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
//import Alamofire

class RegistrationServices {
    
    static let shared = RegistrationServices()
    
    func mainAllRegister(isInsurance:Bool,photo:UIImage,name:String,email:String,phone:String,password:String,gender:String,birthdate:String,address:String,insuranceCode:String ,completion: @escaping (MainRegisterAllModel?, Error?) -> Void)  {
           
           let urlString = baseUrl+"patient_register".toSecrueHttps()
        let postString =  isInsurance ?  urlString+"?name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&address=\(address)&gender=\(gender)&birthdate=\(birthdate)&insurance_code=\(insuranceCode)" : urlString+"?name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&address=\(address)&gender=\(gender)&birthdate=\(birthdate)"
        
//        let urlsString = postString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//               Alamofire.upload(multipartFormData: { (multipartFormData) in
//                   
//                   if let data = photo.pngData() {
//                       multipartFormData.append(data, withName: "photo", fileName: "asd.jpeg", mimeType: "image/jpeg")
//                   }
//                   
//                 
//                   
//               }, to:postString)
//               { (result) in
//                   switch result {
//                   case .success(let upload, _, _):
//                       
//                       upload.uploadProgress(closure: { (progress) in
//                           //Print progress
//                           print(progress)
//                       })
//                       
//                       upload.responseJSON { response in
//                           //print response.result
//                           print(response.result)
//                           guard let data = response.data else {return}
//                           
//                           do {
//                               let objects = try JSONDecoder().decode(MainRegisterAllModel.self, from: data)
//                               // success
//                               completion(objects,nil)
//                           } catch let error {
//                               completion(nil,error)
//                           }
//                       }
//                       
//                   case .failure( let encodingError):
//                       completion(nil,encodingError)
//                       break
//                       //print encodingError.description
//                   }
//               }
               
           }
    

}
