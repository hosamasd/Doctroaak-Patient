//
//  LoginViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class LoginViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var phone:String? {didSet {checkFormValidity()}}
    var password:String? {didSet {checkFormValidity()}}
    
    
    func performLogging(completion:@escaping (Error?)->Void)  {
        guard let phone = phone,let password = password
            else { return  }
        bindableIsLogging.value = true
        
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = phone?.isEmpty == false && password?.isEmpty == false 
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
