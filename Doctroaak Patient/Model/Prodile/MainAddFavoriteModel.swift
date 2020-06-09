//
//  MainAddFavoriteModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/1/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct MainAddFavoriteModel:Codable {
    let status: Int
      var message, messageEn: String?
      var data: String?

      enum CodingKeys: String, CodingKey {
          case status, message
          case messageEn = "message_en"
          case data
      }
}
