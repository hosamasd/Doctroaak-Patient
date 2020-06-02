//
//  CustomDetailsView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import SDWebImage
import MOLH

class CustomDetailsView: CustomBaseView {
    
    var selectedDoctor:PatientSearchDoctorsModel? {
        didSet{
            guard let selectedDoctor = selectedDoctor else { return  }

            patientFavoriteDoctorsCell.doctor=selectedDoctor
            doctorSuggestShiftHorizentalVC.suggestedDaysArray = selectedDoctor.freeDays
            doctorWorkingDateCollectionVC.workingDaysArray = selectedDoctor.workingHours
            DispatchQueue.main.async {
                self.doctorSuggestShiftHorizentalVC.collectionView.reloadData()
                self.doctorWorkingDateCollectionVC.collectionView.reloadData()
            }
        }
    }
    
//    var patient:PatienModel?{
//                     didSet{
//                         guard let patient = patient else { return  }
////                         .patient=patient
//                     }
//                 }
    
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
    lazy var titleLabel = UILabel(text: "Details", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var suggestedLabel = UILabel(text: "Doctor free suggested days", font: .systemFont(ofSize: 18), textColor: .gray)
    lazy var workingDateLabel = UILabel(text: "Doctor's working date", font: .systemFont(ofSize: 18), textColor: .gray)
    lazy var mainSecondView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var patientFavoriteDoctorsCell:PatientFavoriteDoctorsCell = {
        let v = PatientFavoriteDoctorsCell()
        
        return v
    }()
    lazy var doctorSuggestShiftHorizentalVC:DoctorSuggestShiftHorizentalVC = {
        let v = DoctorSuggestShiftHorizentalVC()
        v.view.constrainHeight(constant: 180)
        return v
    }()
    lazy var doctorWorkingDateCollectionVC:DoctorWorkingDateCollectionVC  = {
        let v = DoctorWorkingDateCollectionVC()
        v.view.constrainHeight(constant: 200)
        return v
    }()
    lazy var bookButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        return button
    }()
    
//    var patient_id:Int?
//       var patientApiToken:String?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradientInSenderAndRemoveOther(sender: bookButton)
        bookButton.setTitleColor(.white, for: .normal)
    }
    
    
    
    override func setupViews()  {
        
        addSubViews(views: LogoImage,backImage,titleLabel,patientFavoriteDoctorsCell,suggestedLabel,workingDateLabel,doctorSuggestShiftHorizentalVC.view,doctorWorkingDateCollectionVC.view,bookButton)
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        patientFavoriteDoctorsCell.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        suggestedLabel.anchor(top: patientFavoriteDoctorsCell.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        
        doctorSuggestShiftHorizentalVC.view.anchor(top: suggestedLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        workingDateLabel.anchor(top: doctorSuggestShiftHorizentalVC.view.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        doctorWorkingDateCollectionVC.view.anchor(top: workingDateLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        bookButton.anchor(top: doctorWorkingDateCollectionVC.view.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 16, bottom: 16, right: 16))
        
        
    }
    
    func createButtons(image:UIImage) -> UIButton {
        let b = UIButton()
        b.setImage(image, for: .normal)
        return b
    }
}
