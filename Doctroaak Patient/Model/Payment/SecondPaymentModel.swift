//
//  SecondPaymentModel.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/16/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

struct SecondPaymentModel:Codable {
    var id: Int?
       let createdAt: String
       let deliveryNeeded: Bool
       let merchant: MerchantModel
       var collector: String?//JSONNull?
       let amountCents: Int
       let shippingData: ShippingDataModel
       var shippingDetails: String?//JSONNull?
       let currency: String
       let isPaymentLocked, isReturn, isCancel, isReturned: Bool
       let isCanceled: Bool
       let merchantOrderID: String
       var walletNotification: String?//JSONNull?
       let paidAmountCents: Int
       let notifyUserWithEmail: Bool
       var items: [String]?//[JSONAny]
       let orderURL: String
       let commissionFees, deliveryFeesCents, deliveryVatCents: Int
       let paymentMethod: String
       var merchantStaffTag: String?//JSONNull?
       let apiSource: String
       var pickupData: String?//JSONNull?
       var deliveryStatus: [String]?//[JSONAny]
       let token: String
       let url: String

       enum CodingKeys: String, CodingKey {
           case id
           case createdAt = "created_at"
           case deliveryNeeded = "delivery_needed"
           case merchant, collector
           case amountCents = "amount_cents"
           case shippingData = "shipping_data"
           case shippingDetails = "shipping_details"
           case currency
           case isPaymentLocked = "is_payment_locked"
           case isReturn = "is_return"
           case isCancel = "is_cancel"
           case isReturned = "is_returned"
           case isCanceled = "is_canceled"
           case merchantOrderID = "merchant_order_id"
           case walletNotification = "wallet_notification"
           case paidAmountCents = "paid_amount_cents"
           case notifyUserWithEmail = "notify_user_with_email"
           case items
           case orderURL = "order_url"
           case commissionFees = "commission_fees"
           case deliveryFeesCents = "delivery_fees_cents"
           case deliveryVatCents = "delivery_vat_cents"
           case paymentMethod = "payment_method"
           case merchantStaffTag = "merchant_staff_tag"
           case apiSource = "api_source"
           case pickupData = "pickup_data"
           case deliveryStatus = "delivery_status"
           case token, url
       }
}

struct MerchantModel:Codable {
    let id: Int
     let createdAt: String
     let phones, companyEmails: [String]
     let companyName, state, country, city: String
     let postalCode, street: String

     enum CodingKeys: String, CodingKey {
         case id
         case createdAt = "created_at"
         case phones
         case companyEmails = "company_emails"
         case companyName = "company_name"
         case state, country, city
         case postalCode = "postal_code"
         case street
     }
}

struct ShippingDataModel:Codable {
    let id: Int
       let firstName, lastName, street, building: String
       let floor, apartment, city, state: String
       let country, email, phoneNumber, postalCode: String
       let extraDescription, shippingMethod: String
       let orderID, order: Int

       enum CodingKeys: String, CodingKey {
           case id
           case firstName = "first_name"
           case lastName = "last_name"
           case street, building, floor, apartment, city, state, country, email
           case phoneNumber = "phone_number"
           case postalCode = "postal_code"
           case extraDescription = "extra_description"
           case shippingMethod = "shipping_method"
           case orderID = "order_id"
           case order
       }
}
