//
//  DoctorListsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class DoctorListsVC: CustomBaseViewVC {
    
    lazy var customDoctorListsView:CustomDoctorListsView = {
        let v = CustomDoctorListsView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        return v
    }()
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubViews(views: customDoctorListsView)
        customDoctorListsView.fillSuperview()
    }
    
  @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
}
