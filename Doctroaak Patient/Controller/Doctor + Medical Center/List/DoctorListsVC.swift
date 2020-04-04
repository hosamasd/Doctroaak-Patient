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
        v.handleCheckedIndex = {[unowned self] indexPath in
            let vc = DoctorSearchVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return v
    }()
    
    var index:Int = 0
    
    
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
