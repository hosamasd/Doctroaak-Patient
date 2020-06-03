//
//  OrdserSerivce.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/16/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class OrdserBookSerivce{
    
    static let shared=OrdserBookSerivce()
    
    func postBookDoctorsResults(patient_id:Int,clinic_id:Int,type:Int,date:String,notes:String,api_token:String,part:Int,completion: @escaping (MainPatientOrderModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)clinic/order/create".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString =  "patient_id=\(patient_id)&clinic_id=\(clinic_id)&date=\(date)&type=\(type)&notes=\(notes)&api_token=\(api_token)&part=\(part)".toSecrueHttps()
        
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func postBookLabsResults(img:UIImage? = nil,orderDetails:[RadiologyOrderModel]? = nil,patient_id:Int,lab_id:Int,date:String? = nil,notes:String,api_token:String,completion: @escaping (MainPatientOrderModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)lab/order/create".toSecrueHttps()
        var postString:String
        
        //           guard  let url = URL(string: urlString) else { return  }
        if date?.isEmpty == false {
            postString =  "patient_id=\(patient_id)&lab_id=\(lab_id)&date=\(date!)&notes=\(notes)&api_token=\(api_token)"
            
        }else {
            postString =  "patient_id=\(patient_id)&lab_id=\(lab_id)&notes=\(notes)&api_token=\(api_token)"
        }
        MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postString,photo: img,radiologyorderDetails:  orderDetails, completion: completion)
    }
    
    func postBookRadiologyResults(img:UIImage? = nil,orderDetails:[RadiologyOrderModel]? = nil,patient_id:Int,radiology_id:Int,date:String? = nil,notes:String,api_token:String,completion: @escaping (MainPatientOrderModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)radiology/order/create".toSecrueHttps()
        var postString:String 
            
//            urlString+"?patient_id=\(patient_id)&radiology_id=\(radiology_id)&notes=\(notes)&api_token=\(api_token)&date=\(date)".toSecrueHttps()

        
        //              guard  let url = URL(string: urlString) else { return  }
        if date?.isEmpty == false {
            postString =  "patient_id=\(patient_id)&radiology_id=\(radiology_id)&date=\(date!)&notes=\(notes)&api_token=\(api_token)".toSecrueHttps()

        }else {
            postString =  "patient_id=\(patient_id)&radiology_id=\(radiology_id)&date=\(date!)&notes=\(notes)&api_token=\(api_token)".toSecrueHttps()
        }
        MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postString,photo: img,radiologyorderDetails:  orderDetails, completion: completion)
    }
    
    func postBookPharamacyResults(isFirst:Bool,isSecond:Bool,isThird:Bool,photo:UIImage? = nil,patient_id:Int,insurance:Int,delivery:Int,orderDetails:[PharamcyOrderModel]? = nil,notes:String?="",api_token:String,pharmacy_id:Int,completion: @escaping (MainPatientOrderModel?, Error?) ->Void)  {
        
        let urlString = "\(baseUrl)pharmacy/order/create".toSecrueHttps()
        var postStrings = "patient_id=\(patient_id)&insurance=\(insurance)&delivery=\(delivery)&notes=\(notes!)&api_token=\(api_token)&pharmacy_id=\(pharmacy_id)"
        //        var postStrings:String
        if isFirst {
            

            MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postStrings,photo: photo, completion: completion)
        }else if isSecond {
            
            MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postStrings,orderDetails: orderDetails, completion: completion)
        }else if isThird{
            if photo != nil && orderDetails != nil {
                
                MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postStrings,photo: photo,orderDetails: orderDetails, completion: completion)
                
            }else if photo != nil {
                MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postStrings,photo: photo, completion: completion)
                
            }else {
                MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postStrings,orderDetails: orderDetails, completion: completion)
                
            }
        }
    }
}
