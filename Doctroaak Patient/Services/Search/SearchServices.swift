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
    
    func radiologGetSearchResults(firstOption:Bool,rad_id:Int,city:Int? = nil ,are:Int? = nil,insurance:Int,delivery:Int,latt:Double? = nil,lang:Double? = nil,completion: @escaping (MainRadiologySearchModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)radiology/get".toSecrueHttps()
        var checks = ""
        
        if firstOption {
            
            
            if firstOption && (city == nil && are == nil)  {
                checks = "?lab_id=\(rad_id)&insurance=\(insurance)&delivery=\(delivery)"
            }else if firstOption && (city != nil && are == nil) {
                checks = "?lab_id=\(rad_id)&insurance=\(insurance)&delivery=\(delivery)&city=\(city!)"
            }else if firstOption && (city == nil && are != nil) {
                checks = "?lab_id=\(rad_id)&insurance=\(insurance)&delivery=\(delivery)&are=\(are!)"
                
            }else if   firstOption && (city != nil && are != nil) {
                checks = "?lab_id=\(rad_id)&insurance=\(insurance)&delivery=\(delivery)&are=\(are!)&city=\(city!)"
                
            }
        }
        else {
            checks = "?lab_id=\(rad_id)&insurance=\(insurance)&delivery=\(delivery)&lang=\(lang!)&latt=\(latt!)"
            
        }
        let postString = urlString+checks
        MainServices.mainGetMethodGenerics(urlString: postString, completion: completion)
        
    }
    
    func labGetSearchResults(firstOption:Bool,lab_id:Int,city:Int? = nil ,are:Int? = nil,insurance:Int,delivery:Int,latt:Double? = nil,lang:Double? = nil,completion: @escaping (MainLapSearchModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)lab/get".toSecrueHttps()
        var checks = ""
        
        if firstOption {
            
            
            if firstOption && (city == nil && are == nil)  {
                checks = "?lab_id=\(lab_id)&insurance=\(insurance)&delivery=\(delivery)"
            }else if firstOption && (city != nil && are == nil) {
                checks = "?lab_id=\(lab_id)&insurance=\(insurance)&delivery=\(delivery)&city=\(city!)"
            }else if firstOption && (city == nil && are != nil) {
                checks = "?lab_id=\(lab_id)&insurance=\(insurance)&delivery=\(delivery)&are=\(are!)"
                
            }else if   firstOption && (city != nil && are != nil) {
                checks = "?lab_id=\(lab_id)&insurance=\(insurance)&delivery=\(delivery)&are=\(are!)&city=\(city!)"
                
            }
        }
        else {
            checks = "?lab_id=\(lab_id)&insurance=\(insurance)&delivery=\(delivery)&lang=\(lang!)&latt=\(latt!)"
            
        }
        let postString = urlString+checks
        
        MainServices.mainGetMethodGenerics(urlString: postString, completion: completion)
        
    }
}
