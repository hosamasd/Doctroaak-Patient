//
//  PharamacyLocationViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class PharamacyLocationViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    
    //variables
    var city:Int? = -1 {didSet {checkFormValidity()}}
    var area:Int? = -1 {didSet {checkFormValidity()}}
    var insuranceCompany:Int? = 0 {didSet {checkFormValidity()}}
    var delivery:Int? = 0 {didSet {checkFormValidity()}}
    var lat:Double? = -1 {didSet {checkFormValidity()}}
    var lng:Double? = -1 {didSet {checkFormValidity()}}
    var pharmacy_id:Int? = -1 {didSet {checkFormValidity()}}
    var index:Int? = -1 {didSet {checkFormValidity()}}
    
    var isFirstOpetion:Bool?  = true {didSet {checkFormValidity()}}
    
    
    func performSearching(completion:@escaping (MainPharamacySearchModel?,Error?)->Void)  {
        
        if isFirstOpetion ?? true {
            
            
            if   (city == -1 && area == -1)  {
                guard let pharmacy_id=pharmacy_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
                bindableIsLogging.value = true
                
                SearchServices.shared.pharamacyGetSearchResults(firstOption: true, pharmacy_id: pharmacy_id, insurance: insurance, delivery: delivery, completion: completion)
            }else if city != -1 && area == -1 {
                guard let city = city,let pharmacy_id=pharmacy_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
                bindableIsLogging.value = true
                SearchServices.shared.pharamacyGetSearchResults(firstOption: true, pharmacy_id: pharmacy_id,city: city, insurance: insurance, delivery: delivery, completion: completion)
                
                
            }else if city == -1 && area != -1{
                guard let area = area,let pharmacy_id=pharmacy_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
                bindableIsLogging.value = true
                SearchServices.shared.pharamacyGetSearchResults(firstOption: true, pharmacy_id: pharmacy_id,are: area, insurance: insurance, delivery: delivery, completion: completion)
                
            }else if   city != -1 && area != -1 {
                guard let city = city,let area = area,let pharmacy_id=pharmacy_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
                bindableIsLogging.value = true
                SearchServices.shared.pharamacyGetSearchResults(firstOption: true, pharmacy_id: pharmacy_id,city: city,are: area, insurance: insurance, delivery: delivery, completion: completion)
            }
        }
        else {
            guard let lat = lat,let lng = lng,let pharmacy_id=pharmacy_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
            bindableIsLogging.value = true
            SearchServices.shared.pharamacyGetSearchResults(firstOption: false, pharmacy_id: pharmacy_id, insurance: insurance, delivery: delivery,latt:lat,lang:lng, completion: completion)
        }
    }
    
    func checkFormValidity() {
        
        let isFormValid =   pharmacy_id != -1 && isFirstOpetion == true || city != -1 && area  != -1 && isFirstOpetion == true ||  city != -1 && area  != -1 && isFirstOpetion == true && pharmacy_id != -1 ||  lat != -1.0 &&  lng != -1.0  && isFirstOpetion == false
        bindableIsFormValidate.value = isFormValid
        
        
    }
}
