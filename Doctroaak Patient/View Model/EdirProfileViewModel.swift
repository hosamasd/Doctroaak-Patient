//
//  EdirProfileViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class EdirProfileViewModel {
    
    
    var bindableIsResgiter = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var phone:String? {didSet {checkFormValidity()}}
    var name:String? {didSet {checkFormValidity()}}
    
    var email:String? {didSet {checkFormValidity()}}
    var address:String? {didSet {checkFormValidity()}}
    var birthday:String? {didSet {checkFormValidity()}}
    var male:String? {didSet {checkFormValidity()}}
    var user_id:Int? {didSet {checkFormValidity()}}
    var api_token:String? {didSet {checkFormValidity()}}
    
    var image:UIImage? {didSet {checkFormValidity()}}
    var isPhotoEdit:Bool? = false {didSet {checkFormValidity()}}
    
    
    func performUpdateProfile(completion: @escaping (MainLoginModel?, Error?) ->Void)  {
        if isPhotoEdit ?? true{
            guard let email = email,let phone = phone,let address = address,let user_id=user_id,let api_token=api_token,let birthday=birthday,let gender=male,let image=image,let name=name  else { return  }
            bindableIsResgiter.value = true
            PatientProfileSservicea.shared.updateProfileInfo(isPhotoUpdate: true, name: name, gender: gender, user_id: user_id, api_token: api_token, address: address,photo: image, birthdate: birthday, completion: completion)
        }else {
            guard let email = email,let name=name,let phone = phone,let address = address,let user_id=user_id,let api_token=api_token,let birthday=birthday,let gender=male else { return  }
            bindableIsResgiter.value = true
            PatientProfileSservicea.shared.updateProfileInfo(isPhotoUpdate: false, name: name, gender: gender, user_id: user_id, api_token: api_token, address: address, birthdate: birthday, completion: completion)
            
        }
    }
    
    func checkFormValidity() {
        let isFormValid = email?.isEmpty == false  &&  phone?.isEmpty == false  && address?.isEmpty == false && image != nil && male?.isEmpty == false && birthday?.isEmpty == false
        bindableIsFormValidate.value = isFormValid
        
    }
}
