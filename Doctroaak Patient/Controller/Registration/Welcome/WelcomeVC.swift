//
//  WelcomeVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import SVProgressHUD

let userDefaults = UserDefaults.standard

class WelcomeVC: CustomBaseViewVC {
    
    lazy var customWelcomeView:CustomWelcomeView = {
        let v = CustomWelcomeView()
        return v
    }()
    
    lazy var views = [
        customWelcomeView.drImage,
        customWelcomeView.docotrLabel,
        customWelcomeView.copyWriteLabel,
    ]
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAnimation()
    }
    
    //MARK: -user methods
    
    
    
    override func setupViews() {
        
        view.addSubview(customWelcomeView)
        customWelcomeView.fillSuperview()
    }
    
    fileprivate func setupAnimation()  {
        views.forEach({$0.alpha = 1})
        
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        let translateButtons = CGAffineTransform.init(translationX: -1000, y: 0)
        
        [ customWelcomeView.docotrLabel, customWelcomeView.copyWriteLabel].forEach({$0.transform = translateButtons})
        self.customWelcomeView.drImage.transform = translateTransform
        
        UIView.animate(withDuration: 0.5) {
            self.customWelcomeView.drImage.transform = .identity
        }
        
        self.addTransform()
        
        UIView.animate(withDuration: 0.7, delay: 0.6 * 1.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            [ self.customWelcomeView.docotrLabel, self.customWelcomeView.copyWriteLabel].forEach({$0.transform = .identity})
            self.goToNextVC()
        })
    }
    
    func goToNextVC()  {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+12) {
            self.handleNext()
        }
        
    }
    
    
    
    func addTransform()  {
        var rotationAnimation = CABasicAnimation()
        rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: (Double.pi))
        rotationAnimation.duration = 1.0
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = 10.0
        self.customWelcomeView.drImage.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    fileprivate func saveData() {
          
          !userDefaults.bool(forKey: UserDefaultsConstants.isCachedDriopLists) ? cachedDropLists() : ()
      }
    
    fileprivate func cachedDropLists() {


           var group1: [CityModel]?
           var group11: [AreaModel]?
//           var group111: [SpecificationModel]?
           var group0: [DegreeModel]?
           var group01: [InsurcaneCompanyModel]?


           SVProgressHUD.show(withStatus: "Looding....".localized)
           let semaphore = DispatchSemaphore(value: 0)

           let dispatchQueue = DispatchQueue.global(qos: .background)


           dispatchQueue.async {
               // uget citites
               MainServices.shared.getAreas { (base, err) in
                   group11 = base?.data
                   semaphore.signal()
               }
               semaphore.wait()

               //get areas
               MainServices.shared.getCitiess { (base, err) in
                   group1 = base?.data
                   semaphore.signal()
               }
               semaphore.wait()

//               MainServices.shared.getSpecificationss { (base, err) in
//                   group111 = base?.data
//                   semaphore.signal()
//               }
//               semaphore.wait()

               MainServices.shared.getDegrees { (base, err) in
                   group0 = base?.data
                   semaphore.signal()
               }
               semaphore.wait()

               MainServices.shared.getInsuracness { (base, err) in
                   group01 = base?.data
                   semaphore.signal()
               }
               semaphore.wait()

               semaphore.signal()
               self.reloadMainData(group1, group11, group0,group01)
               semaphore.wait()
           }
       }
    
    fileprivate func reloadMainData(_ group:[CityModel]?,_ group2:[AreaModel]?,_ grou:[DegreeModel]?,_ group5:[InsurcaneCompanyModel]?)  {
           
           var cityNameArray = [String]()
           var cityNameARData = [String]()
           var cityNameFR = [String]()
           var cityIdData = [Int]()
           
           var areNameArray = [String]()
           var areaNameARData = [String]()
           var areaNameFR = [String]()
           var areaCityIdData = [Int]()
           var areaIdData = [Int]()
           
//           var spyNameArray = [String]()
//           var spyNameARData = [String]()
//           var spyNameFR = [String]()
//           var spyIdData = [Int]()
           
           var dNameArray = [String]()
           var dNameARData = [String]()
           var dNameFR = [String]()
           var dIdData = [Int]()
           
           var iNameArray = [String]()
           var iNameARData = [String]()
           var iNameFR = [String]()
           var iIdData = [Int]()
           
           
           DispatchQueue.main.sync {
               
               
               SVProgressHUD.dismiss()
               
               group?.forEach({ (city) in
                   cityNameArray.append(city.name)
                   cityNameARData.append(city.nameAr)
                   cityNameFR.append(city.nameFr)
                   cityIdData.append(city.id)
               })
               
               group2?.forEach({ (city) in
                   areNameArray.append(city.name)
                   areaNameARData.append(city.nameAr)
                   areaNameFR.append(city.nameFr ?? "")
                   areaCityIdData.append(city.cityID)
                   areaIdData.append(city.id)
               })
               
               grou?.forEach({ (city) in
                   dNameArray.append(city.name)
                   dNameARData.append(city.nameAr)
                   dNameFR.append(city.nameFr)
                   dIdData.append(city.id)
               })
               
//               group4?.forEach({ (city) in
//                   spyNameArray.append(city.name)
//                   spyNameARData.append(city.nameAr)
//                   spyNameFR.append(city.nameFr )
//                   spyIdData.append(city.id)
//               })
               
               group5?.forEach({ (city) in
                   iNameArray.append(city.name)
                   iNameARData.append(city.nameAr)
                   iNameFR.append(city.nameFr )
                   iIdData.append(city.id)
               })
               
               userDefaults.set(cityNameArray, forKey: UserDefaultsConstants.cityNameArray)
               userDefaults.set(cityNameFR, forKey: UserDefaultsConstants.cityNameFRArray)
               userDefaults.set(cityNameARData, forKey: UserDefaultsConstants.cityNameARArray)
               userDefaults.set(cityIdData, forKey: UserDefaultsConstants.cityIdArray)
               
               userDefaults.set(areNameArray, forKey: UserDefaultsConstants.areaNameArray)
               userDefaults.set(areaNameFR, forKey: UserDefaultsConstants.areaNameFRArray)
               userDefaults.set(areaNameARData, forKey: UserDefaultsConstants.areaNameARArray)
               userDefaults.set(areaCityIdData, forKey: UserDefaultsConstants.areaCityIdsArrays)
               userDefaults.set(areaIdData, forKey: UserDefaultsConstants.areaIdArray)
               
//               userDefaults.set(spyNameArray, forKey: UserDefaultsConstants.specificationNameArray)
//               userDefaults.set(spyNameFR, forKey: UserDefaultsConstants.specificationNameFRArray)
//               userDefaults.set(spyNameARData, forKey: UserDefaultsConstants.specificationNameARArray)
//               userDefaults.set(spyIdData, forKey: UserDefaultsConstants.specificationIdArray)
               
               userDefaults.set(dNameArray, forKey: UserDefaultsConstants.degreeNameArray)
               userDefaults.set(dNameFR, forKey: UserDefaultsConstants.degreeNameFRArray)
               userDefaults.set(dNameARData, forKey: UserDefaultsConstants.degreeNameARArray)
               userDefaults.set(dIdData, forKey: UserDefaultsConstants.degreeIdArray)
               
               userDefaults.set(iNameArray, forKey: UserDefaultsConstants.insuranceNameArray)
               userDefaults.set(iNameFR, forKey: UserDefaultsConstants.insuranceNameFRArray)
               userDefaults.set(iNameARData, forKey: UserDefaultsConstants.insuranceNameARArray)
               userDefaults.set(iIdData, forKey: UserDefaultsConstants.insuranceIdArray)
               
               userDefaults.set(true, forKey: UserDefaultsConstants.isCityCached)
               userDefaults.set(true, forKey: UserDefaultsConstants.isAreaCached)
               userDefaults.set(true, forKey: UserDefaultsConstants.isInsuranceCached)
               userDefaults.set(true, forKey: UserDefaultsConstants.isDegreesCached)
               userDefaults.set(true, forKey: UserDefaultsConstants.isSpecificationsCached)

               
               userDefaults.set(true, forKey: UserDefaultsConstants.isCachedDriopLists)
               userDefaults.synchronize()
               self.view.layoutIfNeeded()
           }
       }
    
    //TODO: -handle methods
    
    @objc func handleNext()  {
        userDefaults.set(false, forKey: UserDefaultsConstants.isWelcomeVCAppear)
               userDefaults.synchronize()
        dismiss(animated: true)
//        let welcome = SecondWelcomeVC()
//        let nav = UINavigationController(rootViewController:welcome)
//        nav.modalPresentationStyle = .fullScreen
//        present(nav, animated: true)
        //        navigationController?.pushViewController(welcome, animated: true)
        
    }
}

