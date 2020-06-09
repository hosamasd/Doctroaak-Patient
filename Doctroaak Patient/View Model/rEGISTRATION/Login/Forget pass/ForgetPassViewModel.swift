//
//  ForgetPassViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class ForgetPassViewModel: CustomBaseView {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var phone:String? {didSet {checkFormValidity()}}
    
    
    func performResetPassword(completion:@escaping (MainAddFavoriteModel?,Error?)->Void)  {
        guard let phone = phone
            else { return  }
        bindableIsLogging.value = true
        
        RegistrationServices.shared.MainForgetPassword( phone: phone, completion: completion)

    }
    
    func checkFormValidity() {
        let isFormValid = phone?.isEmpty == false
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
