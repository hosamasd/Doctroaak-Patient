//
//  ICUViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/6/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ICUViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var city:Int? = -1 {didSet {checkFormValidity()}}
    var area:Int? = -1  {didSet {checkFormValidity()}}
    var lat:Double?  {didSet {checkFormValidity()}}
    var lng:Double? {didSet {checkFormValidity()}}
    
    
    
    
    
    
    func performSearchinging(completion:@escaping (MainICUFilterModel?,Error?)->Void)  {
        if lat != nil && lng != nil {
            guard   let lat = lat,let lng = lng else { return  }
            bindableIsLogging.value = true
            SearchServices.shared.iCUGetSearchResults( latt: lat, lang: lng, completion: completion);return
        }else if city != -1 && area != -1 {
            guard let city = city,let area = area else { return  }
            bindableIsLogging.value = true
            SearchServices.shared.iCUGetSearchResults(city: city, are: area, completion: completion)
        }
    }
    
    func checkFormValidity() {
        let isFormValid = city != -1 &&  area != -1 ||    lat != -1  && lng != -1
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
