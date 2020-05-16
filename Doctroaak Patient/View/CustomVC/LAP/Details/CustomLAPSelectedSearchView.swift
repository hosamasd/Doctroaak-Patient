//
//  CustomLAPOrderView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SDWebImage
import MOLH


class CustomLAPSelectedSearchView: CustomBaseView {
    
    var index:Int!{
        didSet{
            titleLabel.text = index == 1 ? "Rediology" : "Lap"
            doctorWorkingDataLabel.text = index == 0 ? "Lab  working hours" : "Rediology  working hours"
        }
    }
    var lab:LapSearchModel? {
        didSet{
            guard let lab = lab else { return  }
            lapDoctorWorkingDataCollectionVC.labWorkingDaysArray =  lab.workingHours
            lapDoctorWorkingDataCollectionVC.collectionView.reloadData()
             DispatchQueue.main.async {
                self.lapResultsCelllll.lab =  self.lab
            }
        }
    }
    
    var rad:RadiologySearchModel? {
           didSet{
            guard let rad = rad else { return  }

               lapDoctorWorkingDataCollectionVC.radWorkingDaysArray = rad.workingHours
            lapDoctorWorkingDataCollectionVC.collectionView.reloadData()

                DispatchQueue.main.async {
                    self.lapResultsCelllll.rad = self.rad
               }
           }
       }
    
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
    lazy var titleLabel = UILabel(text: "Lap", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Get well soon!", font: .systemFont(ofSize: 18), textColor: .white)
    lazy var mainSecondView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var lapResultsCelllll:LAPResultsCelllll = {
       let v = LAPResultsCelllll()
        v.locationImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLocation)))
//        v.handleGetLocation = {[unowned self] (la,ln) in
//            self.handleGetLocation?(la,ln)
//    }
        return v
    }()
    
    lazy var doctorWorkingDataLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var lapDoctorWorkingDataCollectionVC:DoctorWorkingDateCollectionVC = {
        let vc = DoctorWorkingDateCollectionVC()
//        vc.view.constrainHeight(constant: 300)
        return vc
    }()
    lazy var bookButton:UIButton = {
        let button = UIButton()
        button.setTitle("Book", for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        return button
    }()
    
    var handleGetLocation:((Double,Double) ->Void)?

//    var labArrayResults: LapSearchModel?
//    var radiologyArrayResults :RadiologySearchModel?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bookButton.backgroundColor != nil {
            addGradientInSenderAndRemoveOther(sender: bookButton)
            bookButton.setTitleColor(.white, for: .normal)
        }
    }
    
    override func setupViews() {
        lapResultsCelllll.constrainHeight(constant: 150)
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,lapResultsCelllll,lapDoctorWorkingDataCollectionVC.view,doctorWorkingDataLabel,bookButton)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        
        lapResultsCelllll.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 46, bottom: 0, right: 32))
        doctorWorkingDataLabel.anchor(top: lapResultsCelllll.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        //        doctorWorkingDataLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
        lapDoctorWorkingDataCollectionVC.view.anchor(top: doctorWorkingDataLabel.bottomAnchor, leading: leadingAnchor, bottom: bookButton.topAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
        bookButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 64, left: 32, bottom: 16, right: 32))
    }
    
    @objc func handleLocation()  {
//        guard let lat = lab?.latt.toDouble(),let lng=lab?.lang.toDouble() else {  handleGetLocation?(lat,lng); return }
        var lat:Double = 0.0
        var lng:Double = 0.0
           if rad != nil {
            guard let lat = rad?.latt.toDouble(),let lng=rad?.lang.toDouble() else {  handleGetLocation?(0.0,0.0); return }
            handleGetLocation?(lat,lng);return
//            lat = rad?.latt.toDouble() ?? 0.0
//               lng=rad.lang.toDouble() ?? 0.0
           }else if lab != nil {
            guard let lat = lab?.latt.toDouble(),let lng=lab?.lang.toDouble() else {  handleGetLocation?(0.0,0.0); return }
            handleGetLocation?(lat,lng);return
//               lat = lab.latt.toDouble() ?? 0.0
//               lng=lab.lang.toDouble() ?? 0.0
           }else {
               lat = 0.0
               lng = 0.0
           }
           
           handleGetLocation?(lat,lng)
       }
}
