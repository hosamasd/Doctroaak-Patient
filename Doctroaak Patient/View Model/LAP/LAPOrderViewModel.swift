//
//  LAPOrderViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/6/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LAPOrderViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var image:UIImage? {didSet {checkFormValidity()}}
    var name:String? {didSet {checkFormValidity()}}
    var quantity:String? {didSet {checkFormValidity()}}
    
    var isFirstOpetion:Bool?  = true {didSet {checkFormValidity()}}
    var isSecondOpetion:Bool?  = false {didSet {checkFormValidity()}}
    var isThirdOpetion:Bool?  = false {didSet {checkFormValidity()}}

    
    
    
    
    func performLogging(completion:@escaping (Error?)->Void)  {
        if isFirstOpetion ?? true {
            guard let image = image else { return  }
        }else if isSecondOpetion ?? true {
            guard let name = name,let quantity=quantity else { return  }
        }else {
            guard let image = image,let name = name,let quantity=quantity else { return  }
        }
        bindableIsLogging.value = true
        
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = image != nil  && isFirstOpetion == true   ||   name?.isEmpty == false && quantity?.isEmpty == false && isSecondOpetion == true || image != nil     && name?.isEmpty == false && quantity?.isEmpty == false && isSecondOpetion == false
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
