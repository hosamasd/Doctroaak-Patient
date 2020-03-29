//
//  RegisterViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class RegisterViewModel {
    
    
    var bindableIsResgiter = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var name:String? {didSet {checkFormValidity()}}
    var phone:String? {didSet {checkFormValidity()}}
    var email:String? {didSet {checkFormValidity()}}
    var address:String? {didSet {checkFormValidity()}}
    var password:String? {didSet {checkFormValidity()}}
    var confirmPassword:String? {didSet {checkFormValidity()}}
    var birthday:String? {didSet {checkFormValidity()}}
    var insurance:String? {didSet {checkFormValidity()}}
     var insuranceCode:String? {didSet {checkFormValidity()}}
    var image:UIImage? {didSet {checkFormValidity()}}
    var isMale:Bool?  = true {didSet {checkFormValidity()}}
     var isAccept:Bool?  = false {didSet {checkFormValidity()}}
    
    
    func performRegister(completion:@escaping (Error?)->Void)  {
        guard let email = email,let password = password,let name = name,let phone = phone,let address = address,let birthday = birthday, let insurance = insurance
           ,let insuranceCode = insuranceCode,let ismale = isMale else { return  }
        bindableIsResgiter.value = true
        
        //        RegistrationServices.shared.registerUser(name: username, email: email, phone: phone, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = email?.isEmpty == false && password?.isEmpty == false && confirmPassword?.isEmpty == false && confirmPassword == password &&  phone?.isEmpty == false && name?.isEmpty == false && address?.isEmpty == false && birthday?.isEmpty == false && insurance?.isEmpty == false  && image != nil && insuranceCode?.isEmpty == false && isAccept != false
        bindableIsFormValidate.value = isFormValid
        
    }
}
