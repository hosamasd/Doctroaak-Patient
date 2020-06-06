//
//  MainLABAanalysisModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/6/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainLABAanalysisModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: [LABAanalysisModel]?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct LABAanalysisModel:Codable {
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
