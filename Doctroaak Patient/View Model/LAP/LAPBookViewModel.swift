//
//  LAPBookViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/4/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit


class LAPBookViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
       var bindableIsFormValidate = Bindable<Bool>()
       
       //variables
       var dates:String? {didSet {checkFormValidity()}}
       var secondDates:String? {didSet {checkFormValidity()}}
       var fullName:String? {didSet {checkFormValidity()}}
       var mobileNumber:String? {didSet {checkFormValidity()}}
       var index:Int? = -1 {didSet {checkFormValidity()}}
    var birthday:String? {didSet {checkFormValidity()}}
    var isMale:Bool?  = true {didSet {checkFormValidity()}}
    var isFirstOpetion:Bool?  = true {didSet {checkFormValidity()}}

    
    
    
       
       func performLogging(completion:@escaping (Error?)->Void)  {
        if isFirstOpetion ?? true {
            guard let dates = dates else { return  }
        }else {
           guard let secondDates = secondDates, let fullName = fullName, let mobileNumber = mobileNumber,let birthday = birthday
               else { return  }
        }
           bindableIsLogging.value = true
           
           //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
       }
       
       func checkFormValidity() {
           let isFormValid = dates?.isEmpty == false &&  index != -1 ||  index != -1 && secondDates?.isEmpty == false && fullName?.isEmpty == false && mobileNumber?.isEmpty == false  && birthday?.isEmpty == false
           
           bindableIsFormValidate.value = isFormValid
           
       }
}
