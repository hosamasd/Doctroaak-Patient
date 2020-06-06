//
//  MainLapSearchModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/14/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainLapSearchModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: [LapSearchModel]?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct LapSearchModel:Codable {
    let id: Int
    let name: String
    var nameAr, nameFr: String?
    let phone: String
    var phone2: String?
    let city, area: Int
    let lang, latt: String
    var apiToken,firebaseToken:String?
    let smsCode, email, password: String
    let active: Int
    let delivery: String
    let avaliableDays: Int
    var labDoctorID: Int?
    let photo: String
    let createdAt, updatedAt: String
    let labInsurances: [LabInsurcaneModel]
    let workingHours: [LabWorkingHourModel]
    let insuranceCompany: [InsurcaneCompanyModel]

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case phone, phone2, city, area, lang, latt
        case apiToken = "api_token"
        case firebaseToken = "firebase_token"
        case smsCode = "sms_code"
        case email, password, active, delivery
        case avaliableDays = "avaliable_days"
        case labDoctorID = "lab_doctor_id"
        case photo
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case labInsurances = "lab_insurances"
        case workingHours = "working_hours"
        case insuranceCompany = "insurance_company"
    }
}

struct LabInsurcaneModel:Codable {
    let id, labID, insuranceID: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case labID = "lab_id"
        case insuranceID = "insurance_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct LabWorkingHourModel:Codable {
    let id, labID, day: Int
    let partFrom, partTo: String
    let active: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case labID = "lab_id"
        case day
        case partFrom = "part_from"
        case partTo = "part_to"
        case active
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
