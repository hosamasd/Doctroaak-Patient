//
//  MainRadiologySearchModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/14/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainRadiologySearchModel:Codable {
    
    let status: Int
    let message, messageEn: String
    var data: [RadiologySearchModel]?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct RadiologySearchModel:Codable {
    let id: Int
    let name: String
    var nameAr, nameFr: String?
    let apiToken, firebaseToken: String?
    let phone: String
    var phone2: String?
    let city, area: Int
    let lang, latt, smsCode, email: String
    let password: String
    let active: Int
    let delivery: String
    let avaliableDays: Int
    var radiologyDoctorID: Int?
    let photo: String
    let reservationRate, degreeRate, createdAt, updatedAt: String
    let distance: Double
    let radiologyInsurances: [RadiologyInsuranceModel]
    let workingHours: [RadiologyWorkingHourModel]
    let insuranceCompany: [InsurcaneCompanyModel]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case apiToken = "api_token"
        case firebaseToken = "firebase_token"
        case phone, phone2, city, area, lang, latt
        case smsCode = "sms_code"
        case email, password, active, delivery
        case avaliableDays = "avaliable_days"
        case radiologyDoctorID = "radiology_doctor_id"
        case photo
        case reservationRate = "reservation_rate"
        case degreeRate = "degree_rate"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case distance
        case radiologyInsurances = "radiology_insurances"
        case workingHours = "working_hours"
        case insuranceCompany = "insurance_company"
    }
}

struct RadiologyInsuranceModel:Codable {
    let id, radiologyID, insuranceID: Int
    var createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case radiologyID = "radiology_id"
        case insuranceID = "insurance_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct RadiologyWorkingHourModel:Codable {
    let id, radiologyID, day: Int
    let partFrom, partTo: String
    let active: Int
    var createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case radiologyID = "radiology_id"
        case day
        case partFrom = "part_from"
        case partTo = "part_to"
        case active
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum AtedAt: String, Codable {
    case the20191217124346 = "2019-12-17 12:43:46"
    case the20191217124347 = "2019-12-17 12:43:47"
    case the20200222150105 = "2020-02-22 15:01:05"
    case the20200317094740 = "2020-03-17 09:47:40"
    case the20200317110552 = "2020-03-17 11:05:52"
    case the20200506204854 = "2020-05-06 20:48:54"
}
