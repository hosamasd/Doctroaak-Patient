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
        t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    lazy var customAlertLoginView:CustomAlertLoginView = {
        let v = CustomAlertLoginView()
        v.setupAnimation(name: "4970-unapproved-cross")
        v.handleOkTap = {[unowned self] in
            self.handleDismiss()
        }
        return v
    }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    
    var patient:PatienModel?
    fileprivate let index:Int!
    
    init(index:Int) {
        self.index=index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
//        SVProgressHUD.show(withStatus: "Removing...".localized)
        
//        UIApplication.shared.beginIgnoringInteractionEvents()
        self.showMainAlertLooder()
        PatientProfileSservicea.shared.favoriteDoctors(patient_id: patient.id, doctor_id: doctor.id, api_token: patient.apiToken) { (base, err) in
            
            if let err = err {
                                SVProgressHUD.showError(withStatus: err.localizedDescription)
//                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
//            SVProgressHUD.dismiss()
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base else { return}
            
            DispatchQueue.main.async {
                self.showToast(context: self, msg: MOLHLanguage.isRTLLanguage() ? user.message ?? "" : user.messageEn ?? "")
                
                self.customPatientFavoriteeseDoctorsView.patientFavoriteDoctorsCollectionVC.collectionView.deleteItems(at: [indexPath])
            }
            
        }
        
        
        print(indexPath.item)
    }
    
    func fetchFavorites()  {
        
        guard let patient = patient else { return  }
        
//        UIApplication.shared.beginIgnoringInteractionEvents()
        self.showMainAlertLooder()
        
        PatientProfileSservicea.shared.getPatientFavoriteDocotrs(patient_id: patient.id, api_token: patient.apiToken) { (base, err) in
            
            if let err = err {
                                SVProgressHUD.showError(withStatus: err.localizedDescription)
//                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            //            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.messageEn : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.putData(user)
            }
            
        }
    }
    
    func showMainAlertLooder()  {
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingView, height: 200)
        customAlertMainLoodingView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func goToSelectedDocotor(_ d:PatientFavoriteModel)  {
        let selected = DeatilsSelectedDoctorsVC(index: self.index)//(doctors: d)
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
