//
//  PatientProfileSservicea.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/19/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import Alamofire

class PatientProfileSservicea {
    static let shared=PatientProfileSservicea()
    
    func getNotifications(api_token:String,user_id:Int,completion: @escaping (MainPatientNotificationModel?, Error?) ->Void)  {
        let urlString =  "\(baseUrl)get/notification?api_token=\(api_token)&user_id=\(user_id)&user_type=PATIENT".toSecrueHttps()
        
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func removeNotification(notification_id:Int,completion: @escaping (MainPatientRemoveNotificationModel?, Error?) ->Void)  {
        
        let nnn = "notification/remove"
        
        let urlString = baseUrl+nnn
        guard  let url = URL(string: urlString.toSecrueHttps()) else { return  }
        
        let postString = "notification_id=\(notification_id)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func updateProfileInfo(isPhotoUpdate:Bool,name:String,gender:String,user_id:Int,api_token:String,address:String,photo:UIImage? = nil,birthdate:String,completion: @escaping (MainLoginModel?, Error?) ->Void)  {
        
        let nnn = "patient_update_profile"
        let urlString = "\(baseUrl)\(nnn)".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = urlString+"?user_id=\(user_id)&api_token=\(api_token)&address=\(address)&name=\(name)&gender=\(gender)&birthdate=\(birthdate)" // old_password is smscode
        
        if isPhotoUpdate {
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
                            let objects = try JSONDecoder().decode(MainLoginModel.self, from: data)
                            // success
                            completion(objects,nil)
                        } catch let error {
                            completion(nil,error)
                        }
                    }
                    
                case .failure( let encodingError):
                    completion(nil,encodingError)
                    break
                }
            }
            
        }else {
            MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
            
        }
    }
    
    func favoriteDoctors(patient_id:Int,doctor_id:Int,api_token:String,completion: @escaping (MainAddFavoriteModel?, Error?) ->Void)  {
        let nnn = "patient/favourite_doctor"
        let urlString = "\(baseUrl)\(nnn)".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "patient_id=\(patient_id)&doctor_id=\(doctor_id)&api_token=\(api_token)" // old_password is smscode
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func getPatientFavoriteDocotrs(patient_id:Int,api_token:String,completion: @escaping (MainPatientFavoriteModel?, Error?) ->Void)  {
        let urlString =  "\(baseUrl)patient/favourite/list?api_token=\(api_token)&patient_id=\(patient_id)".toSecrueHttps()
        
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
        
    }
    
    func getDoctorsOrders (patient_id:Int,api_token:String,completion: @escaping (MainDoctorsOrderPatientModel?, Error?) ->Void) {
        let urlString = "\(baseUrl)get/resrevation?api_token=\(api_token)&patient_id=\(patient_id)".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getRadiologyOrders (patient_id:Int,api_token:String,completion: @escaping (MainRadiologyOrderPatientModel?, Error?) ->Void) {
        let urlString = "\(baseUrl)get-orders?api_token=\(api_token)&patient_id=\(patient_id)&user_type=RADIOLOGY".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getPharamacyOrders (patient_id:Int,api_token:String,completion: @escaping (MainPharamacyOrderPatientModel?, Error?) ->Void) {
        let urlString = "\(baseUrl)get-orders?api_token=\(api_token)&patient_id=\(patient_id)&user_type=PHARMACY".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getLABOrders (patient_id:Int,api_token:String,completion: @escaping (MainLABOrderPatientModel?, Error?) ->Void) {
        let urlString = "\(baseUrl)get-orders?api_token=\(api_token)&patient_id=\(patient_id)&user_type=LAB".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
}
