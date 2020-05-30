//
//  PatientProfileSservicea.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/19/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class PatientProfileSservicea {
    static let shared=PatientProfileSservicea()
    
    func getNotifications(api_token:String,user_id:Int,completion: @escaping (MainPatientNotificationModel?, Error?) ->Void)  {
           let urlString =  "\(baseUrl)get/notification?api_token=\(api_token)&user_id=\(user_id)&user_type=PATIENT".toSecrueHttps()
           
           MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
        }
    
    func removeNotification(notification_id:Int,completion: @escaping (MainPatientRemoveNotificationModel?, Error?) ->Void)  {
        
        let nnn = "notification/remove"
                  
                  let urlString = baseUrl+nnn
                  guard  let url = URL(string: urlString.toSecrueHttps()) else { return  }
                  
                  let postString = "notification_id=\(notification_id)"
                  MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
}
