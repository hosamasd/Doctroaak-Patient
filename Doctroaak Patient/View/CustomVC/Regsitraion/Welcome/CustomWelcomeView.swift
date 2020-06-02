//
//  CustomWelcomeView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class CustomWelcomeView: CustomBaseView {
    
    lazy var mainImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "iPhone X-XS – 28"))
        return i
    }()
    lazy var drImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 3795"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 80)
        return i
    }()
    lazy var copyWriteLabel = UILabel(text: "Copyright @".localized, font: .systemFont(ofSize: 20), textColor: .white,textAlignment: .center)
    lazy var docotrLabel = UILabel(text: "Doctoraak ".localized, font: .systemFont(ofSize: 20), textColor: .white,textAlignment: .center)
    
    
    override func setupViews() {
        addSubViews(views: mainImage,drImage,docotrLabel,copyWriteLabel)
        
        mainImage.fillSuperview()
        drImage.centerInSuperview()
        docotrLabel.anchor(top: drImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 16, right: 0))
        
        copyWriteLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 16, right: 0))
        
    }
}
