//
//  LAPSearchViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/6/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LAPSearchViewModel {
    
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var city:Int? = -1 {didSet {checkFormValidity()}}
    var area:Int? = -1 {didSet {checkFormValidity()}}
    var insuranceCompany:Int? = 0 {didSet {checkFormValidity()}}
    var delivery:Int? = 0 {didSet {checkFormValidity()}}
    var lat:Double? {didSet {checkFormValidity()}}
    var lng:Double?  {didSet {checkFormValidity()}}
    var lab_id:Int? = -1 {didSet {checkFormValidity()}}
    var radiology_id:Int? = -1 {didSet {checkFormValidity()}}
    var index:Int? = -1 {didSet {checkFormValidity()}}
    
    var isFirstOpetion:Bool?  = true {didSet {checkFormValidity()}}
    
    
    
    
    func performLabSearching(completion:@escaping (MainLapSearchModel?,Error?)->Void)  {
        
        if isFirstOpetion ?? true {
            
            
            if   (city == -1 && area == -1)  {
                guard let lab_id=lab_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
                bindableIsLogging.value = true
                
                SearchServices.shared.labGetSearchResults(firstOption: true, lab_id: lab_id, insurance: insurance, delivery: delivery, completion: completion)
            }else if city != -1 && area == -1 {
                guard let city = city,let lab_id=lab_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
                bindableIsLogging.value = true
                SearchServices.shared.labGetSearchResults(firstOption: true, lab_id: lab_id,city: city, insurance: insurance, delivery: delivery, completion: completion)
                
                
            }else if city == -1 && area != -1{
                guard let area = area,let lab_id=lab_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
                bindableIsLogging.value = true
                SearchServices.shared.labGetSearchResults(firstOption: true, lab_id: lab_id,are: area, insurance: insurance, delivery: delivery, completion: completion)
                
            }else if   city != -1 && area != -1 {
                guard let city = city,let area = area,let lab_id=lab_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
                bindableIsLogging.value = true
                SearchServices.shared.labGetSearchResults(firstOption: true, lab_id: lab_id,city: city,are: area, insurance: insurance, delivery: delivery, completion: completion)
            }
        }
        else {
            guard let lat = lat,let lng = lng,let lab_id=lab_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
            bindableIsLogging.value = true
            SearchServices.shared.labGetSearchResults(firstOption: false, lab_id: lab_id, insurance: insurance, delivery: delivery,latt:lat,lang:lng, completion: completion)
        }
    }
    
    func performRadiologySearching(completion:@escaping (MainRadiologySearchModel?,Error?)->Void)  {
        if isFirstOpetion ?? true {
            
            
            if   (city == -1 && area == -1)  {
                guard let rad_id=radiology_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
                bindableIsLogging.value = true
                
                SearchServices.shared.radiologGetSearchResults(firstOption: true, rad_id: rad_id, insurance: insurance, delivery: delivery, completion: completion)
            }else if city != -1 && area == -1 {
                guard let city = city,let rad_id=radiology_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
                bindableIsLogging.value = true
                SearchServices.shared.radiologGetSearchResults(firstOption: true, rad_id: rad_id,city: city, insurance: insurance, delivery: delivery, completion: completion)
                
                
            }else if city == -1 && area != -1{
                guard let area = area,let rad_id=radiology_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
                bindableIsLogging.value = true
                SearchServices.shared.radiologGetSearchResults(firstOption: true, rad_id: rad_id,are: area, insurance: insurance, delivery: delivery, completion: completion)
                
            }else if   city != -1 && area != -1 {
                guard let city = city,let area = area,let rad_id=radiology_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
                bindableIsLogging.value = true
                SearchServices.shared.radiologGetSearchResults(firstOption: true, rad_id: rad_id,city: city,are: area, insurance: insurance, delivery: delivery, completion: completion)
            }
        }
        else {
            guard let lat = lat,let lng = lng,let rad_id=radiology_id,let insurance=insuranceCompany,let delivery=delivery else { return  }
            bindableIsLogging.value = true
            SearchServices.shared.radiologGetSearchResults(firstOption: false, rad_id: rad_id, insurance: insurance, delivery: delivery,latt:lat,lang:lng, completion: completion)
        }
    }
    
    func checkFormValidity() {
        //index ==0 lab ==1 radiology
        let isFormValid = index == 0 &&  lab_id != -1 && isFirstOpetion == true || city != -1 && area  != -1 && isFirstOpetion == true ||  city != -1 && area  != -1 && isFirstOpetion == true && lab_id != -1 ||  lat != -1.0 &&  lng != -1.0  && isFirstOpetion == false ||
            index == 1  && radiology_id != -1 && isFirstOpetion == true || city != -1 && area  != -1 && isFirstOpetion == true ||  city != -1 && area  != -1 && isFirstOpetion == true   && radiology_id != -1 ||  lat != -1.0 &&  lng != -1.0  && isFirstOpetion == false && radiology_id != -1
        bindableIsFormValidate.value = isFormValid
        
    }
    
}

