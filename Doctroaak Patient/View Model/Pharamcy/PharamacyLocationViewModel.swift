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
    
    var insuranceCompany:Int? = -1 {didSet {checkFormValidity()}}
    var delivery:Int? = -1 {didSet {checkFormValidity()}}
    var lat:Double? = -1.0 {didSet {checkFormValidity()}}
    var lng:Double? = -1.0 {didSet {checkFormValidity()}}
    
    
    
    
    
    
    func performLogging(completion:@escaping (Double,Double,Int,Int)->Void)  {
        guard let lat = lat,let lng = lng,let delivery=delivery,let insuranceCompany=insuranceCompany else { return  }
        bindableIsLogging.value = true
        completion(lat,lng,delivery,insuranceCompany)
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = lat != -1.0 &&  lng != -1.0
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
