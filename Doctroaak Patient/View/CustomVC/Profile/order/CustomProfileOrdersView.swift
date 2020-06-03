//
//  CustomProfileOrdersView.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class CustomProfileOrdersView: CustomBaseView {
    
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var titleLabel = UILabel(text: "Orders", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Get well soon!", font: .systemFont(ofSize: 18), textColor: .white)
    lazy var mainSecondView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var mainOrdersCollectionVC:MainOrdersCollectionVC = {
       let vc = MainOrdersCollectionVC()
        vc.handleCheckedIndexForButtons = {[unowned self] index in
            self.handleCheckedIndexForButtons?(index)
        }
        return vc
    }()
    
    lazy var doctorProfileOrderCollectionVC:DoctorProfileOrderCollectionVC = {
        let vc = DoctorProfileOrderCollectionVC()
        vc.handleCheckedIndex = {[unowned self] indexPath in
            self.handleDoctorCheckedIndex?(indexPath)
        }
        return vc
    }()
    lazy var radiologyProfileOrderCollectionVC:RadiologyProfileOrderCollectionVC = {
        let vc = RadiologyProfileOrderCollectionVC()
        vc.collectionView.isHide(true)
        
        vc.handleCheckedIndex = {[unowned self] indexPath in
            self.handleRadCheckedIndex?(indexPath)
        }
        return vc
    }()
    lazy var pharamacyProfileOrderCollectionVC:PharamacyProfileOrderCollectionVC = {
        let vc = PharamacyProfileOrderCollectionVC()
        vc.collectionView.isHide(true)
        
        vc.handleCheckedIndex = {[unowned self] indexPath in
            self.handlePharmacyCheckedIndex?(indexPath)
        }
        return vc
    }()
    lazy var labProfileOrderCollectionVC:LABProfileOrderCollectionVC = {
        let vc = LABProfileOrderCollectionVC()
        vc.collectionView.isHide(true)
        vc.handleCheckedIndex = {[unowned self] indexPath in
            self.handleLABCheckedIndex?(indexPath)
        }
        return vc
    }()
    var handleCheckedIndexForButtons:((Int)->Void)?

    var handleRadCheckedIndex:((RadiologyOrderPatientModel)->Void)?
    var handleLABCheckedIndex:((LABOrderPatientModel)->Void)?
    var handlePharmacyCheckedIndex:((PharamacyOrderPatientModel)->Void)?
    var handleDoctorCheckedIndex:((DoctorsOrderPatientModel)->Void)?
    
    override func setupViews() {
        backgroundColor = .white
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,mainOrdersCollectionVC.view)//,radiologyProfileOrderCollectionVC.view)

//        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,doctorProfileOrderCollectionVC.view,pharamacyProfileOrderCollectionVC.view,labProfileOrderCollectionVC.view,radiologyProfileOrderCollectionVC.view)
        
        //        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,doctorProfileOrderCollectionVC.view)
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        mainOrdersCollectionVC.view.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 64, left: 8, bottom: 0, right: 8))
//        radiologyProfileOrderCollectionVC.view.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 64, left: 8, bottom: 0, right: 8))
//        labProfileOrderCollectionVC.view.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 64, left: 8, bottom: 0, right: 8))
//        pharamacyProfileOrderCollectionVC.view.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 64, left: 8, bottom: 0, right: 8))
    }
}

