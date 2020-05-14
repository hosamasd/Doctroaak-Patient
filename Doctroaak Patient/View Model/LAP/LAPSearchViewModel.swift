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
    var name:Int? = -1 {didSet {checkFormValidity()}}
    var area:Int? = -1 {didSet {checkFormValidity()}}
    var insuranceCompany:Bool? = true {didSet {checkFormValidity()}}
    var delivery:Bool? = true {didSet {checkFormValidity()}}
    var lat:String? {didSet {checkFormValidity()}}
    var lng:String? {didSet {checkFormValidity()}}
    
    var isFirstOpetion:Bool?  = true {didSet {checkFormValidity()}}
    
    
    
    
    func performSearching(completion:@escaping (Error?)->Void)  {
        if isFirstOpetion ?? true {
            guard let name = name,let city = city,let area = area else { return  }
        }else {
            guard let lat = lat,let lng = lng else { return  }
        }
        bindableIsLogging.value = true
        
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = name != -1 && city != -1 && area  != -1 && isFirstOpetion == true || lat?.isEmpty == false &&  lng?.isEmpty == false && isFirstOpetion == false
        
        bindableIsFormValidate.value = isFormValid
        
    }
    
}

