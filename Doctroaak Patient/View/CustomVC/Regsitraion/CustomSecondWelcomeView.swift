//
//  CustomSecondWelcomeView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class CustomSecondWelcomeView: CustomBaseView {
    
    lazy var mainImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "iPhone X-XS – 28"))
        return i
    }()
    lazy var drImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "2367415"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var loginButton = createButtons(texzt: "LOGIN")
    lazy var registerButton = createButtons(texzt: "SIGN UP")
    
    override func setupViews() {
        let ss = getStack(views: loginButton,registerButton, spacing: 8, distribution: .fillEqually, axis: .vertical)
        
        addSubViews(views: mainImage,drImage,ss)
        
        mainImage.fillSuperview()
        drImage.centerInSuperview()
        ss.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 16, bottom: 48, right: 16))
        
    }
    
    func createButtons(texzt:String) -> UIButton {
        let b = UIButton()
        b.setTitle(texzt, for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.backgroundColor = .white
        b.constrainHeight(constant: 50)
        b.layer.cornerRadius = 8
        b.clipsToBounds = true
        return b
    }
    
}
