//
//  MainRadiologyOrderModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/2/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainRadiologyOrderPatientModel:Codable {
    let status: Int
       let message, messageEn: String
       var data: [RadiologyOrderPatientModel]?

       enum CodingKeys: String, CodingKey {
           case status, message
           case messageEn = "message_en"
           case data
       }
}

struct RadiologyOrderPatientModel:Codable {
    let id, radiologyID, patientID: Int
    var notes: String?
    let photo: String
    var insuranceCode: String?
    let insuranceAccept, createdAt, updatedAt: String
    let accept: Int
    let patient: PatienModel
    var details: [RADDetailsModel]?

    enum CodingKeys: String, CodingKey {
        case id
        case radiologyID = "radiology_id"
        case patientID = "patient_id"
        case notes, photo
        case insuranceCode = "insurance_code"
        case insuranceAccept = "insurance_accept"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case accept, patient, details
    }
}

struct RADDetailsModel:Codable {
    let id, radiologyOrder, raysID: Int
       let createdAt, updatedAt: String
       let rays: RaysModel

       enum CodingKeys: String, CodingKey {
           case id
           case radiologyOrder = "radiology_order"
           case raysID = "rays_id"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case rays
       }
}
