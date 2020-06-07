//
//  CustomProfileOrdersView.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH

class CustomProfileOrdersView: CustomBaseView {
    
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: MOLHLanguage.isRTLLanguage() ? #imageLiteral(resourceName: "left-arrow") : #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var titleLabel = UILabel(text: "Orders".localized, font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Get well soon!".localized, font: .systemFont(ofSize: 18), textColor: .white)
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
        vc.handleCheckedIOpenImage = {[unowned self] index in
            self.handleCheckedIOpenImage?(index)
        }
        
        vc.handleRADCheckedIndex = {[unowned self] index,ind in
            self.handleRadCheckedIndex?(index,ind)
        }
        vc.handleLABCheckedIndex = {[unowned self] index,ind in
            self.handleLABCheckedIndex?(index,ind)
        }
        vc.handleDCheckedIndex = {[unowned self] index,ind in
            self.handleDoctorCheckedIndex?(index,ind)
        }
        vc.handlePYCheckedIndex = {[unowned self] index,ind in
            self.handlePharmacyCheckedIndex?(index,ind)
        }
        vc.handleRateIndex = {[unowned self] index in
            self.handleRateIndex?(index)
        }
        return vc
    }()
    var handleCheckedIndexForButtons:((Int)->Void)?
    
    var handleRadCheckedIndex:((RadiologyOrderPatientModel,IndexPath)->Void)?
    var handleLABCheckedIndex:((LABOrderPatientModel,IndexPath)->Void)?
    var handlePharmacyCheckedIndex:((PharamacyOrderPatientModel,IndexPath)->Void)?
    var handleDoctorCheckedIndex:((DoctorsOrderPatientModel,IndexPath)->Void)?
    var handleCheckedIOpenImage:((UIImage)->Void)?
    var handleRateIndex:((DoctorsOrderPatientModel)->Void)?
    
    override func setupViews() {
        backgroundColor = .white
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,mainOrdersCollectionVC.view)//,radiologyProfileOrderCollectionVC.view)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        mainOrdersCollectionVC.view.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 64, left: 8, bottom: 0, right: 8))
    }
}

