//
//  DoctorSearchVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit


class DoctorSearchVC: CustomBaseViewVC {
    
    
    lazy var customDoctorSearchView:CustomDoctorSearchView = {
        let v = CustomDoctorSearchView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.handlerChooseLocation = {[unowned self] in
                      let loct = ChooseLocationVC()
            loct.delgate = self
            self.navigationController?.pushViewController(loct, animated: true)
                   }
        return v
    }()
    

    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubViews(views: customDoctorSearchView)
        customDoctorSearchView.fillSuperview()
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }

}

extension DoctorSearchVC: ChooseLocationVCProtocol {
    func getLatAndLong(lat: Double, long: Double) {
        print(lat, "            ",long)
    }
    
    
}
