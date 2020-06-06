//
//  CardiologyVC.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import CodableCache

let reteriveAllFavorteStorage = "allFavorite"

class CardiologyDoctorsResultsVC: CustomBaseViewVC {
    
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
            self.handleremoveLoginAlert()
        }
        return v
    }()
    lazy var customCardiologyDoctorsResultsView:CustomCardiologyDoctorsResultsView = {
        let v = CustomCardiologyDoctorsResultsView()
        v.doctorsArray=doctorsArray
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        
        v.handleCheckedIndex = {[unowned self] doctor in
            let cDetails = DeatilsSelectedDoctorsVC(doctors: doctor)
            cDetails.patient=self.patient
            //            cDetails.patientApiToken=self.patientApiToken
            //            cDetails.patient_id=self.patient_id
            self.navigationController?.pushViewController(cDetails, animated: true)
        }
        v.handleBookmarkDoctor = {[unowned self] doctor in
            self.checkIfLogggined(doctor: doctor)
        }
        
        return v
    }()
    
    var patient:PatienModel?{
        didSet{
            guard let patient = patient else { return  }
            customCardiologyDoctorsResultsView.patient=patient
        }
    }
    var isBookmarked:Bool = false
    
    //    var patient_id:Int?
    //    var patientApiToken:String?
    fileprivate let doctorsArray:[PatientSearchDoctorsModel]!
    init(doctors:[PatientSearchDoctorsModel]) {
        self.doctorsArray=doctors
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     
    func checkIfLogggined(doctor:PatientSearchDoctorsModel)  {
        if !userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) {
            customMainAlertVC.addCustomViewInCenter(views: customAlertLoginView, height: 200)
            customAlertLoginView.problemsView.loopMode = .loop
            present(customMainAlertVC, animated: true)
        }else {
            handleBookmarkOrNot(doctor: doctor)
        }
    }
    
    func handleBookmarkOrNot(doctor:PatientSearchDoctorsModel)  {
        
        //        if var favoriteee=FavoriteStorage.retrieve(reteriveAllFavorteStorage, from: .documents, as: PatientSearchDoctorsModel.self)  {
        //            if customCardiologyDoctorsResultsView.patientFavoriteDoctorsCollectionVC.isFavorite {
        //                           favoriteee.removeAll(where: {$0.name==doctor.name})
        //                       }else {
        //                           favoriteee.append(doctor)
        //                       }
        //                       FavoriteStorage.storesss(favoriteee, to: .documents, as: reteriveAllFavorteStorage)
        //
        //
        ////        if var favorites = FavoriteStorage.retrievess(reteriveAllFavorteStorage, from: .documents, as: PatientSearchDoctorsModel.self){
        ////            if customCardiologyDoctorsResultsView.patientFavoriteDoctorsCollectionVC.isFavorite {
        ////                favorites.removeAll(where: {$0.name==doctor.name})
        ////            }else {
        ////                favorites.append(doctor)
        ////            }
        ////            FavoriteStorage.storesss(favorites, to: .documents, as: reteriveAllFavorteStorage)
        //
        //        }else {
        //
        //            FavoriteStorage.storesss([doctor], to: .documents, as: reteriveAllFavorteStorage)
        //
        ////            customCardiologyDoctorsResultsView.patientFavoriteDoctorsCollectionVC.isFavorite = !customCardiologyDoctorsResultsView.patientFavoriteDoctorsCollectionVC.isFavorite
        //
        //        }
        DispatchQueue.main.async {
            //            self.customCardiologyDoctorsResultsView.patientFavoriteDoctorsCollectionVC.collectionView.reloadData()
        }
        
        //        FavoriteStorage.store(doctor, to: .documents, as: "favorites")
        //        FavoriteStorage.sto
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.addSubview(customCardiologyDoctorsResultsView)
        customCardiologyDoctorsResultsView.fillSuperview()
    }
    
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDismiss()  {
        dismiss(animated: true, completion: nil)
    }
    
    func handleremoveLoginAlert()  {
        removeViewWithAnimation(vvv: customAlertLoginView)
        customMainAlertVC.dismiss(animated: true)
        let login = LoginVC()
        login.delgate = self
        let nav = UINavigationController(rootViewController: login)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        //        removeViewWithAnimation(vvv: customAlertLoginView)
        //        customMainAlertVC.dismiss(animated: true)
    }
}

extension CardiologyDoctorsResultsVC:LoginVCPrototcol {
    func useApiAndPatienId(patient: PatienModel) {
        self.patient = cacheObjectCodabe.storedValue
    }
    
    
}
