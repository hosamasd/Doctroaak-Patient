//
//  NewPassViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//



import UIKit
class NewPassViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var password:String? {didSet {checkFormValidity()}}
    var confirmPassword:String? {didSet {checkFormValidity()}}
    var phone:String? {didSet {checkFormValidity()}}

    
    func performLogging(completion:@escaping (MainAddFavoriteModel?,Error?)->Void)  {
        guard let password = password,let confirmPassword = confirmPassword,let phone=phone
            else { return  }
        bindableIsLogging.value = true
        
        RegistrationServices.shared.MainUpdateUsingSMSPassword(phone: phone, old_password: confirmPassword, new_password: password, completion: completion)
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = password?.isEmpty == false && confirmPassword?.isEmpty == false && phone?.isEmpty == false
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
