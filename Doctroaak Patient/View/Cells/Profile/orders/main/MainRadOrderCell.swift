//
//  MainRadOrderCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/3/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit


class MainRadOrderCell: BaseCollectionCell {
    
    lazy var radiologyProfileOrderCollectionVC:RadiologyProfileOrderCollectionVC = {
        let vc = RadiologyProfileOrderCollectionVC()
//        vc.collectionView.isHide(true)
        
        vc.handleCheckedIndex = {[unowned self] indexPath in
            self.handleRadCheckedIndex?(indexPath)
        }
        return vc
    }()
    var handleRadCheckedIndex:((RadiologyOrderPatientModel)->Void)?

    
    override func setupViews() {
        stack(radiologyProfileOrderCollectionVC.view)
    }
}
