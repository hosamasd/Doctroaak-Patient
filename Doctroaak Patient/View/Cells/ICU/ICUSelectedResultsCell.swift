//
//  ICUSelectedResultsCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
class ICUSelectedResultsCell: BaseCollectionCell {
    
     lazy var profileImage:UIImageView = {
            let i = UIImageView(backgroundColor: .gray)
            i.constrainWidth(constant: 60)
            i.constrainHeight(constant: 60)
            i.layer.cornerRadius = 8
            i.clipsToBounds = true
            return i
        }()
    lazy var profileInfoNameLabel = UILabel(text: "Dr. Hagar Mohamed", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var profileInfoDescriptionLabel = UILabel(text: "Description", font: .systemFont(ofSize: 16), textColor: .gray,textAlignment: .left,numberOfLines: 0)

      
    lazy var starsStackView:UIStackView = {
           var arrangedViews = [ UIView]()
           (0..<5).forEach({ (_) in
               let im = UIImageView(image: #imageLiteral(resourceName: "star"))
               im.constrainWidth(constant: 16)
               im.constrainHeight(constant: 24)
               arrangedViews.append(im)
           })
           arrangedViews.append(UIView())
           let stack = UIStackView(arrangedSubviews: arrangedViews)
           return stack
       }()
    lazy var profileInfoAvilabiltyLabel = UILabel(text: "Avilabilty seats".localized + " :  12", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var profileInfoCityLabel = UILabel(text: "City ".localized + " : Cairo", font: .systemFont(ofSize: 16), textColor: .black)
        lazy var profileInfoAreaLabel = UILabel(text: "Area : Eltahrer", font: .systemFont(ofSize: 16), textColor: .black)

        lazy var profileInfoAddressButton = createImagess(image: #imageLiteral(resourceName: "ic_room_24px"))
        lazy var profileInfoReservationButton = createImagess(image: #imageLiteral(resourceName: "ic_date_range_24px"))
        lazy var profileInfoConsultaionButton = createImagess(image: #imageLiteral(resourceName: "avatar"))
        
        lazy var firstStack:UIStackView = {
            let b =  hstack(profileInfoAddressButton,profileInfoAvilabiltyLabel,spacing:8)
            return b
        }()
        lazy var secondStack:UIStackView = {
            let b = hstack(profileInfoReservationButton,profileInfoCityLabel,spacing:8)
            return b
        }()
        lazy var thirdStack:UIStackView = {
            let b = hstack(profileInfoConsultaionButton,profileInfoAreaLabel,spacing:8)
            return b
        }()
      
        lazy var totalStackFinished:UIStackView = {
            let b = stack(firstStack,secondStack,thirdStack,spacing:8)
            return b
        }()
        

    override func layoutSubviews() {
        super.layoutSubviews()
//        setupShadow(opacity: 1, radius: 20, offset: CGSize(width: 0, height: 20), color:  UIColor.red)
        self.layer.cornerRadius = 10
           self.layer.borderWidth = 1.0
           self.layer.borderColor = UIColor.lightGray.cgColor

           self.layer.backgroundColor = UIColor.white.cgColor
           self.layer.shadowColor = UIColor.gray.cgColor
           self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
           self.layer.shadowRadius = 2.0
           self.layer.shadowOpacity = 1.0
           self.layer.masksToBounds = false
    }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViewss()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupViewss() {
            backgroundColor = .white
            layer.cornerRadius = 8
            clipsToBounds = true
            let dddd = hstack(profileInfoNameLabel,starsStackView,spacing:8).padTop(16)
            
            let ss = stack(profileImage,UIView())
            let dd = stack(dddd,profileInfoDescriptionLabel,totalStackFinished,spacing:16).withMargins(.init(top: -16, left: 0, bottom: 0, right: 0))
            
            hstack(ss,dd,spacing:16).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
            
            
        }
        
        func createImagess(image:UIImage) -> UIImageView {
            let b = UIImageView(image: image)
            //        b.setImage(image, for: .normal)
            b.constrainWidth(constant: 20)
            b.constrainHeight(constant: 20)
            return b
        }
}
