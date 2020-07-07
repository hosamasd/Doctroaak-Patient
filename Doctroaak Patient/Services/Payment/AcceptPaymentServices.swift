//
//  AcceptPaymentServices.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/16/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import Alamofire

class AcceptPaymentServices {
    static let shared = AcceptPaymentServices()
    
    func firsttRequest(first:String,completion: @escaping (FirstPaymentModel?, Error?) ->Void)  {
        
        let urlString = "https://accept.paymobsolutions.com/api/auth/tokens"
        guard let url = URL(string: urlString) else { return  }
        let parameters:[String:String] = [
            "api_key":first
        ]
        
        makeMainPostFORPaymentsGenericUsingAlmofire(url: url, parameters: parameters, completion: completion)
        
        
    }
    
    func secondRequest(auth_token:String,id:String,random:Int,completion: @escaping (SecondPaymentModel?, Error?) ->Void)  {
        
        let urlString = "https://accept.paymobsolutions.com/api/ecommerce/orders"
        guard let url = URL(string: urlString) else { return  }
        let params:[String:Any] = [
            "auth_token":auth_token,
            "delivery_needed": "false",
            "merchant_id": id,
            "amount_cents": "20000",
            "currency": "EGP",
            "merchant_order_id": random,
            "items": [],
            "shipping_data": [
                "apartment": "803",
                "email": "claudette09@exa.com",
                "floor": "42",
                "first_name": "Clifford",
                "street": "Ethan Land",
                "building": "8028",
                "phone_number": "+86(8)9135210487",
                "postal_code": "01898",
                "city": "Jaskolskiburgh",
                "country": "CR",
                "last_name": "Nicolas",
                "state": "Utah"
            ]
        ]
        makeMainPostFORPaymentsGenericUsingAlmofire(url: url, parameters: params, completion: completion)
        
        
    }
    
    func thirdLastTokenRequest(auth_token:String,completion: @escaping (LastTokenPaymentModel?, Error?) ->Void)  {
        let urlString = "https://accept.paymobsolutions.com/api/acceptance/payment_keys"
        guard let url = URL(string: urlString) else { return  }
        
        let params:[String:Any] = [
            "auth_token": auth_token,
            "amount_cents": "20000",
            "expiration": 3600,
            "order_id": "5234732",
            "billing_data": [
                "apartment": "803",
                "email": "claudette09@exa.com",
                "floor": "42",
                "first_name": "Clifford",
                "street": "Ethan Land",
                "building": "8028",
                "phone_number": "+86(8)9135210487",
                "shipping_method": "PKG",
                "postal_code": "01898",
                "city": "Jaskolskiburgh",
                "country": "CR",
                "last_name": "Nicolas",
                "state": "Utah"
            ],
            "currency": "EGP",
            "integration_id": 21479
        ]
        makeMainPostFORPaymentsGenericUsingAlmofire(url: url, parameters: params, completion: completion)
    }
    
    
    
    
    func makeMainPostFORPaymentsGenericUsingAlmofire<T:Codable>(url:URL,parameters:[String:Any],completion:@escaping (T?,Error?)->Void)  {
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                guard let data = response.data else {return}
                
                do {
                    let objects = try JSONDecoder().decode(T.self, from: data)
                    // success
                    completion(objects,nil)
                } catch let error {
                    completion(nil,error)
                }
        }
        
    }
}
