//
//  CustomPatientFavoriteeseDoctorsView.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/1/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH

class CustomPatientFavoriteeseDoctorsView: CustomBaseView {
    
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
    lazy var sampleRosetaImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "G4-G5 Sample Rx"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var titleLabel = UILabel(text: "Favorite\nDoctor".localized, font: .systemFont(ofSize: 30), textColor: .white,numberOfLines:2)
    
    lazy var patientFavoriteDoctorsCollectionVC:PatientFavoritessDoctorsCollectionVC = {
        let v = PatientFavoritessDoctorsCollectionVC()
        v.handleBookmarkDoctor = {[unowned self] d,x in
            self.handleBookmarkDoctor?(d,x)
        }
        v.handleCheckedIndex = {[unowned self] d in
            self.handleCheckedIndex?(d)
        }
        return v
    }()
    var handleBookmarkDoctor:((PatientFavoriteModel,IndexPath)->Void)?
    var handleCheckedIndex:((PatientFavoriteModel)->Void)?
    
    
    override func setupViews() {
        [titleLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})

        addSubViews(views: LogoImage,backImage,titleLabel,patientFavoriteDoctorsCollectionVC.view)
        //        addSubViews(views: LogoImage,backImage,titleLabel,doctorHomePatientsCell,ss)//,ss,docotrCollectionView.view)
        
        if MOLHLanguage.isRTLLanguage() {
                  LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
              }else {
                  
                  LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
              }
//        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        patientFavoriteDoctorsCollectionVC.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
    }}


