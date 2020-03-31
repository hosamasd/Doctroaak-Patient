//
//  PharmacyOrderVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class PharmacyOrderVC: CustomBaseViewVC {
    
    lazy var customPharmacyOrderView:CustomPharmacyOrderView = {
        let v = CustomPharmacyOrderView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        return v
    }()
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubViews(views: customPharmacyOrderView)
        customPharmacyOrderView.fillSuperview()
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
}
