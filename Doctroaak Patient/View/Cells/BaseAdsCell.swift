//
//  BaseAdsCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class BaseAdsCell:  BaseCollectionCell{
    
    lazy var adsLogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 3786"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 40)
        return i
    }()
    lazy var adsTitleLabel = UILabel(text: "Subscribe now to the \n200 EGP offer", font: .systemFont(ofSize: 16), textColor: .white,textAlignment: .left,numberOfLines: 2)
    
    lazy var paymentButton:UIButton = {
       let b = UIButton(title: "    Payment  ", titleColor: .white, font: .systemFont(ofSize: 16), backgroundColor: #colorLiteral(red: 0.4781062007, green: 0.2103165984, blue: 1, alpha: 1), target: self, action: #selector(handlePay))
        b.layer.cornerRadius = 8
        b.clipsToBounds = true
        b.constrainWidth(constant: 120)
        return b
    }()
    lazy var detailButton = UIButton(title: "Details", titleColor: .white, font: .systemFont(ofSize: 16), backgroundColor: .clear, target: self, action: #selector(handleDeta))

    
    var handlePayments:(()->Void)?
    var handleDetails:(()->Void)?

    
    override func layoutSubviews() {
        super.layoutSubviews()
         applyGradients(colors: [#colorLiteral(red: 0.2756898105, green: 0.5649439692, blue: 0.8560785651, alpha: 1).cgColor,#colorLiteral(red: 0.6316991448, green: 0.7736487985, blue: 0.9707484841, alpha: 1).cgColor])
    }
    
    override func setupViews() {
       layer.cornerRadius = 8
        clipsToBounds = true
        let sss = hstack(UIView(),detailButton,paymentButton,spacing: 16)
        
        stack(adsTitleLabel,sss).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
        
    }
    
   @objc func handlePay()  {
        handlePayments?()
    }
    
   @objc func handleDeta()  {
        handleDetails?()
    }
}
