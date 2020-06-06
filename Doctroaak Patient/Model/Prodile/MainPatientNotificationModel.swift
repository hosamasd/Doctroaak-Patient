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
       let  orderType: String
    var createdAt, updatedAt:String?
    
       var order: OrderModel?

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
    let id: Int
    var clinicID,labID, patientID:Int?
    
    var partID, active, reservationNumber: Int?
       var notes,date,type: String?
       var createdAt, updatedAt: String?
       let patient: PatienModel
       var clinic: ClinicModel?
       let photo: String?
       var insuranceCode: String?
       let insuranceAccept: InsuranceAcceptModel?
       var accept: Int?
       var details: [DetailModel]?
       var pharmacyID, radiologyID: Int?
    
   
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
         case labID = "lab_id"
         case photo
         case insuranceCode = "insurance_code"
         case insuranceAccept = "insurance_accept"
         case accept, details
         case pharmacyID = "pharmacy_id"
         case radiologyID = "radiology_id"
    }
}

struct InsuranceAcceptModel:Codable {
    
}

struct DetailModel:Codable {
    let id: Int
       let pharmacyOrder, medicineID, amount, medicineTypeID: Int?
       var createdAt, updatedAt: String?
       var medicine, medicineType: LABAnalysisModel?
       let labOrder, analysisID: Int?
       let analysis: LABAnalysisModel?

       enum CodingKeys: String, CodingKey {
           case id
           case pharmacyOrder = "pharmacy_order"
           case medicineID = "medicine_id"
           case amount
           case medicineTypeID = "medicine_type_id"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case medicine
           case medicineType = "medicine_type"
           case labOrder = "lab_order"
           case analysisID = "analysis_id"
           case analysis
       }
}

enum InsuranceAccept: String, Codable {
    case insuranceAcceptRequired = "required"
}
