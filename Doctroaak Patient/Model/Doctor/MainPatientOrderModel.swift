//
//  MainDoctorPatientOrderModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/13/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainPatientOrderModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: String?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}
