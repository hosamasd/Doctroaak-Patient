//
//  ProfileOrderCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH
class ProfileOrderCell: BaseCollectionCell {
    
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
        let attributeText = NSMutableAttributedString(string: "Dr. Hagar Mohamed \n", attributes:  [.font : UIFont.boldSystemFont(ofSize: 18)])
        attributeText.append(NSAttributedString(string: "Degree brief here \n\n", attributes: [.font : UIFont.systemFont(ofSize: 14),.foregroundColor: UIColor.lightGray]))
        l.attributedText = attributeText
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
    lazy var profileInfoAddressLabel = UILabel(text: "Fifth Settlement, New Cairo", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var profileInfoReservationLabel = UILabel(text: "Reservation : 200.0 EGP", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var profileInfoConsultaionLabel = UILabel(text: "Consultation : 50.0 EGP", font: .systemFont(ofSize: 16), textColor: .black)
    
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
    //
    lazy var totalStackFinished:UIStackView = {
        let b = stack(firstStack,secondStack,thirdStack,spacing:8)
        return b
    }()
    
    lazy var seperatorView:UIView = {
        let v = UIView(backgroundColor: .lightGray)
        v.constrainHeight(constant: 1)
        return v
    }()
    lazy var cancelButton:UIButton = {
        let b = UIButton()
        b.setTitle("Cancel order", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.backgroundColor = .white
        b.constrainHeight(constant: 50)
        b.layer.cornerRadius = 8
        b.clipsToBounds = true
        return b
    }()
    
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
}
