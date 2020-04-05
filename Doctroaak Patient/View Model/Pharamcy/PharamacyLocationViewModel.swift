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
    
    var insuranceCompany:Bool? = true {didSet {checkFormValidity()}}
    var delivery:Bool? = true {didSet {checkFormValidity()}}
    var lat:String? {didSet {checkFormValidity()}}
    var lng:String? {didSet {checkFormValidity()}}
    
    
    
    
    
    
    func performLogging(completion:@escaping (Error?)->Void)  {
        guard let lat = lat,let lng = lng else { return  }
        bindableIsLogging.value = true
        
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = lat?.isEmpty == false &&  lng?.isEmpty == false 
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
