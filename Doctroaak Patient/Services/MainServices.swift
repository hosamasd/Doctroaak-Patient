//
//  MainServices.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/4/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import Alamofire

let baseUrl = "http://doctoraak.com/public/api/"


class MainServices {
    static let shared = MainServices()
    
    func getDegrees(completion: @escaping (MainDegreeModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_degree"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getSpecificationss(completion: @escaping (MainSpecificationModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_specialization"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getCitiess(completion: @escaping (MainCityModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_city"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getAreas(completion: @escaping (MainAreaModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_area"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getInsuracness(completion: @escaping (MainInsurcaneModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_insurance"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getMedicineTypes(completion: @escaping (MainMedicineTypeModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_medicines_type"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getMedicines(completion: @escaping (MainMedicineModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_medicines"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getRays(completion: @escaping (MainRaysModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_rays"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getNotifications(completion: @escaping (MainNotificationsModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_specialization"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
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
    
    func makeMainPostGenericUsingAlmofire<T:Codable>(urlString:String,postStrings:String,photo:UIImage? = nil,orderDetails:[PharamcyOrderModel]? = nil ,radiologyorderDetails:[RadiologyOrderModel]? = nil,completion:@escaping (T?,Error?)->Void)  {
              
               let urlsString = postStrings.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
               //
               Alamofire.upload(multipartFormData: { (multipartFormData) in
                if let photo = photo {
                   if let data = photo.pngData() {
                       multipartFormData.append(data, withName: "photo", fileName: "asd.jpeg", mimeType: "image/jpeg")
                   }
                }
                   let jsonEncoder = JSONEncoder()
                   let jsonData = try? jsonEncoder.encode(orderDetails)
                   if orderDetails?.isEmpty != nil {
                       multipartFormData.append(jsonData ?? Data(), withName: "orderDetails")
                   }
                //radiology
                let json2Encoder = JSONEncoder()
                                  let json2Data = try? jsonEncoder.encode(radiologyorderDetails)
                                  if radiologyorderDetails?.isEmpty != nil {
                                      multipartFormData.append(jsonData ?? Data(), withName: "orderDetails")
                                  }
               }, to:urlsString!)
               { (result) in
                   switch result {
                   case .success(let upload, _, _):
                       
                       upload.uploadProgress(closure: { (progress) in
                           //Print progress
                           print(progress)
                       })
                       
                       upload.responseJSON { response in
                           //print response.result
                           print(response.result)
                           guard let data = response.data else {return}
                           
                           do {
                               let objects = try JSONDecoder().decode(T.self, from: data)
                               // success
                               completion(objects,nil)
                           } catch let error {
                               completion(nil,error)
                           }
                       }
                       
                   case .failure( let encodingError):
                       completion(nil,encodingError)
                       break
                       //print encodingError.description
                   }
               }
    }
}
