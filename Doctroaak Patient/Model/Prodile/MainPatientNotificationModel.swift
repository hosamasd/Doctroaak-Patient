//
//  MainPatientNotificationModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/19/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainPatientNotificationModel:Codable {
    
    let status: Int
    let message, messageEn: String
    var data: [PatientNotificationModel]?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct PatientNotificationModel:Codable {
    let id, userID: Int
       let orderID, userType, messageAr, messageEn: String
       let titleEn, icon, titleAr: String
       let sent, seen: Int
       let createdAt, updatedAt, orderType: String
       let order: OrderModel

       enum CodingKeys: String, CodingKey {
           case id
           case userID = "user_id"
           case orderID = "order_id"
           case userType = "user_type"
           case messageAr = "message_ar"
           case messageEn = "message_en"
           case titleEn = "title_en"
           case icon
           case titleAr = "title_ar"
           case sent, seen
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case orderType = "order_type"
           case order
       }
}

struct OrderModel:Codable {
    let id, labID, patientID: Int
    var notes: String?
    let photo: String
    var insuranceCode: Int?
    let insuranceAccept, createdAt, updatedAt: String
    let accept: Int
    let patient: PatienModel
    var details: [String]?

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
