//
//  MainGetRadiologyModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/14/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainGetRadiologyModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: [GetRadiologyModel]?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct GetRadiologyModel:Codable {
    let id: Int
       let name: String
       var nameAr, nameFr: String?
       let apiToken: String
       let firebaseToken: String?
       let phone: String
       var phone2: String?
       let city, area: Int
       let lang, latt, smsCode, email: String
       let password: String
       let active: Int
       let delivery: String
       let avaliableDays: Int
       var radiologyDoctorID: Int?
       let photo, reservationRate, degreeRate, createdAt: String
       let updatedAt: String
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
           case insuranceCompany = "insurance_company"
       }
}
