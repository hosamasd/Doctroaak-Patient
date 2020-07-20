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
    var isInsurance:Bool? = false {didSet {checkFormValidity()}}
     var insuranceCode:Int? = -1 {didSet {checkFormValidity()}}
    var image:UIImage? {didSet {checkFormValidity()}}
    var gender:String?  = "male" {didSet {checkFormValidity()}}
     var isAccept:Bool?  = false {didSet {checkFormValidity()}}
    

    
    func performRegister(completion:@escaping (MainRegisterlModel?, Error?)->Void)  {
        guard let email = email,let password = password,let name = name,let phone = phone,let address = address,let birthday = birthday
           ,let insuranceCode = insuranceCode,let gender = gender else { return  }
        bindableIsResgiter.value = true
        
        RegistrationServices.shared.mainAllRegister( photo: image, name: name, email: email, phone: phone, password: password, gender: gender, birthdate: birthday, address: address, insuranceCode: insuranceCode, completion: completion)
        //        RegistrationServices.shared.registerUser(name: username, email: email, phone: phone, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        
        let isFormValid = email?.isEmpty == false && password?.isEmpty == false && confirmPassword?.isEmpty == false && confirmPassword == password &&  phone?.isEmpty == false && name?.isEmpty == false && address?.isEmpty == false && birthday?.isEmpty == false && image != nil  && isAccept != false && isInsurance == false ||
            insuranceCode  != -1 && email?.isEmpty == false && password?.isEmpty == false && confirmPassword?.isEmpty == false && confirmPassword == password &&  phone?.isEmpty == false && name?.isEmpty == false && address?.isEmpty == false && birthday?.isEmpty == false   && isAccept != false && isAccept == true

        bindableIsFormValidate.value = isFormValid
        
    }
}
