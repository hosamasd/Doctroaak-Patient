//
//  CustomCardiologyView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import MOLH

class CustomCardiologyDoctorsResultsView: CustomBaseView {
    
    var patient:PatienModel?{
        didSet{
            guard let patient = patient else { return  }
        }
    }
    
    var doctorsArray:[PatientSearchDoctorsModel]! {
        didSet{
            patientFavoriteDoctorsCollectionVC.doctorsArray=doctorsArray
            patientFavoriteDoctorsCollectionVC.collectionView.reloadData()
        }
    }
    
    
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
    lazy var titleLabel = UILabel(text: "Doctors".localized, font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Get well soon!".localized, font: .systemFont(ofSize: 18), textColor: .white)
    lazy var mainSecondView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    var handleCheckedIndex:((PatientSearchDoctorsModel)->Void)?
    var handleBookmarkDoctor:((PatientSearchDoctorsModel)->Void)?
    
    lazy var patientFavoriteDoctorsCollectionVC:PatientFavoriteDoctorsCollectionVC = {
        let vc = PatientFavoriteDoctorsCollectionVC()
        
        vc.handleCheckedIndex = {[unowned self] indexPath in
            self.handleCheckedIndex?(indexPath)
        }
        vc.handleBookmarkDoctor = {[unowned self] doctor in
            self.handleBookmarkDoctor?(doctor)
        }
        return vc
    }()
    
    
    override func setupViews() {
        [titleLabel,soonLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        
        backgroundColor = .white
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,patientFavoriteDoctorsCollectionVC.view)
        if MOLHLanguage.isRTLLanguage() {
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
        }else {
            
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        }
        //        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        patientFavoriteDoctorsCollectionVC.view.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 64, left: 32, bottom: 16, right: 32))
    }
}
