//
//  DoctorSearchViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class DoctorSearchViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var city:String? {didSet {checkFormValidity()}}
    var area:String? {didSet {checkFormValidity()}}
    var insuranceCompany:Bool? = true {didSet {checkFormValidity()}}
    var lat:String? {didSet {checkFormValidity()}}
    var lng:String? {didSet {checkFormValidity()}}

    var isFirstOpetion:Bool?  = true {didSet {checkFormValidity()}}

    
    
    
    
    func performLogging(completion:@escaping (Error?)->Void)  {
        if isFirstOpetion ?? true {
            guard let city = city,let area = area else { return  }
        }else {
            guard let lat = lat,let lng = lng else { return  }
        }
        bindableIsLogging.value = true
        
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = city?.isEmpty == false &&  area?.isEmpty == false  ||   lat?.isEmpty == false && lng?.isEmpty == false
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
