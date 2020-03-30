//
//  CustomRegisterView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import iOSDropDown
import UIMultiPicker

class CustomRegisterView: CustomBaseView {
    
   
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
    
    lazy var titleLabel = UILabel(text: "Welcome", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Create account", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var userProfileImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4143"))
        i.constrainWidth(constant: 100)
        i.constrainHeight(constant: 100)
        i.layer.cornerRadius = 50
        i.clipsToBounds = true
        return i
    }()
    lazy var userEditProfileImageView: UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142"))
        i.constrainWidth(constant: 28)
        i.constrainHeight(constant: 28)
        i.layer.cornerRadius = 8
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.isUserInteractionEnabled = true
        return i
    }()
    
    lazy var fullNameTextField = createMainTextFields(place: " Name")
    lazy var mobileNumberTextField = createMainTextFields(place: " phone",type: .numberPad)
    lazy var emailTextField = createMainTextFields(place: "enter email",type: .emailAddress)
    lazy var passwordTextField:UITextField = {
        let s = createMainTextFields(place: "Password", type: .default,secre: true)
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "visiblity"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(s.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(handleASD), for: .touchUpInside)
        s.rightView = button
        s.rightViewMode = .always
        return s
    }()
    lazy var confirmPasswordTextField:UITextField = {
        let s = createMainTextFields(place: "confirm Password", type: .default,secre: true)
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "visiblity"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(s.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(handleASDs), for: .touchUpInside)
        s.rightView = button
        s.rightViewMode = .always
        return s
    }()
    lazy var boyButton:UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Male", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.clipsToBounds = true
        button.leftImage(image: #imageLiteral(resourceName: "toilet"), renderMode: .alwaysOriginal)
        return button
    }()
    lazy var girlButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Female", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.clipsToBounds = true
        button.leftImage(image: #imageLiteral(resourceName: "toile11t"), renderMode: .alwaysOriginal)
        return button
    }()
    lazy var birthdayTextField:UITextField = {
        let t = UITextField()

        t.layer.cornerRadius = 8
        t.clipsToBounds = true
        t.placeholder = "   Birthday"
        t.textAlignment = .center
        t.layer.borderWidth = 1
        t.layer.borderColor = UIColor.lightGray.cgColor
        return t
    }()
    lazy var addressTextField = createMainTextFields(place: "Address")
    
    lazy var mainDrop3View:UIView = {
        let l = UIView(backgroundColor: .white)
        l.layer.cornerRadius = 8
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
        l.constrainHeight(constant: 50)
        return l
    }()
    lazy var doenImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142-6"))
        i.constrainWidth(constant: 50)
        i.constrainHeight(constant: 50)
        return i
    }()
    lazy var insuracneText = UILabel(text: "choose insurance", font: .systemFont(ofSize: 18), textColor: .black, textAlignment: .left)
    lazy var insuranceDrop:UIMultiPicker = {
        let v = UIMultiPicker(backgroundColor: .white)
//        v.options = insuracneArray
        v.color = .gray
        v.tintColor = .green
        v.font = .systemFont(ofSize: 30, weight: .bold)
        v.highlight(2, animated: true) // centering "Bitter"
        v.constrainHeight(constant: 150)
        v.isHide(true)
//        v.addTarget(self, action: #selector(handleHidePicker), for: .valueChanged)
        return v
    }()
    lazy var insuranceCodeTextField = createMainTextFields(place: "Insurance code")
    
    lazy var acceptButton:UIButton = {
        let b = UIButton()
        b.setImage(#imageLiteral(resourceName: "Rectangle 1712"), for: .normal)
        b.setImage(#imageLiteral(resourceName: "DropDown_Checked"), for: .selected)
//        b.addTarget(self, action: #selector(handleAgree), for: .touchUpInside)
        return b
    }()
    
    lazy var acceptLabel = UILabel(text: " Accept ".localized, font: .systemFont(ofSize: 16), textColor: .black)
    lazy var createAccountButton:UIButton = {
        let b = UIButton()
        b.setTitle("Terms and Conditions".localized, for: .normal)
        b.setTitleColor(#colorLiteral(red: 0.5999417901, green: 0.821531117, blue: 0.8872718215, alpha: 1), for: .normal)
        b.underline()
        b.constrainHeight(constant: 50)
        return b
    }()
    lazy var signUpButton:UIButton = {
        let button = UIButton()
        button.setTitle("SignUp", for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
//    var insuracneArray = ["one","two","three","sdfdsfsd"]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if boyButton.backgroundColor == nil  {
            addGradientInSenderAndRemoveOther(sender: boyButton)
        }
//            let leftColor = #colorLiteral(red: 0.4747212529, green: 0.2048208416, blue: 1, alpha: 1)
//            let rightColor = #colorLiteral(red: 0.7187242508, green: 0.5294578671, blue: 0.9901599288, alpha: 1)
//            boyButton.applyGradient(colors: [leftColor.cgColor, rightColor.cgColor], index: 0)
        
      
    }
    
    override func setupViews() {
        let subView = UIView(backgroundColor: .clear)
        subView.addSubViews(views: userProfileImage,userEditProfileImageView)
        subView.constrainWidth(constant: 100)
        subView.constrainHeight(constant: 100)
        userEditProfileImageView.anchor(top: nil, leading: nil, bottom: userProfileImage.bottomAnchor, trailing: userProfileImage.trailingAnchor,padding: .init(top: 0, left:0 , bottom:10, right: 10))
        let bottomStack = getStack(views: UIView(),acceptButton,acceptLabel,createAccountButton,UIView(), spacing: 0, distribution: .fillProportionally, axis: .horizontal)

        let genderStack = getStack(views: boyButton,girlButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)

        let textStack = getStack(views: fullNameTextField,addressTextField,mobileNumberTextField,emailTextField,passwordTextField,confirmPasswordTextField,genderStack,birthdayTextField,insuranceCodeTextField,mainDrop3View, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
        mainDrop3View.addSubViews(views: doenImage,insuracneText)
        mainDrop3View.hstack(insuracneText,doenImage).withMargins(.init(top: 0, left: 16, bottom: 0, right: 0))
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,subView,textStack,bottomStack,insuranceDrop,signUpButton)
        
        NSLayoutConstraint.activate([
            bottomStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            userProfileImage.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        subView.anchor(top: LogoImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 50, left: 0, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        textStack.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
        //        genderStack.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
        insuranceDrop.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        
        bottomStack.anchor(top: textStack.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        
        signUpButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
        
    }
    
    @objc func handleASD()  {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc func handleASDs()  {
        confirmPasswordTextField.isSecureTextEntry = !confirmPasswordTextField.isSecureTextEntry
    }
}


