//
//  ICUResultsCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ICUResultsCell: BaseCollectionCell {
    
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
        attributeText.append(NSAttributedString(string: "Mokattam, Giza \n\n", attributes: [.font : UIFont.systemFont(ofSize: 16),.foregroundColor: UIColor.gray]))
        l.attributedText = attributeText
        l.numberOfLines = 2
        return l
    }()
    lazy var profileInfoAddressLabel = UILabel(text: "Fifth Settlement, New Cairo", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var profileInfoReservationLabel = UILabel(text: "Reservation : 200.0 EGP", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var profileInfoConsultaionLabel = UILabel(text: "Consultation : 50.0 EGP", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var profileInfoTelephoneLabel = UILabel(text: "0109-552-5115", font: .systemFont(ofSize: 16), textColor: .black)

    lazy var profileInfoAddressButton = createImagess(image: #imageLiteral(resourceName: "ic_room_24px"))
    lazy var profileInfoReservationButton = createImagess(image: #imageLiteral(resourceName: "ic_date_range_24px"))
    lazy var profileInfoConsultaionButton = createImagess(image: #imageLiteral(resourceName: "avatar"))
     lazy var profileInfoTelephoneButton = createImagess(image: #imageLiteral(resourceName: "smartphone (2)"))
    
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
        let b = hstack(profileInfoTelephoneButton,profileInfoTelephoneLabel,spacing:8)
        return b
    }()
    //
    lazy var totalStackFinished:UIStackView = {
        let b = stack(firstStack,secondStack,thirdStack,forthStack,spacing:8)
        return b
    }()
    

    
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
        //        dropShadow(color: .red, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        //        setupShadow(opacity: 0.2, radius: 16, offset: .init(width: 0, height: 50), color: .red)
        setupViewss()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewss() {
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
        
        //        setupShadow(opacity: 0.8, radius: 10, offset: .init(width: 0, height: 10), color: .red)
        //        addSubview(totalStackFinished)
        //        totalStackFinished.fillSuperview()
        let ss = stack(profileImage,UIView())
        let dd = stack(profileInfoLabel,totalStackFinished).withMargins(.init(top: -16, left: 0, bottom: 0, right: 0))
        
        hstack(ss,dd,spacing:16).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
//        stack(total,seperatorView,bottom,spacing:8).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
        
        
    }
    
    func createImagess(image:UIImage) -> UIImageView {
        let b = UIImageView(image: image)
        //        b.setImage(image, for: .normal)
        b.constrainWidth(constant: 20)
        b.constrainHeight(constant: 20)
        return b
    }
    
}
