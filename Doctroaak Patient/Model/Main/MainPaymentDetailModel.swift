//
//  MainPaymentDetailModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainPaymentDetailModel:Codable {
    var data : [[String]]?
          var messageEn,message : String?
          var status : Int?

          enum CodingKeys: String, CodingKey {
                  case data = "data"
                  case message = "message"
                  case messageEn = "message_en"
                  case status = "status"
          }
}
