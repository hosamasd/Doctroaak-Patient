//
//  MainNotificationsModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/4/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

struct MainNotificationsModel:Codable {
    let status: Int
    let message, messageEn: String
    let data: [NotificationsModel]

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct NotificationsModel:Codable {
    let id: Int
       let name, nameAr, nameFr, icon: String
       let createdAt, updatedAt: String
       let url: String

       enum CodingKeys: String, CodingKey {
           case id, name
           case nameAr = "name_ar"
           case nameFr = "name_fr"
           case icon
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case url
       }
}
