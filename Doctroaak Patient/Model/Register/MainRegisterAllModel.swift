//
//  MainRegisterAllModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/4/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

struct MainRegisterAllModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: String?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

//struct RegisterAllModel:Codable {
//    
//let name, email, phone: String
//    var phone2: String?
//    let delivery, password: String
//    let smsCode, active: Int
//    let lang, latt, city, area: String
//    let updatedAt, createdAt: String
//    let id: Int
//    let photo: String
//    let labInsurances: [AllInsuranceModel]
//    let workingHours: [AllWorkingHoursModel]
//    let insuranceCompany: [InsurcaneModel]
//
//    enum CodingKeys: String, CodingKey {
//        case name, email, phone, phone2, delivery, password
//        case smsCode = "sms_code"
//        case active, lang, latt, city, area
//        case updatedAt = "updated_at"
//        case createdAt = "created_at"
//        case id, photo
//        case labInsurances = "lab_insurances"
//        case workingHours = "working_hours"
//        case insuranceCompany = "insurance_company"
//    }
//}
