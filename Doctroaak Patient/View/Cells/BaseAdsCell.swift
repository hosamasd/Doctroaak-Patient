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
    lazy var adsTitleLabel = UILabel(text: "Center Name", font: .systemFont(ofSize: 20), textColor: .white)
    lazy var adsDiscriptionLabel = UILabel(text: "Advertising Area", font: .systemFont(ofSize: 18), textColor: #colorLiteral(red: 0.5948790312, green: 0.7596779466, blue: 0.9323453307, alpha: 1))
    
    override func layoutSubviews() {
        super.layoutSubviews()
         applyGradients(colors: [#colorLiteral(red: 0.2756898105, green: 0.5649439692, blue: 0.8560785651, alpha: 1).cgColor,#colorLiteral(red: 0.6316991448, green: 0.7736487985, blue: 0.9707484841, alpha: 1).cgColor])
    }
    
    override func setupViews() {
       layer.cornerRadius = 8
        clipsToBounds = true
        let ss = stack(adsTitleLabel,adsDiscriptionLabel).withMargins(.init(top: 0, left: 0, bottom: 16, right: 0))
        
        hstack(ss,adsLogoImage).withMargins(.init(top: 8, left: 16, bottom: 0, right: 16))
    }
}
