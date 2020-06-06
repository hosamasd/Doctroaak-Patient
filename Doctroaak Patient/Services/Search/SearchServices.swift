//
//  SearchServices.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/14/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class SearchServices {
    static let shared=SearchServices()
    
    func getSearchDoctorsResults(firstOption:Bool,specialization_id:Int,area:Int,city:Int,insurance:Int,latt:Double,lang:Double,is_medical_center:Int,completion: @escaping (MainPatientSearchDoctorsModel?, Error?) ->Void)  {
        let urlString = firstOption == false ? "\(baseUrl)clinic/get?specialization_id=\(specialization_id)&latt=\(latt)&lang=\(lang)&insurance=\(insurance)&is_medical_center=\(is_medical_center)".toSecrueHttps() :   "\(baseUrl)clinic/get?specialization_id=\(specialization_id)&area=\(area)&city=\(city)&insurance=\(insurance)&is_medical_center=\(is_medical_center)".toSecrueHttps()
        
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
        
    }
    
    func radiologGetSearchResults(firstOption:Bool,rad_id:Int? = -1,city:Int? = nil ,are:Int? = nil,insurance:Int,delivery:Int,latt:Double? = nil,lang:Double? = nil,completion: @escaping (MainRadiologySearchModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)radiology/get".toSecrueHttps()
        var checks = ""
        
        if firstOption {
            
            
            if rad_id != -1 && (city == nil && are == nil)  {
                checks = "?radiology_id=\(rad_id!)&insurance=\(insurance)&delivery=\(delivery)"
            }else if rad_id != -1 && (city != nil && are == nil) {
                checks = "?radiology_id=\(rad_id!)&insurance=\(insurance)&delivery=\(delivery)&city=\(city!)"
            }else if rad_id != -1 && (city == nil && are != nil) {
                checks = "?radiology_id=\(rad_id!)&insurance=\(insurance)&delivery=\(delivery)&are=\(are!)"
                
            }else if   rad_id != -1 && (city != nil && are != nil) {
                checks = "?radiology_id=\(rad_id!)&insurance=\(insurance)&delivery=\(delivery)&are=\(are!)&city=\(city!)"
                
            }else if   rad_id == -1 && (city != nil && are != nil) {
                checks = "?insurance=\(insurance)&delivery=\(delivery)&are=\(are!)&city=\(city!)"
                
            }
        }
        else {
            checks = "?insurance=\(insurance)&delivery=\(delivery)&lang=\(lang!)&latt=\(latt!)"
            
        }
        let postString = urlString+checks
        MainServices.mainGetMethodGenerics(urlString: postString, completion: completion)
        
    }
    
    func pharamacyGetSearchResults(firstOption:Bool,pharmacy_id:Int? = -1,city:Int? = nil ,are:Int? = nil,insurance:Int,delivery:Int,latt:Double? = nil,lang:Double? = nil,completion: @escaping (MainPharamacySearchModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)pharmacy/get".toSecrueHttps()
        var checks = ""
        
        if firstOption {
            
            
            if pharmacy_id != -1 && (city == nil && are == nil)  {
                checks = "?pharmacy_id=\(pharmacy_id!)&insurance=\(insurance)&delivery=\(delivery)"
            }else if pharmacy_id != -1 && (city != nil && are == nil) {
                checks = "?pharmacy_id=\(pharmacy_id!)&insurance=\(insurance)&delivery=\(delivery)&city=\(city!)"
            }else if pharmacy_id != -1 && (city == nil && are != nil) {
                checks = "?pharmacy_id=\(pharmacy_id!)&insurance=\(insurance)&delivery=\(delivery)&area=\(are!)"
                
            }else if   pharmacy_id != -1 && (city != nil && are != nil) {
                checks = "?pharmacy_id=\(pharmacy_id!)&insurance=\(insurance)&delivery=\(delivery)&area=\(are!)&city=\(city!)"
                
            }else if   pharmacy_id == -1 && (city != nil && are != nil) {
                checks = "?insurance=\(insurance)&delivery=\(delivery)&area=\(are!)&city=\(city!)"
                
            }
        }
        else {
            checks = "?insurance=\(insurance)&delivery=\(delivery)&lang=\(lang!)&latt=\(latt!)"
            
        }
        let postString = urlString+checks
        MainServices.mainGetMethodGenerics(urlString: postString, completion: completion)
        
    }
    
    
    
    func labGetSearchResults(firstOption:Bool,lab_id:Int? = -1,city:Int? = -1 ,are:Int? = -1,insurance:Int,delivery:Int,latt:Double? = nil,lang:Double? = nil,completion: @escaping (MainLapSearchModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)lab/get".toSecrueHttps()
        var checks = ""
        
        if firstOption {
            
            
            if lab_id != -1 &&  (city == -1 && are == -1)  {
                checks = "?lab_id=\(lab_id!)&insurance=\(insurance)&delivery=\(delivery)"
            }else if lab_id != -1 &&  (city != -1 && are == -1) {
                checks = "?lab_id=\(lab_id!)&insurance=\(insurance)&delivery=\(delivery)&city=\(city!)"
            }else if lab_id != -1 &&  (city == -1 && are != -1) {
                checks = "?lab_id=\(lab_id!)&insurance=\(insurance)&delivery=\(delivery)&area=\(are!)"
                
            }else if  lab_id != -1 && (city != -1 && are != -1) {
                checks = "?lab_id=\(lab_id!)&insurance=\(insurance)&delivery=\(delivery)&area=\(are!)&city=\(city!)"
                
            }else if   lab_id == -1 && (city != -1 && are != -1) {
                checks = "?insurance=\(insurance)&delivery=\(delivery)&area=\(are!)&city=\(city!)"
                
            }
        }
        else {
            checks = "?insurance=\(insurance)&delivery=\(delivery)&lang=\(lang!)&latt=\(latt!)"
            
        }
        let postString = urlString+checks
        
        MainServices.mainGetMethodGenerics(urlString: postString, completion: completion)
        
    }
    
    func iCUGetSearchResults(isFirst:Bool,city:Int? = nil ,are:Int? = nil,latt:Double? = nil,lang:Double? = nil,completion: @escaping (MainICUFilterModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)icu/get".toSecrueHttps()
        let checks = isFirst ? "?city=\(city!)&area=\(are!)" : "?latt=\(latt!)&lang=\(lang!)"

        let postString = urlString+checks
        
        MainServices.mainGetMethodGenerics(urlString: postString, completion: completion)
    }
    
    func incubationGetSearchResults(isFirst:Bool,city:Int? = nil ,are:Int? = nil,latt:Double? = nil,lang:Double? = nil,completion: @escaping (MainIncubtionSearchModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)incubation/get".toSecrueHttps()
        let checks = isFirst ? "?city=\(city!)&area=\(are!)" : "?latt=\(latt!)&lang=\(lang!)"
        
        
        let postString = urlString+checks
        
        MainServices.mainGetMethodGenerics(urlString: postString, completion: completion)
    }
    
    
    
    
    
    
}
