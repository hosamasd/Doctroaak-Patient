//
//  IncubationSearchViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/6/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class IncubationSearchViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var city:Int? = -1 {didSet {checkFormValidity()}}
    var area:Int? = -1 {didSet {checkFormValidity()}}
    var lat:Double? = -1 {didSet {checkFormValidity()}}
    var lng:Double? = -1 {didSet {checkFormValidity()}}

    var isFirstOpetion:Bool?  = true {didSet {checkFormValidity()}}

    
    
    
    
    func performSearching(completion:@escaping (MainIncubtionSearchModel?,Error?)->Void)  {
          if isFirstOpetion ?? true {
                 guard let city = city,let area = area else { return  }
                 bindableIsLogging.value = true
                 SearchServices.shared.incubationGetSearchResults(isFirst:true,city: city, are: area, completion: completion)
             }else {
                 guard   let lat = lat,let lng = lng else { return  }
                 bindableIsLogging.value = true
                 SearchServices.shared.incubationGetSearchResults( isFirst:false,latt: lat, lang: lng, completion: completion);return
             }
    }
    
    func checkFormValidity() {
      let isFormValid = city != -1 &&  area != -1  && isFirstOpetion == true ||  isFirstOpetion == false &&  lat != -1  && lng != -1
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
