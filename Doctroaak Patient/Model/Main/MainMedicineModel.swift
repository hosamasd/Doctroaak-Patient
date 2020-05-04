//
//  MainMedicineModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/4/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

struct MainMedicineModel:Codable {
    let status: Int
       let message, messageEn: String
       let data: [MedicineModel]

       enum CodingKeys: String, CodingKey {
           case status, message
           case messageEn = "message_en"
           case data
       }
}

struct MedicineModel:Codable {
    
    let id: Int
    let name, nameAr, nameFr: String
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
