//
//  DoctorSearchViewModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class DoctorSearchViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var city:Int? = -1 {didSet {checkFormValidity()}}
    var specificationId:Int? = -1 {didSet {checkFormValidity()}}

    var area:Int? = -1 {didSet {checkFormValidity()}}
    var isInsuranceCompany:Int? = 0 {didSet {checkFormValidity()}}
    var lat:Double? = -1.0{didSet {checkFormValidity()}}
    var lng:Double? = -1.0 {didSet {checkFormValidity()}}

    var isFirstOpetion:Bool?  = true {didSet {checkFormValidity()}}

    
    
    
    
    func performLogging(completion:@escaping (MainPatientSearchDoctorsModel?,Error?)->Void)  {
        if isFirstOpetion ?? true {
            guard let city = city,let area = area,let specificationId=specificationId,let isInsuranceCompany=isInsuranceCompany,let isFirstOpetion=isFirstOpetion else { return  }
             bindableIsLogging.value = true
            SearchServices.shared.getSearchDoctorsResults(firstOption: isFirstOpetion, specialization_id: specificationId, area: area, city: city, insurance: isInsuranceCompany, latt: 0, lang: 0, completion: completion)
        }else {
            guard let lat = lat,let lng = lng,let specificationId=specificationId,let isFirstOpetion=isFirstOpetion,let isInsuranceCompany=isInsuranceCompany else { return  }
             bindableIsLogging.value = true
            SearchServices.shared.getSearchDoctorsResults(firstOption: isFirstOpetion, specialization_id: specificationId, area: 0, city: 0, insurance: isInsuranceCompany, latt: lat, lang: lng, completion: completion)
        }
       
        
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = city != -1 &&  area != -1  && isFirstOpetion == true || isFirstOpetion == false &&  lat  != -1.0  && lng != -1.0  && specificationId != -1
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
