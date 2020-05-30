//
//  MainRegisterAllModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/4/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

struct MainRegisterlModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: RegisterModel?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct RegisterModel:Codable {
    
let name, email, phone, gender: String
   let birthdate: String
   var insuranceID: Int?
   let address, password: String
   let smsCode: Int
   let updatedAt, createdAt: String
   let id: Int
   let photo, url: String
   var insurance: String?

   enum CodingKeys: String, CodingKey {
       case name, email, phone, gender, birthdate
       case insuranceID = "insurance_id"
       case address, password
       case smsCode = "sms_code"
       case updatedAt = "updated_at"
       case createdAt = "created_at"
       case id, photo, url, insurance
   }
}

