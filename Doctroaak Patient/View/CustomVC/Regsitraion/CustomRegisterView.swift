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
import SkyFloatingLabelTextField

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
    
    lazy var mainDrop3View = makeMainSubViewWithAppendView(vv: [doenImage,insuracneText])
    lazy var doenImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142-6"))
        i.constrainWidth(constant: 50)
//        i.constrainHeight(constant: 50)
        return i
    }()
    lazy var insuracneText = UILabel(text: "choose insurance", font: .systemFont(ofSize: 18), textColor: .black, textAlignment: .left)
    lazy var insuranceDrop:UIMultiPicker = {
        let v = UIMultiPicker(backgroundColor: .white)
        v.options = insuracneArray
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
    
    let registerViewModel = RegisterViewModel()
    var iiii = ""
    var de = ""
    var insuracneArray = ["one","two","three","sdfdsfsd"]
    //    var insuracneArray = ["one","two","three","sdfdsfsd"]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if boyButton.backgroundColor == nil  {
            addGradientInSenderAndRemoveOther(sender: boyButton)
        }
        
    }
    
    fileprivate func addViewsTargets() {
        insuranceCodeTextField.constrainHeight(constant: 60)
        [  mobileNumberTextField,passwordTextField, emailTextField, fullNameTextField, confirmPasswordTextField, addressTextField,insuranceCodeTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)})
        boyButton.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
        girlButton.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
        insuranceDrop.addTarget(self, action: #selector(handleHidePicker), for: .valueChanged)
        birthdayTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
        mainDrop3View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenCloseInsurance)))
        acceptButton.addTarget(self, action: #selector(handleAgree), for: .touchUpInside)
    }
    
    override func setupViews() {
        addViewsTargets()
        
        let subView = UIView(backgroundColor: .clear)
        subView.addSubViews(views: userProfileImage,userEditProfileImageView)
        subView.constrainWidth(constant: 100)
        subView.constrainHeight(constant: 100)
        userEditProfileImageView.anchor(top: nil, leading: nil, bottom: userProfileImage.bottomAnchor, trailing: userProfileImage.trailingAnchor,padding: .init(top: 0, left:0 , bottom:10, right: 10))
        let bottomStack = getStack(views: UIView(),acceptButton,acceptLabel,createAccountButton,UIView(), spacing: 0, distribution: .fillProportionally, axis: .horizontal)
        
        let genderStack = getStack(views: boyButton,girlButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let textStack = getStack(views: fullNameTextField,addressTextField,mobileNumberTextField,emailTextField,passwordTextField,confirmPasswordTextField,genderStack,birthdayTextField,mainDrop3View, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
        
        mainDrop3View.hstack(insuracneText,doenImage).withMargins(.init(top: 0, left: 16, bottom: 0, right: 0))
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,subView,textStack,insuranceCodeTextField,bottomStack,insuranceDrop,signUpButton)
        
        
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
        insuranceDrop.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        
        insuranceCodeTextField.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        bottomStack.anchor(top: insuranceCodeTextField.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        
        
        signUpButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
        
    }
    
    fileprivate func changeBoyGirlState(_ sender: UIButton,secondBtn:UIButton,isMale:Bool) {
        if sender.backgroundColor == nil {
            registerViewModel.isMale = isMale;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: secondBtn)
        registerViewModel.isMale = isMale
    }
    
    @objc func tapDone(sender: Any, datePicker1: UIDatePicker) {
        if let datePicker = self.birthdayTextField.inputView as? UIDatePicker { // 2.1
            let dateformatter = DateFormatter() // 2.2
            dateformatter.dateStyle = .medium // 2.3
            self.birthdayTextField.text = dateformatter.string(from: datePicker.date) //2.4
            registerViewModel.birthday = dateformatter.string(from: datePicker.date) //2.4
        }
        self.birthdayTextField.resignFirstResponder() // 2.5
        
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == mobileNumberTextField {
                if  !texts.isValidPhoneNumber    {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    registerViewModel.phone = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    registerViewModel.phone = texts
                }
                
            }else if text == emailTextField {
                if  !texts.isValidEmail    {
                    floatingLabelTextField.errorMessage = "Invalid   Email".localized
                    registerViewModel.email = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    registerViewModel.email = texts
                }
                
            }else   if text == confirmPasswordTextField {
                if text.text != passwordTextField.text {
                    floatingLabelTextField.errorMessage = "Passowrd should be same".localized
                    registerViewModel.confirmPassword = nil
                }
                else {
                    registerViewModel.confirmPassword = texts
                    floatingLabelTextField.errorMessage = ""
                }
            }else  if text == passwordTextField {
                if(texts.count < 8 ) {
                    floatingLabelTextField.errorMessage = "password must have 8 character".localized
                    registerViewModel.password = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    registerViewModel.password = texts
                }
            }else  if text == addressTextField {
                if (texts.count < 3 ) {
                    floatingLabelTextField.errorMessage = "Invalid Address".localized
                    registerViewModel.address = nil
                }
                else {
                    
                    registerViewModel.address = texts
                    floatingLabelTextField.errorMessage = ""
                }
                
            }else if text == fullNameTextField {
                if (texts.count < 3 ) {
                    floatingLabelTextField.errorMessage = "Invalid name".localized
                    registerViewModel.name = nil
                }
                else {
                    
                    registerViewModel.name = texts
                    floatingLabelTextField.errorMessage = ""
                }
                
            }else  {
                if (texts.count < 5 ) {
                    floatingLabelTextField.errorMessage = "Invalid Code".localized
                    registerViewModel.insuranceCode = nil
                }
                else {
                    
                    registerViewModel.insuranceCode = texts
                    floatingLabelTextField.errorMessage = ""
                }
                
            }
        }
    }
    
    
    @objc func handleASD()  {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc func handleASDs()  {
        confirmPasswordTextField.isSecureTextEntry = !confirmPasswordTextField.isSecureTextEntry
    }
    
    @objc func handleHidePicker(sender:UIMultiPicker)  {
        sender.selectedIndexes.forEach { (i) in
            
            de += insuracneArray[i] + ","
        }
        iiii = de
        insuracneText.text = iiii
        registerViewModel.insurance = iiii
        de = ""
    }
    
    @objc func handleOpenCloseInsurance()  {
        registerViewModel.isChoosedInsurance = true
        insuranceDrop.isHidden = !insuranceDrop.isHidden
    }
    
    @objc func handleAgree(sender:UIButton)  {
        
        registerViewModel.isAccept = !registerViewModel.isAccept!
        sender.isSelected = !sender.isSelected
    }
    
    
    
    @objc func handleGirl(sender:UIButton)  {
        changeBoyGirlState(sender,secondBtn: boyButton,isMale: false)
    }
    
    @objc func handleBoy(sender:UIButton)  {
        changeBoyGirlState(sender, secondBtn: girlButton, isMale: true)
    }
    
}


