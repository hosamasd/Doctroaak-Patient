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
        
        vc.handleCheckedIndex = {[unowned self] indexPath,ind in
            self.handleRadCheckedIndex?(indexPath,ind)
        }
        vc.handleCheckedIOpenImage={[unowned self] img in
            self.handleCheckedIOpenImage?(img)
        }
        return vc
    }()
    var handleRadCheckedIndex:((RadiologyOrderPatientModel,IndexPath)->Void)?
    var handleCheckedIOpenImage:((UIImage)->Void)?
    
    
    override func setupViews() {
        stack(radiologyProfileOrderCollectionVC.view)
    }
}
