//
//  MainAreaModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/4/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

struct MainAreaModel:Codable {
    let status: Int
    let message, messageEn: String
    let data: [AreaModel]
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct AreaModel:Codable {
    
    let id: Int
    let name, nameAr: String
    var nameFr: String?
    let cityID: Int
    let createdAt: CreatedAt
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case cityID = "city_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


enum CreatedAt: String, Codable {
    case the20190413220825 = "2019-04-13 22:08:25"
    case the20190502172518 = "2019-05-02 17:25:18"
}
