//
//  OrdserSerivce.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/16/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class OrdserBookSerivces{
    
    static let shared=OrdserBookSerivces()
    
    func postBookDoctorsResults(patient_id:Int,clinic_id:Int,type:Int,date:String,notes:String,api_token:String,part:Int,completion: @escaping (MainPatientOrderModel?, Error?) ->Void)  {
           let urlString = "\(baseUrl)clinic/order/create".toSecrueHttps()
           guard  let url = URL(string: urlString) else { return  }
           let postString =  "patient_id=\(patient_id)&clinic_id=\(clinic_id)&date=\(date)&type=\(type)&notes=\(notes)&api_token=\(api_token)&part=\(part)".toSecrueHttps()
           
           MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
       }
       
       func postBookLabsResults(orderDetails:[RadiologyOrderModel],patient_id:Int,lab_id:Int,date:String,notes:String,api_token:String,completion: @escaping (MainPatientOrderModel?, Error?) ->Void)  {
           let urlString = "\(baseUrl)lab/order/create".toSecrueHttps()
           guard  let url = URL(string: urlString) else { return  }
           let postString =  "patient_id=\(patient_id)&lab_id=\(lab_id)&date=\(date)&notes=\(notes)&api_token=\(api_token)".toSecrueHttps()
           
           MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postString,radiologyorderDetails:  orderDetails, completion: completion)
       }
    
    func postBookPharamacyResults(photo:UIImage? = nil,patient_id:Int,insurance:Int,delivery:Int,latt:Double,lang:Double,orderDetails:[PharamcyOrderModel]? = nil,notes:String,api_token:String,completion: @escaping (MainPatientOrderModel?, Error?) ->Void)  {
           
           let urlString = "\(baseUrl)pharmacy/order/create"
           let postStrings =  urlString.toSecrueHttps()+"?latt=\(latt)&lang=\(lang)&patient_id=\(patient_id)&insurance=\(insurance)&delivery=\(delivery)&notes=\(notes)&api_token=\(api_token)"
           MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postStrings,photo: photo,orderDetails: orderDetails, completion: completion)
       }
    
}
