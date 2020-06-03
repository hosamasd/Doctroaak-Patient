//
//  MainLABOrderPatientModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/2/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainLABOrderPatientModel:Codable {
    let status: Int
       let message, messageEn: String
       var data: [LABOrderPatientModel]?

       enum CodingKeys: String, CodingKey {
           case status, message
           case messageEn = "message_en"
           case data
       }
}

struct LABOrderPatientModel:Codable {
    let id, labID, patientID: Int
    var notes: String?
    let photo: String
    var insuranceCode: String?
    let insuranceAccept, createdAt, updatedAt: String
    let accept: Int
    let patient: PatienModel
    var details: [LabDetailsModel]?

    enum CodingKeys: String, CodingKey {
        case id
        case labID = "lab_id"
        case patientID = "patient_id"
        case notes, photo
        case insuranceCode = "insurance_code"
        case insuranceAccept = "insurance_accept"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case accept, patient, details
    }
}

struct LabDetailsModel:Codable {
    let id, labOrder, analysisID: Int
    let createdAt, updatedAt: String
    let analysis: LABAnalysisModel

    enum CodingKeys: String, CodingKey {
        case id
        case labOrder = "lab_order"
        case analysisID = "analysis_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case analysis
    }
}

struct LABAnalysisModel:Codable {
    let id: Int
    let name, nameAr, nameFr, createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
