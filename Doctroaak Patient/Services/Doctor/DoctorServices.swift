//
//  DoctorServices.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/12/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import Alamofire

class DoctorServices {
    static let shared=DoctorServices()
    
    func getSearchDoctorsResults(firstOption:Bool,specialization_id:Int,area:Int,city:Int,insurance:Int,latt:Double,lang:Double,completion: @escaping (MainPatientSearchDoctorsModel?, Error?) ->Void)  {
        let urlString = firstOption == false ? "\(baseUrl)clinic/get?specialization_id=\(specialization_id)&latt=\(latt)&lang=\(lang)&insurance=\(insurance)".toSecrueHttps() :   "\(baseUrl)clinic/get?specialization_id=\(specialization_id)&area=\(area)&city=\(city)&insurance=\(insurance)".toSecrueHttps()
        
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
        
    }
    
    func postBookDoctorsResults(patient_id:Int,clinic_id:Int,type:Int,date:String,notes:String,api_token:String,part:Int,completion: @escaping (MainPatientOrderModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)clinic/order/create".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString =  "patient_id=\(patient_id)&clinic_id=\(clinic_id)&date=\(date)&type=\(type)&notes=\(notes)&api_token=\(api_token)&part=\(part)".toSecrueHttps()
        
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func postBookPharamacyResults(photo:UIImage,patient_id:Int,insurance:Int,delivery:Int,latt:Double,lang:Double,orderDetails:[PharamcyOrderModel]? = nil,notes:String,api_token:String,completion: @escaping (MainPatientOrderModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)pharmacy/order/create".toSecrueHttps()
        let postStrings =  urlString+"?latt=\(latt)&lang=\(lang)&patient_id=\(patient_id)&insurance=\(insurance)&delivery=\(delivery)&notes=\(notes)&api_token=\(api_token)".toSecrueHttps()
        
        
        //
        let urlsString = postStrings.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let data = photo.pngData() {
                multipartFormData.append(data, withName: "photo", fileName: "asd.jpeg", mimeType: "image/jpeg")
            }
            let jsonEncoder = JSONEncoder()
            let jsonData = try? jsonEncoder.encode(orderDetails)
            if orderDetails?.isEmpty != nil {
                multipartFormData.append(jsonData ?? Data(), withName: "orderDetails")
            }
        }, to:urlsString!)
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
                        let objects = try JSONDecoder().decode(MainPatientOrderModel.self, from: data)
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
    
}
