//
//  MainServices.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/4/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

let baseUrl = "http://doctoraak.sphinxatapps.com/public/api/"


class MainServices {
    static let shared = MainServices()
    
    func getDegrees(completion: @escaping (MainDegreeModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_degree".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getSpecificationss(completion: @escaping (MainSpecificationModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_specialization".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getCitiess(completion: @escaping (MainCityModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_city".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getAreas(completion: @escaping (MainAreaModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_area".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getInsuracness(completion: @escaping (MainInsurcaneModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_insurance".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getMedicineTypes(completion: @escaping (MainMedicineTypeModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_medicines_type".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getMedicines(completion: @escaping (MainMedicineModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_medicines".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getRays(completion: @escaping (MainRaysModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_rays".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getNotifications(completion: @escaping (MainNotificationsModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_specialization".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    static func mainGetMethodGenerics<T:Codable>(urlString:String,completion:@escaping (T?,Error?)->Void)  {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                // success
                completion(objects, err)
            } catch let error {
                completion(nil, error)
            }
        }.resume()
    }
    
    static func registerationPostMethodGeneric<T:Codable>(postString:String,url:URL,completion:@escaping (T?,Error?)->Void)  {
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           
           
           request.httpBody = postString.data(using: .utf8)
           
           URLSession.shared.dataTask(with: request) { (data, response, err) in
               if let error = err {
                   completion(nil,error)
               }
               guard let data = data else {return}
               do {
                   let objects = try JSONDecoder().decode(T.self, from: data)
                   // success
                   completion(objects,nil)
               } catch let error {
                   completion(nil,error)
               }
               }.resume()
       }
}
