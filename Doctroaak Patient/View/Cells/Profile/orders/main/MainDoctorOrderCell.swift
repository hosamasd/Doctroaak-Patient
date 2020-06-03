//
//  MainDoctorOrderCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/3/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class MainDoctorOrderCell: BaseCollectionCell {
    
    lazy var doctorProfileOrderCollectionVC:DoctorProfileOrderCollectionVC = {
        let vc = DoctorProfileOrderCollectionVC()
        vc.handleCheckedIndex = {[unowned self] indexPath,index in
            self.handleDoctorCheckedIndex?(indexPath,index)
        }
        return vc
    }()
    
    
   
    var handleDoctorCheckedIndex:((DoctorsOrderPatientModel,IndexPath)->Void)?

//    var handleDoctorCheckedIndex:((DoctorsOrderPatientModel)->Void)?
    
    override func setupViews() {
        stack(doctorProfileOrderCollectionVC.view)

    }
}
