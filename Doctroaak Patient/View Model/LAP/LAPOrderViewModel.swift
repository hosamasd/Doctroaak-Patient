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
    var orderDetails:[RadiologyOrderModel]? {didSet {checkFormValidity()}}
    var name:Int? = -1 {didSet {checkFormValidity()}}
    var index:Int? = 0 {didSet {checkFormValidity()}}

    var isFirstOpetion:Bool?  = true {didSet {checkFormValidity()}}
    var isSecondOpetion:Bool?  = false {didSet {checkFormValidity()}}
    var isThirdOpetion:Bool?  = false {didSet {checkFormValidity()}}
    
    
    
    
    
    func performOrdering(completion:@escaping (UIImage?,[RadiologyOrderModel]?)->Void)  {
        if isFirstOpetion ?? true {
            guard let image = image else { return  }
            bindableIsLogging.value = true
            completion(image,nil)
        }else if isSecondOpetion ?? true {
            guard let orderDetails = orderDetails else { return  }
            bindableIsLogging.value = true
            completion(nil,orderDetails)
        }else if isThirdOpetion ?? true{
            if image != nil  {
                guard let image = image else { return  }
                bindableIsLogging.value = true
                completion(image,nil)
            }else if image != nil && orderDetails != nil {
                guard let image = image,let orderDetails = orderDetails else { return  }
                bindableIsLogging.value = true
                completion(image,orderDetails)
                
            }else if  orderDetails != nil {
                guard let orderDetails = orderDetails else { return  }
                bindableIsLogging.value = true
                completion(nil,orderDetails)
                
            }
        }
        
    }
    
    func checkFormValidity() {
        let isFormValid = image != nil  && isFirstOpetion == true   ||   orderDetails?.isEmpty == false  && isSecondOpetion == true || image != nil     && orderDetails?.isEmpty == false  && isThirdOpetion == true || image != nil     && isThirdOpetion == true || isThirdOpetion == true &&  orderDetails?.isEmpty == false
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
