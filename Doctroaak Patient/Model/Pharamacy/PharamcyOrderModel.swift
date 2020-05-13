//
//  PharamcyOrderModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/13/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct PharamcyOrderModel:Codable {
    let medicineID, medicineTypeID, amount: Int

    enum CodingKeys: String, CodingKey {
        case medicineID = "medicine_id"
        case medicineTypeID = "medicine_type_id"
        case amount
    }
}
