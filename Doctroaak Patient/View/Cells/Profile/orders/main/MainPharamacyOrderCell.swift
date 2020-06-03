//
//  MainPharamacyOrderCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/3/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit


class MainPharamacyOrderCell: BaseCollectionCell {
    
    lazy var pharamacyProfileOrderCollectionVC:PharamacyProfileOrderCollectionVC = {
        let vc = PharamacyProfileOrderCollectionVC()
//        vc.collectionView.isHide(true)
        
        vc.handleCheckedIndex = {[unowned self] indexPath,ind in
            self.handlePharmacyCheckedIndex?(indexPath,ind)
        }
        vc.handleCheckedIOpenImage={[unowned self] img in
            self.handleCheckedIOpenImage?(img)
        }
        return vc
    }()
    
    var handlePharmacyCheckedIndex:((PharamacyOrderPatientModel,IndexPath)->Void)?

//    var handlePharmacyCheckedIndex:((PharamacyOrderPatientModel)->Void)?
    var handleCheckedIOpenImage:((UIImage)->Void)?

    override func setupViews() {
        stack(pharamacyProfileOrderCollectionVC.view)
    }
}
