//
//  MainPharamacyNameModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/1/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainPharamacyNameModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: [PharamacyNameModel]?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct PharamacyNameModel:Codable {
    
    let id: Int
       let name: String
       var nameAr, nameFr: String?
       let phone: String
       let phone2, address, addressAr, addressFr: String?
       let lang, apiToken: String
       var firebaseToken: String?
       let latt, smsCode: String
       var email: String?
       var city, area: Int?
       let password: String
       let active: Int
       let delivery: String
       let avaliableDays: Int
       var pharmacyDoctorID: Int?
       let photo: String
       var createdAt, updatedAt: String?
    let pharmacyInsurances: [PharmacyInsuranceModel]
    let workingHours: [PharamacyWorkingHourModel]
    let insuranceCompany: [InsurcaneCompanyModel]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case phone, phone2, address
        case addressAr = "address_ar"
        case addressFr = "address_fr"
        case lang
        case apiToken = "api_token"
        case firebaseToken = "firebase_token"
        case latt
        case smsCode = "sms_code"
        case email, city, area, password, active, delivery
        case avaliableDays = "avaliable_days"
        case pharmacyDoctorID = "pharmacy_doctor_id"
        case photo
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pharmacyInsurances = "pharmacy_insurances"
        case workingHours = "working_hours"
        case insuranceCompany = "insurance_company"
    }
}

struct PharmacyInsuranceModel:Codable {
    let id, pharmacyID, insuranceID: Int
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case pharmacyID = "pharmacy_id"
        case insuranceID = "insurance_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct PharamacyWorkingHourModel:Codable {
    let id, pharmacyID, day: Int
    let partFrom, partTo: String
    let active: Int
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case pharmacyID = "pharmacy_id"
        case day
        case partFrom = "part_from"
        case partTo = "part_to"
        case active
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
