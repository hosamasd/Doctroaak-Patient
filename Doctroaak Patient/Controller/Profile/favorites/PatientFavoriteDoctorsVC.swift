//
//  PatientFavoriteDoctorsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/12/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

class PatientFavoriteDoctorsVC: CustomBaseViewVC {
    
    lazy var customPatientFavoriteeseDoctorsView:CustomPatientFavoriteeseDoctorsView = {
        let v = CustomPatientFavoriteeseDoctorsView()
        v.handleBookmarkDoctor = {[unowned self] doctor,indexPath in
            self.removeBookmarked(doctor,indexPath)
        }
        v.handleCheckedIndex = {[unowned self] d in
            self.goToSelectedDocotor(d)
        }
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        return v
    }()
    lazy var customMainAlertVC:CustomMainAlertVC = {
        let t = CustomMainAlertVC()
        //           t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    lazy var customAlertLoginView:CustomAlertLoginView = {
        let v = CustomAlertLoginView()
        v.setupAnimation(name: "4970-unapproved-cross")
        //           v.handleOkTap = {[unowned self] in
        //               self.handleremoveLoginAlert()
        //           }
        return v
    }()
    var patient:PatienModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) {
            patient=cacheObjectCodabe.storedValue
        }else {}
        fetchFavorites( )
    }
    
    
    
    //MARK: -user methods
    
    
    override func setupNavigation()  {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func setupViews()  {
        view.addSubview(customPatientFavoriteeseDoctorsView)
        customPatientFavoriteeseDoctorsView.fillSuperview()
        
    }
    
    func removeBookmarked(_ doctor:PatientFavoriteModel,_ indexPath:IndexPath)  {
        guard let patient = patient else { return  }
        self.customPatientFavoriteeseDoctorsView.patientFavoriteDoctorsCollectionVC.doctorsArray.remove(at: indexPath.item)
        //                UIApplication.shared.beginReceivingRemoteControlEvents()
        
        //        view.isUserInteractionEnabled = false
        SVProgressHUD.show(withStatus: "Removing...".localized)
        
        PatientProfileSservicea.shared.favoriteDoctors(patient_id: patient.id, doctor_id: doctor.id, api_token: patient.apiToken) { (base, err) in
            
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base else { return}
            
            DispatchQueue.main.async {
                self.showToast(context: self, msg: MOLHLanguage.isRTLLanguage() ? user.message : user.messageEn)
                
                self.customPatientFavoriteeseDoctorsView.patientFavoriteDoctorsCollectionVC.collectionView.deleteItems(at: [indexPath])
            }
            
        }
        
        
        print(indexPath.item)
    }
    
    func fetchFavorites()  {
        
        guard let patient = patient else { return  }
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //        view.isUserInteractionEnabled = false
        SVProgressHUD.show(withStatus: "Looding...".localized)
        
        PatientProfileSservicea.shared.getPatientFavoriteDocotrs(patient_id: patient.id, api_token: patient.apiToken) { (base, err) in
            
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.messageEn : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.putData(user)
            }
            
        }
    }
    
    func goToSelectedDocotor(_ d:PatientFavoriteModel)  {
        let selected = DeatilsSelectedDoctorsVC()//(doctors: d)
        selected.selectedSecondDoctor=d
        selected.isFavorite=true
        navigationController?.pushViewController(selected, animated: true)
    }
    
    func putData(_ favorites:[PatientFavoriteModel ])  {
        customPatientFavoriteeseDoctorsView.patientFavoriteDoctorsCollectionVC.doctorsArray=favorites
        
        customPatientFavoriteeseDoctorsView.patientFavoriteDoctorsCollectionVC.collectionView.reloadData()
    }
    
    @objc  func handleBack()  {
        dismiss(animated: true)
    }
    
}
