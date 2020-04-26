//
//  CustomVerificationView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class CustomVerificationView: CustomBaseView {
    
    
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
    
    lazy var titleLabel = UILabel(text: "Verification", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Check your mobile for verification Code", font: .systemFont(ofSize: 18), textColor: .white)
    lazy var verificationLabel = UILabel(text: "Please, enter the verification code \n we send to your mobile ", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center, numberOfLines: 2)
    lazy var timerLabel = UILabel(text: "00:30", font: .systemFont(ofSize: 18), textColor: #colorLiteral(red: 0.2387362421, green: 0.8891445994, blue: 0.7412704825, alpha: 1),textAlignment: .center)
    
    lazy var resendButton = UIButton(title: "Resend again ", titleColor: #colorLiteral(red: 0.8645762801, green: 0.8727034926, blue: 0.9021102786, alpha: 1), font: .systemFont(ofSize: 16), backgroundColor: .clear, target: self, action: #selector(handleASD))
    lazy var firstNumberTextField = createMainTextFieldsWithoutPods(place: "")
    lazy var secondNumberTextField = createMainTextFieldsWithoutPods(place: "")
    lazy var thirdNumberTextField = createMainTextFieldsWithoutPods(place: "")
    lazy var forthNumberTextField = createMainTextFieldsWithoutPods(place: "")
    
    lazy var confirmButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    let sMSCodeViewModel = SMSCodeViewModel()
    
    
    override func setupViews() {
        resendButton.isEnabled = false
        let numbersStack = getStack(views: UIView(),firstNumberTextField,secondNumberTextField,thirdNumberTextField,forthNumberTextField,UIView(), spacing: 8, distribution: .fillEqually, axis: .horizontal)
        //        let mainStack = getStack(views: verificationLabel, spacing: <#T##CGFloat#>, distribution: <#T##UIStackView.Distribution#>, axis: <#T##NSLayoutConstraint.Axis#>)
        
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,verificationLabel,timerLabel,resendButton,numbersStack,confirmButton)
        
        NSLayoutConstraint.activate([
            verificationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            verificationLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        verificationLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: nil)
        timerLabel.anchor(top: verificationLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        resendButton.anchor(top: timerLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        numbersStack.anchor(top: resendButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 48, bottom: 0, right: 48))
        
        
        
        
        
        confirmButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
        
    }
    
    
    @objc func handleASD()  {
        print(956)
    }
}
