//
//  MainIncubtionSearchModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/4/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainIncubtionSearchModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: [IncubtionSearchModel]?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct IncubtionSearchModel:Codable {
    let id: Int
       let name, nameAr, nameFr, datumDescription: String
       let descriptionAr, descriptionFr, phone: String
       let city, area: Int
       let lng, lat: Double
       let bedNumber: Int
       let rate: String
       var createdAt, updatedAt: String?

       enum CodingKeys: String, CodingKey {
           case id, name
           case nameAr = "name_ar"
           case nameFr = "name_fr"
           case datumDescription = "description"
           case descriptionAr = "description_ar"
           case descriptionFr = "description_fr"
           case phone, city, area, lng, lat
           case bedNumber = "bed_number"
           case rate
           case createdAt = "created_at"
           case updatedAt = "updated_at"
       }
}
