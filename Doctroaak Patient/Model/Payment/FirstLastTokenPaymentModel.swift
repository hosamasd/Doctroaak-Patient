//
//  FirstLastTokenPaymentModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/16/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct FirstLastTokenPaymentModel:Codable {
    let apiKey: String

       enum CodingKeys: String, CodingKey {
           case apiKey = "api_key"
       }
    
}
