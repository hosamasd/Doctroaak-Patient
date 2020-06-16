//
//  SecondLastPaymentModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/16/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct SecondLastPaymentModel:Codable {
    let authToken, amountCents: String
      let expiration: Int
      let orderID: String
      let billingData: BillingDataModel
      let currency: String
      let integrationID: Int

      enum CodingKeys: String, CodingKey {
          case authToken = "auth_token"
          case amountCents = "amount_cents"
          case expiration
          case orderID = "order_id"
          case billingData = "billing_data"
          case currency
          case integrationID = "integration_id"
      }
}

struct BillingDataModel:Codable {
    let apartment, email, floor, firstName: String
       let street, building, phoneNumber, shippingMethod: String
       let postalCode, city, country, lastName: String
       let state: String

       enum CodingKeys: String, CodingKey {
           case apartment, email, floor
           case firstName = "first_name"
           case street, building
           case phoneNumber = "phone_number"
           case shippingMethod = "shipping_method"
           case postalCode = "postal_code"
           case city, country
           case lastName = "last_name"
           case state
       }
}
