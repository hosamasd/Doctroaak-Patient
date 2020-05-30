//
//  MainVerificationSMScODEModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/6/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import CodableCache

struct MainVerificationSMScODEModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: PatienModel?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct PatienModel:Codable {
    let id: Int
       let name: String
       var nameAr, nameFr: String?
       let phone, smsCode, apiToken: String
       var firebaseToken: String?
       let email, gender, password: String
       let active: Int
       var insuranceID: Int?
       var birthdate: String?
       let photo: String
       var insuranceCode: String?
       let address: String
       var addressAr, addressFr: String?
       let createdAt, updatedAt: String
       var insuranceCodeID, blockDays, blockDate: String?
       let url: String
       var insurance: String?

       enum CodingKeys: String, CodingKey {
           case id, name
           case nameAr = "name_ar"
           case nameFr = "name_fr"
           case phone
           case smsCode = "sms_code"
           case apiToken = "api_token"
           case firebaseToken = "firebase_token"
           case email, gender, password, active
           case insuranceID = "insurance_id"
           case birthdate, photo
           case insuranceCode = "insurance_code"
           case address
           case addressAr = "address_ar"
           case addressFr = "address_fr"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case insuranceCodeID = "insurance_code_id"
           case blockDays = "block_days"
           case blockDate = "block_date"
           case url, insurance
       }
}

final class PersonManager {

    let cache: CodableCache<PatienModel>

    init(cacheKey: AnyHashable) {
        cache = CodableCache<PatienModel>(key: cacheKey)
    }

    func getPerson() -> PatienModel? {
        return cache.get()
    }

    func set(person: PatienModel) throws {
        try cache.set(value: person)
    }


}
