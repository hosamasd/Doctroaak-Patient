//
//  PharamacyOrderViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class PharamacyOrderViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var image:UIImage? {didSet {checkFormValidity()}}
    var api_token:String? {didSet {checkFormValidity()}}
    var latt:Double? = -1.0 {didSet {checkFormValidity()}}
    var lang:Double? = -1.0 {didSet {checkFormValidity()}}
    var notes:String? = "" {didSet {checkFormValidity()}}
    var orderDetails:[PharamcyOrderModel]? {didSet {checkFormValidity()}}
    var patient_id:Int? = -1 {didSet {checkFormValidity()}}
    var pharmacy_id:Int? = -1 {didSet {checkFormValidity()}}

    var insurance:Int? = -1 {didSet {checkFormValidity()}}
    var delivery:Int? = -1 {didSet {checkFormValidity()}}
    
    
    var isFirstOpetion:Bool?  = true {didSet {checkFormValidity()}}
    var isSecondOpetion:Bool?  = false {didSet {checkFormValidity()}}
    var isThirdOpetion:Bool?  = false {didSet {checkFormValidity()}}
    
    
    
    
    
    func performBooking(completion:@escaping (MainPatientOrderModel?,Error?)->Void)  {
        guard let apiToken=api_token,let patientId=patient_id,let insurance=insurance,let delivery=delivery,let pharmacy_id=pharmacy_id else { return  }
        
        if isFirstOpetion ?? true {
            guard let image = image else { return  }
            bindableIsLogging.value=true
            OrdserBookSerivce.shared.postBookPharamacyResults(isFirst: true, isSecond: false, isThird: false,photo: image, patient_id: patientId, insurance: insurance, delivery: delivery, api_token: apiToken,pharmacy_id: pharmacy_id, completion: completion )
            
        }else if isSecondOpetion ?? true {
            guard let order = orderDetails else { return  }
            bindableIsLogging.value=true

            OrdserBookSerivce.shared.postBookPharamacyResults(isFirst: false, isSecond: true, isThird: false, patient_id: patientId, insurance: insurance, delivery: delivery,orderDetails: order, api_token: apiToken,pharmacy_id: pharmacy_id, completion: completion)
        }else if isThirdOpetion ?? true {
            bindableIsLogging.value=true

            OrdserBookSerivce.shared.postBookPharamacyResults(isFirst: false, isSecond: false, isThird: true,photo: image, patient_id: patientId, insurance: insurance, delivery: delivery,orderDetails: orderDetails,notes: notes, api_token: apiToken, pharmacy_id: pharmacy_id, completion: completion)
            
        }
        
    }
    
    func checkFormValidity() {
        
        let isFormValidd = image != nil  && isFirstOpetion == true   ||   orderDetails?.isEmpty == false  && isSecondOpetion == true || image != nil     && orderDetails?.isEmpty == false  && isThirdOpetion == true || image != nil     && isThirdOpetion == true || isThirdOpetion == true &&  orderDetails?.isEmpty == false
        
        bindableIsFormValidate.value = isFormValidd
        
    }
}
