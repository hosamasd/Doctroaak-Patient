//
//  CanceOrdersServices.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/3/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import Alamofire

class CanceOrdersServices {
    static let shared=CanceOrdersServices()
   // order_type = PHARMACY LAB RADIOLOGY DOCOTR
    func cancelOrder(patient_id:Int,api_token:String,order_id:Int,order_type:String,message:String,completion: @escaping (MainAddFavoriteModel?, Error?) -> ())  {
        let nnn = "patient/cancel-order"
                  let urlString = baseUrl+nnn
               guard  let url = URL(string: urlString.toSecrueHttps()) else { return  }
                  let postString = "patient_id=\(patient_id)&api_token=\(api_token)&order_id=\(order_id)&order_type=\(order_type)&message=\(message)"
                  MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
}
