//
//  MainPatientSearchDoctorsModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/12/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainPatientSearchDoctorsModel:Codable {
    
    let status: Int
    let message, messageEn: String
    var data: [PatientSearchDoctorsModel]?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct PatientSearchDoctorsModel:Codable {
    let id: Int
    let photo, phone, fees, fees2: String
    let city, area, lang, latt: String
    let waitingTime, active, availability, doctorID: Int
    let availableDays: Int
    let createdAt, updatedAt: String
    var availabilityDate: String?
    let name,gender: String
    var nameAr, nameFr: String?
    let  smsCode, apiToken: String
    let firebaseToken: String?
    let email, password: String
    let specializationID: Int
    var degreeID:Int? 
    
    let cv: String
    var cv2, reservationRate, degreeRate: String?
    let isHospital: Int
    var datumDescription: String?
    let isMedicalCenter: Int
    let workingHours: [WorkingHourModel]
    let  specialization: DegreeSearchModel
    var degree: DegreeSearchModel?
    
    let freeDays: [FreeDayModel]
    let doctor: DoctorModel
    
    enum CodingKeys: String, CodingKey {
        case id, photo, phone, fees, fees2, city, area, lang, latt
        case waitingTime = "waiting_time"
        case active, availability
        case doctorID = "doctor_id"
        case availableDays = "available_days"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case availabilityDate = "availability_date"
        case name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case gender
        case smsCode = "sms_code"
        case apiToken = "api_token"
        case firebaseToken = "firebase_token"
        case email, password
        case specializationID = "specialization_id"
        case degreeID = "degree_id"
        case cv, cv2
        case reservationRate = "reservation_rate"
        case degreeRate = "degree_rate"
        case isHospital
        case datumDescription = "description"
        case isMedicalCenter = "is_medical_center"
        case workingHours = "working_hours"
        case degree, specialization
        case freeDays = "free_days"
        case doctor
    }
}

struct DegreeSearchModel:Codable {
    let id: Int
    let name, nameAr, nameFr: String
    var createdAt: String?
    let updatedAt: String?
    let photo: String?
    let url: String?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case photo, url, icon
    }
}


enum Icon: String, Codable {
    case the157719954155887PNG = "157719954155887.png"
}

enum Photo: String, Codable {
    case insurancePNG = "insurance.png"
    case the157442109712072JPEG = "157442109712072.jpeg"
    case the157786933146609PNG = "157786933146609.png"
}

struct DoctorModel:Codable {
    
    let id: Int
    let name: String
    var gender,nameAr, nameFr: String?
    let  phone, smsCode, apiToken: String
    let firebaseToken: String?
    let email, password: String
    let active, specializationID: Int
    var degreeID:Int? 
    
    let cv: String
    let cv2: String
    let photo: String
    var reservationRate, degreeRate: String?
    let createdAt, updatedAt: String
    let isHospital: Int
    var doctorDescription: String?
    let isMedicalCenter, rate: Int
    let insuranceCompany: [DegreeSearchModel]
    let  specialization: DegreeSearchModel
    var degree:DegreeSearchModel?
    
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case gender, phone
        case smsCode = "sms_code"
        case apiToken = "api_token"
        case firebaseToken = "firebase_token"
        case email, password, active
        case specializationID = "specialization_id"
        case degreeID = "degree_id"
        case cv, cv2, photo
        case reservationRate = "reservation_rate"
        case degreeRate = "degree_rate"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isHospital
        case doctorDescription = "description"
        case isMedicalCenter = "is_medical_center"
        case rate
        case insuranceCompany = "insurance_company"
        case degree, specialization
    }
}

struct WorkingHourModel:Codable {
    
    let id, clinicID, day: Int
    let part1From, part1To, part2From, part2To: String
    let active, reservationNumber1, reservationNumber2: Int
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case clinicID = "clinic_id"
        case day
        case part1From = "part1_from"
        case part1To = "part1_to"
        case part2From = "part2_from"
        case part2To = "part2_to"
        case active
        case reservationNumber1 = "reservation_number_1"
        case reservationNumber2 = "reservation_number_2"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct FreeDayModel:Codable {
    let date: String
    let partID: Int
    
    enum CodingKeys: String, CodingKey {
        case date
        case partID = "part_id"
    }
}
