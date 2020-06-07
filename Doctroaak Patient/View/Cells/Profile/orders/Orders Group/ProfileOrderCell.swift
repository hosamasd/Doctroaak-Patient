//
//  ProfileOrderCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH
import SVProgressHUD

class ProfileOrderCell: BaseCollectionCell {
    
    var doctor:DoctorsOrderPatientModel? {
        didSet{
            guard let doctor = doctor else { return  }
            profileOrderDatesLabel.text = doctor.createdAt
            let name = MOLHLanguage.isRTLLanguage() ? doctor.clinic.doctor.nameAr ??  doctor.clinic.doctor.name : doctor.clinic.doctor.name
            let checks = getCityFromIndex(doctor.type.toInt())
            let waits = doctor.clinic.waitingTime
            let reserve = doctor.clinic.fees
            let consultaion = doctor.clinic.fees2
            
            putAttributedText(la: profileInfoLabel, ft: "\(name)\n", st: "\(checks)")
            
            profileInfoReservationNumberLabel.text = "reservation number".localized + " : \(doctor.reservationNumber)"
            profileInfoWaitingTimeLabel.text = "waiting time".localized + " : \(waits) mintues"
            profileInfoReservationLabel.text = "Reservation".localized + " :"+reserve
            profileInfoConsultaionLabel.text = "Consultation".localized + " :"+consultaion
            
            
            
            
            let urlString = doctor.clinic.doctor.photo
            guard let url = URL(string: urlString), let datees = doctor.createdAt.toDates() else { return  }
            
            profileImage.sd_setImage(with: url)
            
            let title = Calendar.current.isDateInYesterday(datees) ? "Rate Order".localized : "Cancel Order".localized
            cancelButton.setTitle(title, for: .normal)
            
        }
    }
    
    
    lazy var profileImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)
        i.constrainWidth(constant: 60)
        i.constrainHeight(constant: 60)
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        return i
    }()
    lazy var profileInfoLabel:UILabel = {
        let l = UILabel()
        
        l.numberOfLines = 2
        return l
    }()
    lazy var profileOrderDatesLabel = UILabel(text: "22/4/2020  2:30 pm", font: .systemFont(ofSize: 16), textColor: .lightGray)
    lazy var profileOrderLocationImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4182"))
        i.constrainWidth(constant: 20)
        i.constrainHeight(constant: 20)
        return i
    }()
    lazy var profileInfoReservationNumberLabel = UILabel(text: "reservation number: 2", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var profileInfoWaitingTimeLabel = UILabel(text: "waiting time : 30 mintues", font: .systemFont(ofSize: 16), textColor: .black)
    
    lazy var profileInfoAddressLabel = UILabel(text: "Fifth Settlement, New Cairo", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var profileInfoReservationLabel = UILabel(text: "Reservation : 200.0 EGP", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var profileInfoConsultaionLabel = UILabel(text: "Consultation : 50.0 EGP", font: .systemFont(ofSize: 16), textColor: .black)
    
    lazy var profileInfoReservationNumberButton = createImagess(image: #imageLiteral(resourceName: "ic_date_range_24px"))
    lazy var profileInfoWaitingTimeButton = createImagess(image: #imageLiteral(resourceName: "available"))
    lazy var profileInfoAddressButton = createImagess(image: #imageLiteral(resourceName: "ic_room_24px"))
    lazy var profileInfoReservationButton = createImagess(image: #imageLiteral(resourceName: "ic_date_range_24px"))
    lazy var profileInfoConsultaionButton = createImagess(image: #imageLiteral(resourceName: "avatar"))
    
    lazy var firstStack:UIStackView = {
        let b =  hstack(profileInfoAddressButton,profileInfoAddressLabel,spacing:8)
        return b
    }()
    lazy var secondStack:UIStackView = {
        let b = hstack(profileInfoReservationButton,profileInfoReservationLabel,spacing:8)
        return b
    }()
    lazy var thirdStack:UIStackView = {
        let b = hstack(profileInfoConsultaionButton,profileInfoConsultaionLabel,spacing:8)
        return b
    }()
    lazy var forthStack:UIStackView = {
        let b = hstack(profileInfoReservationNumberButton,profileInfoReservationNumberLabel,spacing:8)
        return b
    }()
    lazy var fifthStack:UIStackView = {
        let b = hstack(profileInfoWaitingTimeButton,profileInfoWaitingTimeLabel,spacing:8)
        return b
    }()
    //
    lazy var totalStackFinished:UIStackView = {
        let b = stack(forthStack,fifthStack,firstStack,secondStack,thirdStack,spacing:8)
        return b
    }()
    
    lazy var seperatorView:UIView = {
        let v = UIView(backgroundColor: .lightGray)
        v.constrainHeight(constant: 1)
        return v
    }()
    lazy var cancelButton:UIButton = {
        let b = UIButton()
        b.setTitle("Cancel Order".localized, for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.backgroundColor = .white
        b.constrainHeight(constant: 50)
        b.layer.cornerRadius = 8
        b.clipsToBounds = true
        b.addTarget(self, action: #selector(handleCacnel), for: .touchUpInside)
        return b
    }()
    
    var handleCheckedIndex:((DoctorsOrderPatientModel)->Void)?
    var handleRateIndex:((DoctorsOrderPatientModel)->Void)?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if cancelButton.backgroundColor != nil {
            addGradientInSenderAndRemoveOther(sender: cancelButton)
            cancelButton.setTitleColor(.white, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        layer.masksToBounds = false
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 20)
        layer.shadowRadius = 20
        layer.opacity = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1//(except for this nothing else is woking)
        setupViewss()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewss() {
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
        let ss = stack(profileImage,UIView())
        let dd = stack(profileInfoLabel,totalStackFinished).withMargins(.init(top: -16, left: 0, bottom: 0, right: 0))
        
        let tob = hstack(profileOrderDatesLabel,profileOrderLocationImage)
        let total = hstack(ss,dd,spacing:16)
        stack(tob,seperatorView,total,cancelButton,spacing:8).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
        
        
    }
    
    func createImagess(image:UIImage) -> UIImageView {
        let b = UIImageView(image: image)
        b.constrainWidth(constant: 20)
        b.constrainHeight(constant: 20)
        return b
    }
    
    func putAttributedText(la:UILabel,ft:String,st:String)  {
        let attributeText = NSMutableAttributedString(string: ft, attributes:  [.font : UIFont.boldSystemFont(ofSize: 18)])
        attributeText.append(NSAttributedString(string: st, attributes: [.font : UIFont.systemFont(ofSize: 14),.foregroundColor: UIColor.lightGray]))
        la.attributedText = attributeText
    }
    
    func getCityFromIndex(_ index:Int?) -> String {
        guard let index = index else { return "Reservation" }
        return index ==  1 ? "Reservation".localized  : index == 2 ?  "Consultaion".localized : "Continue".localized
    }
    
    @objc   func handleCacnel(sender:UIButton)  {
        guard let doctor = doctor else { return  }
        if sender.titleLabel?.text == "Rate Order"  {
            handleRateIndex?(doctor)
        }else {
            handleCheckedIndex?(doctor)
        }
    }
}
