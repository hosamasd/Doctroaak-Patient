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
    var image:UIImage? {didSet {checkFormValidity()}}
    var orderDetails:[RadiologyOrderModel]? {didSet {checkFormValidity()}}
    
    var dates:String? {didSet {checkFormValidity()}}
    var secondDates:String? {didSet {checkFormValidity()}}
    var index:Int? = 0 {didSet {checkFormValidity()}}
    var isFirstOpetion:Bool?  = true {didSet {checkFormValidity()}}
    var notes:String? = "" {didSet {checkFormValidity()}}
    var patient_id:Int? = -1 {didSet {checkFormValidity()}}
    var lab_id:Int? = -1 {didSet {checkFormValidity()}}
    var rad_id:Int? = -1 {didSet {checkFormValidity()}}
    
    var male:String = "male" {didSet {checkFormValidity()}}
    
    var api_token:String? {didSet {checkFormValidity()}}
    var fullName:String? {didSet {checkFormValidity()}}
    var mobile:String? {didSet {checkFormValidity()}}
    var age:Int? = -1 {didSet {checkFormValidity()}}
    
    
    
    
    func performLabBooking(notess:String,completion:@escaping (MainPatientOrderModel?,Error?)->Void)  {
        
        if isFirstOpetion ?? true {
            
            if image != nil && orderDetails != nil {
                guard let dates = dates,let img=image,let order=orderDetails,let apiToken=api_token,let patientId=patient_id,let lab_id=lab_id else { return  }
                bindableIsLogging.value = true
                OrdserBookSerivce.shared.postBookLabsResults( img:img,orderDetails: order, patient_id: patientId, lab_id: lab_id, date: dates, notes: notess, api_token: apiToken, completion: completion)
            }else   if image != nil {
                guard let dates = dates,let img=image,let apiToken=api_token,let patientId=patient_id,let lab_id=lab_id else { return  }
                bindableIsLogging.value = true
                OrdserBookSerivce.shared.postBookLabsResults( img:img, patient_id: patientId, lab_id: lab_id, date: dates, notes: notess, api_token: apiToken, completion: completion)
            }else if orderDetails != nil{
                guard let dates = dates,let orders=orderDetails,let apiToken=api_token,let patientId=patient_id,let lab_id=lab_id  else { return  }
                bindableIsLogging.value = true
                OrdserBookSerivce.shared.postBookLabsResults( orderDetails:orders, patient_id: patientId, lab_id: lab_id, date: dates, notes: notess, api_token: apiToken, completion: completion)
            }
            
        }else {
            if image != nil && orderDetails != nil {
                guard let dates = dates,let img=image,let order=orderDetails,let apiToken=api_token,let patientId=patient_id,let lab_id=lab_id else { return  }
                bindableIsLogging.value = true
                OrdserBookSerivce.shared.postBookLabsResults( img:img,orderDetails: order, patient_id: patientId, lab_id: lab_id, date: dates, notes: notess, api_token: apiToken, completion: completion)
            }else  if image != nil {
                guard let img=image,let apiToken=api_token,let patientId=patient_id,let lab_id=lab_id else { return  }
                bindableIsLogging.value = true
                OrdserBookSerivce.shared.postBookLabsResults( img:img, patient_id: patientId, lab_id: lab_id, notes: notess, api_token: apiToken, completion: completion)
            }else if orderDetails != nil{
                guard let orders=orderDetails,let apiToken=api_token,let patientId=patient_id,let lab_id=lab_id  else { return  }
                bindableIsLogging.value = true
                OrdserBookSerivce.shared.postBookLabsResults( orderDetails:orders, patient_id: patientId, lab_id: lab_id, notes: notess, api_token: apiToken, completion: completion)
            }
        }
    }
    
    func performRadiologyBooking(notess:String,completion:@escaping (MainPatientOrderModel?,Error?)->Void)  {
        
        if isFirstOpetion ?? true {
            if image != nil && orderDetails != nil {
                guard let dates = dates,let img=image,let order=orderDetails,let apiToken=api_token,let patientId=patient_id,let rad_id=rad_id else { return  }
                bindableIsLogging.value = true
                OrdserBookSerivce.shared.postBookRadiologyResults( img:img,orderDetails: order, patient_id: patientId, radiology_id: rad_id, date: dates, notes: notess, api_token: apiToken, completion: completion)
            }else if image != nil {
                guard let dates = dates,let img=image,let apiToken=api_token,let patientId=patient_id,let rad_id=rad_id else { return  }
                bindableIsLogging.value = true
                OrdserBookSerivce.shared.postBookRadiologyResults( img:img, patient_id: patientId, radiology_id: rad_id, date: dates, notes: notess, api_token: apiToken, completion: completion)
            }else if orderDetails != nil{
                guard let dates = dates,let orders=orderDetails,let apiToken=api_token,let patientId=patient_id,let rad_id=rad_id  else { return  }
                bindableIsLogging.value = true
                OrdserBookSerivce.shared.postBookRadiologyResults( orderDetails:orders, patient_id: patientId, radiology_id: rad_id, date: dates, notes: notess, api_token: apiToken, completion: completion)
            }
            
        }else {
            if image != nil && orderDetails != nil {
                guard let dates = dates,let img=image,let order=orderDetails,let apiToken=api_token,let patientId=patient_id,let rad_id=rad_id else { return  }
                bindableIsLogging.value = true
                OrdserBookSerivce.shared.postBookRadiologyResults( img:img,orderDetails: order, patient_id: patientId, radiology_id: rad_id, date: dates, notes: notess, api_token: apiToken, completion: completion)
            }else if image != nil {
                guard let dates=dates, let img=image,let apiToken=api_token,let patientId=patient_id,let rad_id=rad_id else { return  }
                bindableIsLogging.value = true
                OrdserBookSerivce.shared.postBookRadiologyResults( img:img, patient_id: patientId, radiology_id: rad_id, date: dates, notes: notess, api_token: apiToken, completion: completion)
            }else if orderDetails != nil{
                guard let dates=dates, let orders=orderDetails,let apiToken=api_token,let patientId=patient_id,let rad_id=rad_id  else { return  }
                bindableIsLogging.value = true
                OrdserBookSerivce.shared.postBookRadiologyResults( orderDetails:orders, patient_id: patientId, radiology_id: rad_id, date: dates, notes: notess, api_token: apiToken, completion: completion)
            }
        }
    }
    
    func checkFormValidity() {
        let isFormValid = dates?.isEmpty == false &&  index == 0 && isFirstOpetion==true && lab_id != -1 && image != nil  ||
            dates?.isEmpty == false &&  index == 0 && isFirstOpetion==true && lab_id != -1 && orderDetails != nil ||
            dates?.isEmpty == false &&  index == 0 && isFirstOpetion==true && lab_id != -1 && orderDetails != nil && image != nil  ||
            
            isFirstOpetion == false && secondDates?.isEmpty == false && fullName?.isEmpty == false && mobile?.isEmpty == false && image  != nil  && age != -1 && lab_id != -1 &&  index == 0 ||
            isFirstOpetion == false && secondDates?.isEmpty == false && fullName?.isEmpty == false && mobile?.isEmpty == false && orderDetails  != nil  && age != -1 && lab_id != -1 &&  index == 0 ||
            isFirstOpetion == false && secondDates?.isEmpty == false && fullName?.isEmpty == false && mobile?.isEmpty == false && image  != nil  && age != -1 && orderDetails  != nil && lab_id != -1 &&  index == 0 ||
            
            dates?.isEmpty == false &&  index == 1 && isFirstOpetion==true && rad_id != -1 && image != nil  ||
            dates?.isEmpty == false &&  index == 1 && isFirstOpetion==true && rad_id != -1 && orderDetails != nil ||
            dates?.isEmpty == false &&  index == 1 && isFirstOpetion==true && rad_id != -1 && orderDetails != nil && image != nil  ||
            
            isFirstOpetion == false && secondDates?.isEmpty == false && fullName?.isEmpty == false && mobile?.isEmpty == false && age != -1 && image  != nil && rad_id != -1  &&  index == 1 ||
            isFirstOpetion == false && secondDates?.isEmpty == false && fullName?.isEmpty == false && mobile?.isEmpty == false && age != -1 &&  orderDetails  != nil && rad_id != -1  &&  index == 1 ||
            isFirstOpetion == false && secondDates?.isEmpty == false && fullName?.isEmpty == false && mobile?.isEmpty == false && age  != -1 && image  != nil && orderDetails  != nil && rad_id != -1  &&  index == 1
        
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
