//
//  CardiologyVC.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import CodableCache
import SVProgressHUD
import MOLH

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
            let cDetails = DeatilsSelectedDoctorsVC(index: self.index)//(doctors: doctor)
            cDetails.patient=self.patient
            cDetails.selectedDoctor=doctor
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
    fileprivate let index:Int!

    init(doctors:[PatientSearchDoctorsModel],index:Int) {
        self.doctorsArray=doctors
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
        } else {}
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
        
        guard let patient = patient else { return  }
        
        PatientProfileSservicea.shared.favoriteDoctors(patient_id: patient.id, doctor_id: doctor.id, api_token: patient.apiToken) { (base, err) in
            
        if let err = err {
                       SVProgressHUD.showError(withStatus: err.localizedDescription)
                   }
            guard let mess = base else {return}
            let message = MOLHLanguage.isRTLLanguage() ? mess.message : mess.messageEn
            
            DispatchQueue.main.async {
                self.showToast(context: self, msg: message ?? "")
            }
        }
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
