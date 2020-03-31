//
//  LAPOrderVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LAPOrderVC: CustomBaseViewVC {
    
    lazy var customLAPOrderView:CustomLAPOrderView = {
        let v = CustomLAPOrderView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
//        v.orderSegmentedView.addTarget(self, action: #selector(handleOpenOther), for: .valueChanged)
        return v
    }()
    var bubleViewHeightConstraint:NSLayoutConstraint!
    
    var isDataFound = false
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userDefaults.set(false, forKey: UserDefaultsConstants.isDataFound)
        userDefaults.synchronize()
    }
    
    override func setupViews() {
        
        view.addSubViews(views: customLAPOrderView)
        customLAPOrderView.fillSuperview()
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
}
