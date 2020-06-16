//
//  SecondSendPaymentModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/16/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct SecondSendPaymentModel:Codable {
    let authToken, deliveryNeeded, merchantID, amountCents: String
      let currency: String
      let merchantOrderID: Int
      let items: [JSONAny]
      let shippingData: SecondShippingDataModel

      enum CodingKeys: String, CodingKey {
          case authToken = "auth_token"
          case deliveryNeeded = "delivery_needed"
          case merchantID = "merchant_id"
          case amountCents = "amount_cents"
          case currency
          case merchantOrderID = "merchant_order_id"
          case items
          case shippingData = "shipping_data"
      }
}

struct SecondShippingDataModel:Codable {
    let apartment, email, floor, firstName: String
       let street, building, phoneNumber, postalCode: String
       let city, country, lastName, state: String

       enum CodingKeys: String, CodingKey {
           case apartment, email, floor
           case firstName = "first_name"
           case street, building
           case phoneNumber = "phone_number"
           case postalCode = "postal_code"
           case city, country
           case lastName = "last_name"
           case state
       }
}
