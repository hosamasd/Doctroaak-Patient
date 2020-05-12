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
    var lat:String? {didSet {checkFormValidity()}}
    var lng:String? {didSet {checkFormValidity()}}
    
    
    
    
    
    
    func performLogging(completion:@escaping (Error?)->Void)  {
        guard let city = city,let area = area ,  let lat = lat,let lng = lng else { return  }
        
        bindableIsLogging.value = true
        
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = city != -1 &&  area != -1 &&    lat?.isEmpty == false && lng?.isEmpty == false
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
