//
//  PatientFavoriteDoctorsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/12/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class PatientFavoriteDoctorsVC: CustomBaseViewVC {
    
    lazy var customPatientFavoriteDoctorsView:CustomPatientFavoriteDoctorsView = {
           let v = CustomPatientFavoriteDoctorsView()
//           v.handleDetails = {[unowned self] in
//               self.presentBeforePaymentVC()
//           }
//           v.handlePayments = {[unowned self] in
//               self.checkIfUserLogin()
//           }
//           v.mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleGoServices)))
//           v.main2View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleGoFavorites)))
//           v.main3View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleGoMyOrders)))
//
//           v.listImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenMenu)))
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
       
       var index:Int? = 0
       
       
       
       
       //MARK: -user methods
       
       override func setupNavigation()  {
           navigationController?.isNavigationBarHidden = true
       }
       
       override func setupViews()  {
           
           view.addSubview(customPatientFavoriteDoctorsView)
           customPatientFavoriteDoctorsView.fillSuperview()
           
       }
    
}
