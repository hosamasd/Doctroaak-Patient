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
    var insurance:Int? = -1 {didSet {checkFormValidity()}}
    var delivery:Int? = -1 {didSet {checkFormValidity()}}

    
    var isFirstOpetion:Bool?  = true {didSet {checkFormValidity()}}
    var isSecondOpetion:Bool?  = false {didSet {checkFormValidity()}}
    var isThirdOpetion:Bool?  = false {didSet {checkFormValidity()}}

    
    
    
    
    func performLogging(completion:@escaping (MainPatientOrderModel?,Error?)->Void)  {
        if isFirstOpetion ?? true {
            guard let image = image,let latt = latt,let long = lang,let patient_id=patient_id,let api_token=api_token,let insurance=insurance,let delivery=delivery else { return  }
             bindableIsLogging.value = true
            DoctorServices.shared.postBookPharamacyResults(photo: image, patient_id: patient_id, insurance: insurance, delivery: delivery, latt: latt, lang: long, notes: "", api_token: api_token, completion: completion)
            
        }else if isSecondOpetion ?? true {
            guard let orderDetails = orderDetails,let notes = notes,let latt = latt,let long = lang,let patient_id=patient_id,let api_token=api_token,let insurance=insurance,let delivery=delivery else { return  }
             bindableIsLogging.value = true
            DoctorServices.shared.postBookPharamacyResults( patient_id: patient_id, insurance: insurance, delivery: delivery, latt: latt, lang: long, notes: notes, api_token: api_token, completion: completion)
        }else if isThirdOpetion ?? true {
            guard let notes = notes,let latt = latt,let long = lang,let patient_id=patient_id,let api_token=api_token,let insurance=insurance,let delivery=delivery else { return  }
             bindableIsLogging.value = true
            DoctorServices.shared.postBookPharamacyResults(photo: image, patient_id: patient_id, insurance: insurance, delivery: delivery, latt: latt, lang: long,orderDetails: orderDetails, notes: notes, api_token: api_token, completion: completion)
        }
       
        
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = image != nil  && isFirstOpetion == true && insurance != -1 && delivery != -1 && lang != -1.0 && latt != -1.0 && api_token?.isEmpty == false && patient_id != -1   ||
            orderDetails?.isEmpty == false && insurance != -1 && delivery != -1 && lang != -1.0 && latt != -1.0 && api_token?.isEmpty == false && patient_id != -1  && isSecondOpetion == true ||
            image != nil    && orderDetails?.isEmpty == false  && isThirdOpetion == true && insurance != -1 && delivery != -1 && lang != -1.0 && latt != -1.0 && api_token?.isEmpty == false && patient_id != -1 ||
            isThirdOpetion == true && insurance != -1 && delivery != -1 && lang != -1.0 && latt != -1.0 && api_token?.isEmpty == false && patient_id != -1 && image != nil ||
            isThirdOpetion == true && insurance != -1 && delivery != -1 && lang != -1.0 && latt != -1.0 && api_token?.isEmpty == false && patient_id != -1 && orderDetails?.isEmpty == false
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
