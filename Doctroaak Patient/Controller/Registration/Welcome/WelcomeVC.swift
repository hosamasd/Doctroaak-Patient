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
        anyAfterCached()
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
    
    func anyAfterCached()  {
        var groupL :[MedicineModel]?
        var groupR :[MedicineTypeModel]?
        
        SVProgressHUD.show(withStatus: "Looding....".localized)
        let semaphore = DispatchSemaphore(value: 0)
        
        let dispatchQueue = DispatchQueue.global(qos: .background)
        
        
        dispatchQueue.async {
            MainServices.shared.getMedicineTypes { (base, err) in
                groupR = base?.data
                semaphore.signal()
            }
            semaphore.wait()
            
            MainServices.shared.getMedicines { (base, err) in
                groupL = base?.data
                semaphore.signal()
            }
            semaphore.wait()
            
            semaphore.signal()
            self.reloadMainDatas(groupL,groupR)
            semaphore.wait()
        }
    }
    
    func reloadMainDatas(_ gl:[MedicineModel]?,_ gr:[MedicineTypeModel]?)  {
        var mmNNameArray = [String]()
        var mNNameFR = [String]()
        var mNNameARData = [String]()
        var mNIdData = [Int]()
        
        var mTYNameArray = [String]()
        var mTYNameFR = [String]()
        var mTYNameARData = [String]()
        var mTYIdData = [Int]()
        
        gl?.forEach({ (city) in
            mmNNameArray.append(city.name)
            mNNameARData.append(city.nameAr)
            mNNameFR.append(city.nameFr )
            mNIdData.append(city.id)
        })
        
        gr?.forEach({ (city) in
            mTYNameArray.append(city.name)
            mTYNameARData.append(city.nameAr)
            mTYNameFR.append(city.nameFr )
            mTYIdData.append(city.id)
        })
        
        //        userDefaults.set(radNameArray, forKey: UserDefaultsConstants.radiologyNameArray)
        //        userDefaults.set(radNameFR, forKey: UserDefaultsConstants.radiologyNameFRArray)
        //        userDefaults.set(radNameARData, forKey: UserDefaultsConstants.radiologyNameARArray)
        //        userDefaults.set(radIdData, forKey: UserDefaultsConstants.radiologyIdArray)
        //
        //        userDefaults.set(labNameArray, forKey: UserDefaultsConstants.labNameArray)
        //        userDefaults.set(labNameFR, forKey: UserDefaultsConstants.labNameFRArray)
        //        userDefaults.set(labNameARData, forKey: UserDefaultsConstants.labNameARArray)
        //        userDefaults.set(labIdData, forKey: UserDefaultsConstants.labIdArray)
        userDefaults.set(mmNNameArray, forKey: UserDefaultsConstants.medicineNameArray)
        userDefaults.set(mNNameFR, forKey: UserDefaultsConstants.medicineNameFTArray)
        userDefaults.set(mNNameARData, forKey: UserDefaultsConstants.medicineNameARArray)
        userDefaults.set(mNIdData, forKey: UserDefaultsConstants.medicineNameIDSArray)
        
        userDefaults.set(mTYNameArray, forKey: UserDefaultsConstants.medicineTypeArray)
        
        userDefaults.set(mTYNameFR, forKey: UserDefaultsConstants.medicineTypeFRArray)
        userDefaults.set(mTYNameARData, forKey: UserDefaultsConstants.medicineTypeARArray)
        userDefaults.set(mTYIdData, forKey: UserDefaultsConstants.medicineTypeIDSArray)
        
        userDefaults.synchronize()
    }
    
    fileprivate func cachedDropLists() {
        
        
        var group1: [CityModel]?
        var group11: [AreaModel]?
        //           var group111: [SpecificationModel]?
        var group0: [DegreeModel]?
        var group01: [InsurcaneCompanyModel]?
        
        var groupL :[GetLabModel]?
        var groupR :[GetRadiologyModel]?
        var groupMN :[MedicineModel]?
        var groupMTY :[MedicineTypeModel]?
        
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
            
            MainServices.shared.getRadiologys { (base, err) in
                groupR = base?.data
                semaphore.signal()
            }
            semaphore.wait()
            
            MainServices.shared.getLabs { (base, err) in
                groupL = base?.data
                semaphore.signal()
            }
            semaphore.wait()
            
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
            
            MainServices.shared.getMedicineTypes { (base, err) in
                groupMTY = base?.data
                semaphore.signal()
            }
            semaphore.wait()
            
            MainServices.shared.getMedicines { (base, err) in
                groupMN = base?.data
                semaphore.signal()
            }
            semaphore.wait()
            
            semaphore.signal()
            self.reloadMainData(group1, group11, group0,group01,groupL,groupR,groupMN,groupMTY)
            semaphore.wait()
        }
    }
    
    fileprivate func reloadMainData(_ group:[CityModel]?,_ group2:[AreaModel]?,_ grou:[DegreeModel]?,_ group5:[InsurcaneCompanyModel]?,_ gl:[GetLabModel]?,_ gr:[GetRadiologyModel]?,_ mN:[MedicineModel]?,_ mTY:[MedicineTypeModel]?)  {
        
        var cityNameArray = [String]()
        var cityNameARData = [String]()
        var cityNameFR = [String]()
        var cityIdData = [Int]()
        
        var areNameArray = [String]()
        var areaNameARData = [String]()
        var areaNameFR = [String]()
        var areaCityIdData = [Int]()
        var areaIdData = [Int]()
        
        var labNameArray = [String]()
        var labNameARData = [String]()
        var labNameFR = [String]()
        var labIdData = [Int]()
        
        var radNameArray = [String]()
        var radNameARData = [String]()
        var radNameFR = [String]()
        var radIdData = [Int]()
        
        var dNameArray = [String]()
        var dNameARData = [String]()
        var dNameFR = [String]()
        var dIdData = [Int]()
        
        var iNameArray = [String]()
        var iNameARData = [String]()
        var iNameFR = [String]()
        var iIdData = [Int]()
        
        var mTYNameArray = [String]()
        var mTYNameARData = [String]()
        var mTYNameFR = [String]()
        var mTYIdData = [Int]()
        
        var mmNNameArray = [String]()
        var mNNameARData = [String]()
        var mNNameFR = [String]()
        var mNIdData = [Int]()
        
        
        DispatchQueue.main.sync {
            
            
            SVProgressHUD.dismiss()
            
            group?.forEach({ (city) in
                cityNameArray.append(city.name)
                cityNameARData.append(city.nameAr)
                cityNameFR.append(city.nameFr)
                cityIdData.append(city.id)
            })
            
            gl?.forEach({ (city) in
                labNameArray.append(city.name)
                labNameARData.append(city.nameAr ?? "")
                labNameFR.append(city.nameFr ?? "")
                labIdData.append(city.id)
            })
            
            gr?.forEach({ (city) in
                radNameArray.append(city.name)
                radNameARData.append(city.nameAr ?? "")
                radNameFR.append(city.nameFr ?? "")
                radIdData.append(city.id)
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
            
            mN?.forEach({ (city) in
                mmNNameArray.append(city.name)
                mmNNameArray.append(city.nameAr)
                mNNameFR.append(city.nameFr )
                mNIdData.append(city.id)
            })
            
            mTY?.forEach({ (city) in
                mmNNameArray.append(city.name)
                mTYNameArray.append(city.nameAr)
                mTYNameFR.append(city.nameFr )
                mTYIdData.append(city.id)
            })
            
            group5?.forEach({ (city) in
                iNameArray.append(city.name)
                iNameARData.append(city.nameAr)
                iNameFR.append(city.nameFr )
                iIdData.append(city.id)
            })
            
            userDefaults.set(radNameArray, forKey: UserDefaultsConstants.radiologyNameArray)
            userDefaults.set(radNameFR, forKey: UserDefaultsConstants.radiologyNameFRArray)
            userDefaults.set(radNameARData, forKey: UserDefaultsConstants.radiologyNameARArray)
            userDefaults.set(radIdData, forKey: UserDefaultsConstants.radiologyIdArray)
            
            userDefaults.set(labNameArray, forKey: UserDefaultsConstants.labNameArray)
            userDefaults.set(labNameFR, forKey: UserDefaultsConstants.labNameFRArray)
            userDefaults.set(labNameARData, forKey: UserDefaultsConstants.labNameARArray)
            userDefaults.set(labIdData, forKey: UserDefaultsConstants.labIdArray)
            
            userDefaults.set(cityNameArray, forKey: UserDefaultsConstants.cityNameArray)
            userDefaults.set(cityNameFR, forKey: UserDefaultsConstants.cityNameFRArray)
            userDefaults.set(cityNameARData, forKey: UserDefaultsConstants.cityNameARArray)
            userDefaults.set(cityIdData, forKey: UserDefaultsConstants.cityIdArray)
            
            userDefaults.set(areNameArray, forKey: UserDefaultsConstants.areaNameArray)
            userDefaults.set(areaNameFR, forKey: UserDefaultsConstants.areaNameFRArray)
            userDefaults.set(areaNameARData, forKey: UserDefaultsConstants.areaNameARArray)
            userDefaults.set(areaCityIdData, forKey: UserDefaultsConstants.areaCityIdsArrays)
            userDefaults.set(areaIdData, forKey: UserDefaultsConstants.areaIdArray)
            
            userDefaults.set(mmNNameArray, forKey: UserDefaultsConstants.medicineNameArray)
            userDefaults.set(mNNameFR, forKey: UserDefaultsConstants.medicineNameFTArray)
            userDefaults.set(mNNameARData, forKey: UserDefaultsConstants.medicineNameARArray)
            userDefaults.set(mNIdData, forKey: UserDefaultsConstants.medicineNameIDSArray)
            
            userDefaults.set(mmNNameArray, forKey: UserDefaultsConstants.medicineTypeArray)
            userDefaults.set(mNNameFR, forKey: UserDefaultsConstants.medicineTypeFRArray)
            userDefaults.set(mNNameARData, forKey: UserDefaultsConstants.medicineTypeARArray)
            userDefaults.set(mNIdData, forKey: UserDefaultsConstants.medicineTypeIDSArray)
            
            
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
            userDefaults.set(true, forKey: UserDefaultsConstants.isLabCached)
            userDefaults.set(true, forKey: UserDefaultsConstants.isRadiologyCached)
            userDefaults.set(true, forKey: UserDefaultsConstants.isMedicineNameCached)
            userDefaults.set(true, forKey: UserDefaultsConstants.isMedicineTypeCached)
            
            
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

