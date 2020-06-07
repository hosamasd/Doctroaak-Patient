//
//  CustomFirstSkipPaymentView.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH

class CustomFirstSkipPaymentView: CustomBaseView {
    
    lazy var LogoImage:UIImageView = {
           let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
           i.contentMode = .scaleAspectFill
           return i
       }()
       lazy var backImage:UIImageView = {
           let i = UIImageView(image: MOLHLanguage.isRTLLanguage() ? #imageLiteral(resourceName: "left-arrow") : #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
           i.constrainWidth(constant: 30)
           i.constrainHeight(constant: 30)
           i.isUserInteractionEnabled = true
           return i
       }()
       
    lazy var titleLabel = UILabel(text: "Information".localized, font: .systemFont(ofSize: 30), textColor: .white,textAlignment: MOLHLanguage.isRTLLanguage() ? .right : .left)
    lazy var soonLabel = UILabel(text: "Get well soon!".localized, font: .systemFont(ofSize: 18), textColor: .white,textAlignment: MOLHLanguage.isRTLLanguage() ? .right : .left)
    
    lazy var mainBeforePaymentCollectionVC:MainBeforePaymentCollectionVC = {
       let vc = MainBeforePaymentCollectionVC()
        vc.handlePaymentAction = {[unowned self] in
            self.handlePaymentAction?()
        }
        return vc
    }()
    
    var handlePaymentAction:(()->Void)?
    
    
    override func setupViews() {
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,mainBeforePaymentCollectionVC.view)//bottomStack,seocndLogoImage,discriptionLabel,pageControl)//,subView,textStack,insuranceCodeTextField,bottomStack,insuranceDrop,signUpButton)
        
        if MOLHLanguage.isRTLLanguage() {
                   LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
               }else {
                   
                   LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
              }
        
//           LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
           backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
           titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
           soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        mainBeforePaymentCollectionVC.view.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 64, left: 32, bottom: 16, right: 32))
        
    }
    
    func createButtons(img:UIImage,tags:Int) -> UIImageView {
        let bt = UIImageView(image: img)
        bt.constrainWidth(constant: 60)
        bt.constrainHeight(constant: 60)
        bt.tag = tags
        return bt
    }
    
    
   @objc func handleSkip()  {
        print(0123)
    }
    
}
