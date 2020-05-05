//
//  CustomFirstSkipPaymentView.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit


class CustomFirstSkipPaymentView: CustomBaseView {
    
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
       
       lazy var titleLabel = UILabel(text: "Information", font: .systemFont(ofSize: 30), textColor: .white)
       lazy var soonLabel = UILabel(text: "Get well soon!", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var mainBeforePaymentCollectionVC:MainBeforePaymentCollectionVC = {
       let vc = MainBeforePaymentCollectionVC()
        
        return vc
    }()
 lazy var seocndLogoImage:UIImageView = {
           let i = UIImageView(image: UIImage(named: "2663530"))
           i.contentMode = .scaleAspectFill
//    i.constrainHeight(constant: 120)
    
           return i
       }()
    lazy var discriptionLabel = UILabel(text: "When I was 5 years old, my mother always told me that happiness was the key to life. When I went to school, they asked me what I wanted to be when I grew up. I wrote down ‘happy’. They told me I didn’t understand the assignment, and I told them they didn’t understand life.", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .left, numberOfLines: 0)
    
    lazy var pageControl: UIPageControl = {
           let pc = UIPageControl()
           pc.translatesAutoresizingMaskIntoConstraints = false
           pc.currentPage = 0
           pc.numberOfPages = 5
           pc.currentPageIndicatorTintColor = #colorLiteral(red: 0.1985675395, green: 0.6542165279, blue: 0.5319386125, alpha: 1)
           pc.pageIndicatorTintColor = #colorLiteral(red: 0.8274509804, green: 0.8274509804, blue: 0.8274509804, alpha: 1)
//                   pc.addTarget(self, action: #selector(pageControlSelectionAction(_:)), for: .touchUpInside)
           return pc
       }()
    lazy var nextButton = createButtons(img: #imageLiteral(resourceName: "buttons-square-green"), tags: 0)
    lazy var backButton = createButtons(img: #imageLiteral(resourceName: "buttons-square-gray"), tags: 1)
    lazy var skipButton = UIButton(title: "Skip", titleColor: .lightGray, font: .systemFont(ofSize: 16), backgroundColor: .white, target: self, action: #selector(handleSkip))
    
    override func setupViews() {
        let ss = getStack(views: backButton,nextButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
           let bottomStack = getStack(views: skipButton,UIView(),ss, spacing: 16, distribution: .fill, axis: .horizontal)
//
//           let genderStack = getStack(views: boyButton,girlButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)
//
//           let textStack = getStack(views: fullNameTextField,addressTextField,mobileNumberTextField,emailTextField,passwordTextField,confirmPasswordTextField,genderStack,birthdayTextField,mainDrop3View, spacing: 16, distribution: .fillEqually, axis: .vertical)
           
           
//           mainDrop3View.hstack(insuracneText,doenImage).withMargins(.init(top: 0, left: 16, bottom: 0, right: 0))
           
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,mainBeforePaymentCollectionVC.view)//bottomStack,seocndLogoImage,discriptionLabel,pageControl)//,subView,textStack,insuranceCodeTextField,bottomStack,insuranceDrop,signUpButton)
           
           
//           NSLayoutConstraint.activate([
//               pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
//               seocndLogoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
//               seocndLogoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
//
//           ])
           
           LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
           backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
           titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
           soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        mainBeforePaymentCollectionVC.view.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 64, left: 32, bottom: 16, right: 32))
//        discriptionLabel.anchor(top: nil, leading: leadingAnchor, bottom: pageControl.topAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 32, bottom: 16, right: 32))
////
//        pageControl.anchor(top: nil, leading: leadingAnchor, bottom: bottomStack.topAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 32, bottom: 16, right: 32))
////
////
//           bottomStack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
           
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
