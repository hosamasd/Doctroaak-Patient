//
//  RadiologyOrderModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/13/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
struct RadiologyOrderModel:Codable {
     let raysID: Int

       enum CodingKeys: String, CodingKey {
           case raysID = "rays_id"
       }
}
