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
let cacheObjectCodabe: LocalJSONStore<PatienModel> = LocalJSONStore(storageType: .cache, filename: "repos.json")
//let cacheFavoriteObjectCodabes: LocalJSONStore<[PatientSearchDoctorsModel]> = LocalJSONStore(storageType: .cache, filename: "favorite.json")

class WelcomeVC: CustomBaseViewVC {
    
    lazy var customWelcomeView:CustomWelcomeView = {
        let v = CustomWelcomeView()
        v.setupAnimation(name: "lf30_editor_itsaat")
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
        //        anyAfterCached()
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
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
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
            if userDefaults.bool(forKey: UserDefaultsConstants.isCachedDriopLists){
                self.goToNextVC()
            }else {}
        })
    }
    
    fileprivate func goToNextVC()  {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+12) {
            self.handleNext()
        }
        
    }
    
    
    
    fileprivate func addTransform()  {
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
        
        var groupL :[GetLabModel]?
        var groupR :[GetRadiologyModel]?
        var groupMN :[MedicineModel]?
        var groupMTY :[MedicineTypeModel]?
        var groupPY :[PharamacyNameModel]?
        
        var groupray :[LABAanalysisModel]?
        var grouprads :[RadiologyAanalysisModel]?
        
        var groupPayment :[[String]]?
        
        
        //        SVProgressHUD.show(withStatus: "Looding...".localized)
        let semaphore = DispatchSemaphore(value: 0)
        
        let dispatchQueue = DispatchQueue.global(qos: .background)
        
        
        dispatchQueue.async {
            
            MainServices.shared.getAnaylsisLabs { (base, err) in
                groupray = base?.data
                semaphore.signal()
            }
            semaphore.wait()
            
            MainServices.shared.getAnaylsisRadiologys { (base, err) in
                grouprads = base?.data
                semaphore.signal()
            }
            semaphore.wait()
            
            
            // uget citites
            MainServices.shared.getAreas { (base, err) in
                group11 = base?.data
                semaphore.signal()
            }
            semaphore.wait()
            
            MainServices.shared.getPaymentDetails { (base, err) in
                groupPayment = base?.data
                semaphore.signal()
            }
            semaphore.wait()
            
            MainServices.shared.getPharamacysName { (base, err) in
                groupPY = base?.data
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
            self.reloadMainData(group1, group11, group0,group01,groupL,groupR,groupMN,groupMTY,groupPayment,groupPY,groupray,grouprads)
            semaphore.wait()
            
            //            semaphore.signal()
            //            self.handleNext()
            //                       semaphore.wait()
            
        }
    }
    
    fileprivate func reloadMainData(_ group:[CityModel]?,_ group2:[AreaModel]?,_ grou:[DegreeModel]?,_ group5:[InsurcaneCompanyModel]?,_ gl:[GetLabModel]?,_ gr:[GetRadiologyModel]?,_ mN:[MedicineModel]?,_ mTY:[MedicineTypeModel]?,_ gPayment:[[String]]?,_ gppy:[PharamacyNameModel]?,_ ss:[LABAanalysisModel]? ,_ dd:[RadiologyAanalysisModel]?)  {
        
        var labAnaylsisNameArray = [String]()
        var labAnaylsisNameARData = [String]()
        var labAnaylsisNameFR = [String]()
        var labAnaylsisIdData = [Int]()
        
        var radAnaylsisNameArray = [String]()
        var radAnaylsisNameARData = [String]()
        var radAnaylsisNameFR = [String]()
        var radAnaylsisIdData = [Int]()
        
        var cityNameArray = [String]()
        var cityNameARData = [String]()
        var cityNameFR = [String]()
        var cityIdData = [Int]()
        
        var phyNameArray = [String]()
        var phyNameARData = [String]()
        var phyNameFR = [String]()
        var phyIdData = [Int]()
        
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
            
            //            self.handleDismiss()
            
            SVProgressHUD.dismiss()
            
            dd?.forEach({ (r) in
                radAnaylsisNameArray.append(r.name)
                radAnaylsisNameFR.append(r.nameAr)
                radAnaylsisNameARData.append(r.nameFr)
                radAnaylsisIdData.append(r.id)
            })
            
            ss?.forEach({ (r) in
                labAnaylsisNameArray.append(r.name)
                labAnaylsisNameFR.append(r.nameAr)
                labAnaylsisNameARData.append(r.nameFr)
                labAnaylsisIdData.append(r.id)
            })
            
            group?.forEach({ (city) in
                cityNameArray.append(city.name)
                cityNameARData.append(city.nameAr)
                cityNameFR.append(city.nameFr)
                cityIdData.append(city.id)
            })
            
            gppy?.forEach({ (city) in
                phyNameArray.append(city.name)
                phyNameARData.append(city.nameAr ?? "")
                phyNameFR.append(city.nameFr ?? "")
                phyIdData.append(city.id)
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
                mTYNameArray.append(city.name)
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
            
            removeAll()
            
            
            userDefaults.set(radNameArray, forKey: UserDefaultsConstants.radiologyNameArray)
            userDefaults.set(radNameFR, forKey: UserDefaultsConstants.radiologyNameFRArray)
            userDefaults.set(radNameARData, forKey: UserDefaultsConstants.radiologyNameARArray)
            userDefaults.set(radIdData, forKey: UserDefaultsConstants.radiologyIdArray)
            
            userDefaults.set(phyNameArray, forKey: UserDefaultsConstants.pharamacyNameArray)
            userDefaults.set(phyNameFR, forKey: UserDefaultsConstants.pharamacyNameFRArray)
            userDefaults.set(phyNameARData, forKey: UserDefaultsConstants.pharamacyNameARArray)
            userDefaults.set(phyIdData, forKey: UserDefaultsConstants.pharamacyIdrray)
            
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
            
            userDefaults.set(mTYNameArray, forKey: UserDefaultsConstants.medicineTypeArray)
            userDefaults.set(mTYNameFR, forKey: UserDefaultsConstants.medicineTypeFRArray)
            userDefaults.set(mTYNameARData, forKey: UserDefaultsConstants.medicineTypeARArray)
            userDefaults.set(mTYIdData, forKey: UserDefaultsConstants.medicineTypeIDSArray)
            
            //anaylsis
            userDefaults.set(labAnaylsisNameArray, forKey: UserDefaultsConstants.labAnalysisNameArray)
            userDefaults.set(labAnaylsisNameFR, forKey: UserDefaultsConstants.labAnalysisNameFRArray)
            userDefaults.set(labAnaylsisNameARData, forKey: UserDefaultsConstants.labAnalysisNameARArray)
            userDefaults.set(labAnaylsisIdData, forKey: UserDefaultsConstants.labAnalysisIdArray)
            
            userDefaults.set(radAnaylsisNameArray, forKey: UserDefaultsConstants.radAnalysisNameArray)
            userDefaults.set(radAnaylsisNameARData, forKey: UserDefaultsConstants.radAnalysisNameARArray)
            userDefaults.set(radAnaylsisNameFR, forKey: UserDefaultsConstants.radAnalysisNameFRArray)
            userDefaults.set(radAnaylsisIdData, forKey: UserDefaultsConstants.radAnalysisIdArray)
            
            
            userDefaults.set(dNameArray, forKey: UserDefaultsConstants.degreeNameArray)
            userDefaults.set(dNameFR, forKey: UserDefaultsConstants.degreeNameFRArray)
            userDefaults.set(dNameARData, forKey: UserDefaultsConstants.degreeNameARArray)
            userDefaults.set(dIdData, forKey: UserDefaultsConstants.degreeIdArray)
            
            userDefaults.set(iNameArray, forKey: UserDefaultsConstants.insuranceNameArray)
            userDefaults.set(iNameFR, forKey: UserDefaultsConstants.insuranceNameFRArray)
            userDefaults.set(iNameARData, forKey: UserDefaultsConstants.insuranceNameARArray)
            userDefaults.set(iIdData, forKey: UserDefaultsConstants.insuranceIdArray)
            
            userDefaults.set(gPayment, forKey: UserDefaultsConstants.paymentDetailsInfo)
            
            
            userDefaults.set(true, forKey: UserDefaultsConstants.isCityCached)
            userDefaults.set(true, forKey: UserDefaultsConstants.isAreaCached)
            userDefaults.set(true, forKey: UserDefaultsConstants.isInsuranceCached)
            userDefaults.set(true, forKey: UserDefaultsConstants.isDegreesCached)
            userDefaults.set(true, forKey: UserDefaultsConstants.isSpecificationsCached)
            userDefaults.set(true, forKey: UserDefaultsConstants.isLabCached)
            userDefaults.set(true, forKey: UserDefaultsConstants.isRadiologyCached)
            userDefaults.set(true, forKey: UserDefaultsConstants.isMedicineNameCached)
            userDefaults.set(true, forKey: UserDefaultsConstants.isMedicineTypeCached)
            userDefaults.set(true, forKey: UserDefaultsConstants.isPaymentDetailsInfo)
            userDefaults.set(true, forKey: UserDefaultsConstants.isPharamacyCached)
            
            
            
            userDefaults.set(true, forKey: UserDefaultsConstants.isCachedDriopLists)
            userDefaults.synchronize()
            self.handleNext()
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate  func removeAll()  {
        userDefaults.removeObject(forKey: UserDefaultsConstants.cityNameArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.cityNameFRArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.cityNameArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.cityIdArray)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.areaNameArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.areaNameFRArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.areaNameARArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.areaCityIdsArrays)
        userDefaults.removeObject(forKey: UserDefaultsConstants.areaIdArray)
        
//        userDefaults.removeObject(forKey: UserDefaultsConstants.specificationNameArray)
//        userDefaults.removeObject(forKey: UserDefaultsConstants.specificationNameFRArray)
//        userDefaults.removeObject(forKey: UserDefaultsConstants.specificationNameARArray)
//        userDefaults.removeObject(forKey: UserDefaultsConstants.specificationIdArray)
//        
        userDefaults.removeObject(forKey: UserDefaultsConstants.degreeNameFRArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.degreeNameArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.degreeNameARArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.degreeIdArray)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.insuranceNameArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.insuranceNameARArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.insuranceNameFRArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.insuranceIdArray)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.radiologyNameArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.radiologyNameFRArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.radiologyNameARArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.radiologyIdArray)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.pharamacyNameArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.pharamacyNameFRArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.pharamacyNameARArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.pharamacyIdrray)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.labNameArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.labNameFRArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.labNameARArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.labIdArray)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.medicineNameArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.medicineNameFTArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.medicineNameARArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.medicineNameIDSArray)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.medicineTypeArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.medicineTypeFRArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.medicineTypeARArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.medicineTypeIDSArray)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.labAnalysisNameArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.labAnalysisNameFRArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.labAnalysisNameARArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.labAnalysisIdArray)
        
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.radAnalysisNameArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.radAnalysisNameARArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.radAnalysisNameFRArray)
        userDefaults.removeObject(forKey: UserDefaultsConstants.radAnalysisIdArray)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.paymentDetailsInfo)
        
        
        
        
        
        userDefaults.set(false, forKey: UserDefaultsConstants.isCityCached)
        userDefaults.set(false, forKey: UserDefaultsConstants.isAreaCached)
        userDefaults.set(false, forKey: UserDefaultsConstants.isInsuranceCached)
        userDefaults.set(false, forKey: UserDefaultsConstants.isDegreesCached)
        userDefaults.set(false, forKey: UserDefaultsConstants.isSpecificationsCached)
        userDefaults.set(false, forKey: UserDefaultsConstants.isLabCached)
        userDefaults.set(false, forKey: UserDefaultsConstants.isRadiologyCached)
        userDefaults.set(false, forKey: UserDefaultsConstants.isMedicineNameCached)
        userDefaults.set(false, forKey: UserDefaultsConstants.isMedicineTypeCached)
        userDefaults.set(false, forKey: UserDefaultsConstants.isPaymentDetailsInfo)
        userDefaults.set(false, forKey: UserDefaultsConstants.isPharamacyCached)
        
        userDefaults.synchronize()
    }
    
    //TODO: -handle methods
    
    @objc func handleNext()  {
        userDefaults.set(false, forKey: UserDefaultsConstants.isWelcomeVCAppear)
        userDefaults.synchronize()
        if userDefaults.bool( forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODE){
            let userId = userDefaults.integer(forKey: UserDefaultsConstants.patientID)
            
            let verify = VerificationVC(user_id: userId, isFromForget: false)
            navigationController?.pushViewController(verify, animated: true)
            
        }else {
            dismiss(animated: true)
        }
    }
}

