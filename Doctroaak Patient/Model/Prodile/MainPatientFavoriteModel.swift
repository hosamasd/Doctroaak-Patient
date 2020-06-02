//
//  MainPatientFavoriteModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/1/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainPatientFavoriteModel:Codable {
    let status: Int
     var message, messageEn: String?
     var data: [PatientFavoriteModel]?

     enum CodingKeys: String, CodingKey {
         case status, message
         case messageEn = "message_en"
         case data
     }
}

struct PatientFavoriteModel:Codable {
    let id: Int
      let photo, phone, fees, fees2: String
      let city, area, lang, latt: String
      let waitingTime, active, availability, doctorID: Int
      let availableDays: Int
      let createdAt, updatedAt: String
      var availabilityDate: String?
      let workingHours: [WorkingHourModel]
      let degree, specialization: DegreeSearchModel
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
          case workingHours = "working_hours"
          case degree, specialization
          case freeDays = "free_days"
          case doctor
      }
}
