//
//  MainDoctorsOrderPatientModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/2/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainDoctorsOrderPatientModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: [DoctorsOrderPatientModel]?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct DoctorsOrderPatientModel:Codable {
    let id, clinicID, patientID, partID: Int
       let active, reservationNumber: Int
       let type: String
       var notes: String?
       let date, createdAt, updatedAt: String
       let patient: PatienModel
       let clinic: ClinicModel

       enum CodingKeys: String, CodingKey {
           case id
           case clinicID = "clinic_id"
           case patientID = "patient_id"
           case partID = "part_id"
           case active
           case reservationNumber = "reservation_number"
           case type, notes, date
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case patient, clinic
       }
}

struct ClinicModel:Codable {
     let id: Int
       let photo, phone, fees, fees2: String
       let city, area, lang, latt: String
       let waitingTime, active, availability, doctorID: Int
       let availableDays: Int
       let createdAt, updatedAt: String
       var availabilityDate: String?
       let doctor: DoctorModel
       let freeDays: [FreeDayModel]

       enum CodingKeys: String, CodingKey {
           case id, photo, phone, fees, fees2, city, area, lang, latt
           case waitingTime = "waiting_time"
           case active, availability
           case doctorID = "doctor_id"
           case availableDays = "available_days"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case availabilityDate = "availability_date"
           case doctor
           case freeDays = "free_days"
       }
}
