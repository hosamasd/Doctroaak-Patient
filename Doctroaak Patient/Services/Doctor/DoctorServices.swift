//
//  DoctorServices.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/12/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class DoctorServices {
    static let shared=DoctorServices()
    
    func getSearchDoctorsResults(firstOption:Bool,specialization_id:Int,area:Int,city:Int,insurance:Int,latt:Double,lang:Double,completion: @escaping (MainPatientSearchDoctorsModel?, Error?) ->Void)  {
        let urlString = firstOption == false ? "\(baseUrl)clinic/get?specialization_id=\(specialization_id)&latt=\(latt)&lang=\(lang)&insurance=\(insurance)".toSecrueHttps() :   "\(baseUrl)clinic/get?specialization_id=\(specialization_id)&area=\(area)&city=\(city)&insurance=\(insurance)".toSecrueHttps()
        
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
        
    }
    
    func getBookDoctorsResults(patient_id:Int,clinic_id:Int,type:Int,date:String,notes:String,api_token:String,part:Int,completion: @escaping (MainPatientOrderModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)clinic/order/create".toSecrueHttps()
               guard  let url = URL(string: urlString) else { return  }
        let postString =  "patient_id=\(patient_id)&clinic_id=\(clinic_id)&date=\(date)&type=\(type)&notes=\(notes)&api_token=\(api_token)&part=\(part)".toSecrueHttps()
        
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
        
    }
    
}
