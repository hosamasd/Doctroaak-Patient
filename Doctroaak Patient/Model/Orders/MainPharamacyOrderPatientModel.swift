//
//  MainPharamacyOrderPatientModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/2/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainPharamacyOrderPatientModel:Codable {
    let status: Int
          let message, messageEn: String
          var data: [PharamacyOrderPatientModel]?

          enum CodingKeys: String, CodingKey {
              case status, message
              case messageEn = "message_en"
              case data
          }
}

struct PharamacyOrderPatientModel:Codable {
    let id, pharmacyID, patientID: Int
       var notes: String?
       let photo: String
       var insuranceCode: String?
       let insuranceAccept, createdAt, updatedAt: String
       let accept: Int
       let patient: PatienModel
       var details: [String]?

       enum CodingKeys: String, CodingKey {
           case id
           case pharmacyID = "pharmacy_id"
           case patientID = "patient_id"
           case notes, photo
           case insuranceCode = "insurance_code"
           case insuranceAccept = "insurance_accept"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case accept, patient, details
       }
}
