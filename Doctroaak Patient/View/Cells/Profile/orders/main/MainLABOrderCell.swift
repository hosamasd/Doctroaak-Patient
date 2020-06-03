//
//  MainLABOrderCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/3/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit


class MainLABOrderCell: BaseCollectionCell {
    
    lazy var labProfileOrderCollectionVC:LABProfileOrderCollectionVC = {
           let vc = LABProfileOrderCollectionVC()
//           vc.collectionView.isHide(true)
           vc.handleCheckedIndex = {[unowned self] indexPath,ind in
               self.handleLABCheckedIndex?(indexPath,ind)
           }
        vc.handleCheckedIOpenImage={[unowned self] img in
                   self.handleCheckedIOpenImage?(img)
               }
           return vc
       }()
    var handleLABCheckedIndex:((LABOrderPatientModel,IndexPath)->Void)?
    var handleCheckedIOpenImage:((UIImage)->Void)?

    override func setupViews() {
        stack(labProfileOrderCollectionVC.view)
    }
}
