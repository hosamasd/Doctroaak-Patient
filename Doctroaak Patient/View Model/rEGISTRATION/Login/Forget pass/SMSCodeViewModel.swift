//
//  SMSCodeViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class SMSCodeViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var smsCode:String? {didSet {checkFormValidity()}}
    var sms2Code:String? {didSet {checkFormValidity()}}
    var sms3Code:String? {didSet {checkFormValidity()}}
    var sms4Code:String? {didSet {checkFormValidity()}}
    var sms5Code:String? {didSet {checkFormValidity()}}
    var user_id:Int? = -1 {didSet {checkFormValidity()}}

    func performResendSMSCode(completion:@escaping (MainVerificationSMScODEModel?,Error?)->Void)  {
              guard let user_id = user_id  else { return  }
              
              bindableIsLogging.value = true
              
           RegistrationServices.shared.MainResendSmsCodeAgain( user_id: user_id, completion: completion)
          }

    
    func performLogging(completion:@escaping (MainVerificationSMScODEModel?,Error?)->Void)  {
        guard let smsCode = smsCode, let sms2Code = sms2Code, let sms3Code = sms3Code,let sms4Code = sms4Code,let sms5Code=sms5Code,let user_id=user_id
            else { return  }
        let mainsmsCode = smsCode+sms2Code+sms3Code+sms4Code+sms5Code

        bindableIsLogging.value = true
        
        RegistrationServices.shared.MainReceiveSmsCode( user_id: user_id, sms_code: mainsmsCode, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = smsCode?.isEmpty == false && sms2Code?.isEmpty == false && sms3Code?.isEmpty == false && sms4Code?.isEmpty == false  && sms5Code?.isEmpty == false && user_id != -1
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
