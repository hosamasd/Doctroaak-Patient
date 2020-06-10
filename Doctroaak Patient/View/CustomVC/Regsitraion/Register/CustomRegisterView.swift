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
import MOLH

class CustomRegisterView: CustomBaseView {
    
    
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
    
    lazy var titleLabel = UILabel(text: "Welcome".localized, font: .systemFont(ofSize: 30), textColor: .white,textAlignment: MOLHLanguage.isRTLLanguage() ? .right : .left)
    lazy var soonLabel = UILabel(text: "Create account".localized, font: .systemFont(ofSize: 18), textColor: .white,textAlignment: MOLHLanguage.isRTLLanguage() ? .right : .left)
    
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
    
    lazy var fullNameTextField = createMainTextFields(place: " Name".localized)
    lazy var mobileNumberTextField = createMainTextFields(place: " phone".localized,type: .numberPad)
    lazy var emailTextField = createMainTextFields(place: "enter email".localized,type: .emailAddress)
    lazy var passwordTextField:UITextField = {
        let s = createMainTextFields(place: "Password".localized, type: .default,secre: true)
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "visiblity"), for: .normal)
        button.imageEdgeInsets = showPassword
        button.frame = CGRect(x: CGFloat(s.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(handleASD), for: .touchUpInside)
        s.rightView = button
        s.rightViewMode = .always
        return s
    }()
    lazy var confirmPasswordTextField:UITextField = {
        let s = createMainTextFields(place: "confirm Password".localized, type: .default,secre: true)
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "visiblity"), for: .normal)
        button.imageEdgeInsets = showPassword//UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(s.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(handleASDs), for: .touchUpInside)
        s.rightView = button
        s.rightViewMode = .always
        return s
    }()
    lazy var boyButton:UIButton = createMainButtonsForGenderss(title: "Male",img:#imageLiteral(resourceName: "toilet"), bg: false)
    lazy var girlButton:UIButton = createMainButtonsForGenderss(title: "Female",img:#imageLiteral(resourceName: "toile11t"), bg: true)
    lazy var birthdayTextField:UITextField = {
        let t = UITextField()
        
        t.layer.cornerRadius = 8
        t.clipsToBounds = true
        t.textAlignment = .center
        t.textColor = .black
        t.attributedPlaceholder = NSAttributedString(string: "   Birthday".localized,attributes: [.foregroundColor: UIColor.black])
        t.layer.borderWidth = 1
        t.layer.borderColor = UIColor.lightGray.cgColor
        return t
    }()
    lazy var addressTextField = createMainTextFields(place: "Address".localized)
    lazy var mainDrop2View = makeMainSubViewWithAppendView(vv: [insuranceDrop])
    
    lazy var insuranceDrop:DropDown = {
           let i = returnMainDropDown(bg: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1), plcae: "Insurance company")
           i.didSelect { (txt, index, _) in
               UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                   self.insuranceCodeTextField.isHide(false)
               })
               self.registerViewModel.isInsurance = true
           }
           return i
       }()
    
//    lazy var insuranceDrop:DropDown = {
//        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
//        i.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left
//        i.textColor = .black
//        i.tintColor = .black
//        i.rowBackgroundColor = .gray
//
//        i.arrowSize = 20
//        i.attributedPlaceholder = NSAttributedString(string: "Insurance company".localized,attributes: [.foregroundColor: UIColor.black])
//
//        i.didSelect { (txt, index, _) in
//            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
//                self.insuranceCodeTextField.isHide(false)
//            })
//            self.registerViewModel.isInsurance = true
//            //            self.registerViewModel.insuranceCode =  self.insuracneIDSArray[index]//index+1
//        }
//        return i
//    }()
    lazy var insuranceCodeTextField = createMainTextFields(place: "Insurance code".localized)
    
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
        button.setTitle("SIGN UP".localized, for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    let registerViewModel = RegisterViewModel()
    var insuracneArray = [String]()
    var insuracneIDSArray = [Int]()
    let showPassword = MOLHLanguage.isRTLLanguage() ? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -16) : UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if boyButton.backgroundColor == nil  {
            addGradientInSenderAndRemoveOther(sender: boyButton)
        }
        
    }
    
    fileprivate func addViewsTargets() {
        insuranceCodeTextField.constrainHeight(constant: 60)
        [  mobileNumberTextField,passwordTextField, emailTextField,addressTextField, fullNameTextField, confirmPasswordTextField, insuranceCodeTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)})
        boyButton.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
        girlButton.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
        birthdayTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
        acceptButton.addTarget(self, action: #selector(handleAgree), for: .touchUpInside)
    }
    
    
    
    override func setupViews() {
        insuranceCodeTextField.isHide(true)
        addViewsTargets()
        
        let subView = UIView(backgroundColor: .clear)
        subView.addSubViews(views: userProfileImage,userEditProfileImageView)
        subView.constrainWidth(constant: 100)
        subView.constrainHeight(constant: 100)
        userEditProfileImageView.anchor(top: nil, leading: nil, bottom: userProfileImage.bottomAnchor, trailing: userProfileImage.trailingAnchor,padding: .init(top: 0, left:0 , bottom:10, right: 10))
        let bottomStack = getStack(views: UIView(),acceptButton,acceptLabel,createAccountButton,UIView(), spacing: 0, distribution: .fillProportionally, axis: .horizontal)
        
        let genderStack = getStack(views: boyButton,girlButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let textStack = getStack(views: fullNameTextField,addressTextField,mobileNumberTextField,emailTextField,passwordTextField,confirmPasswordTextField,genderStack,birthdayTextField,mainDrop2View, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
        
        mainDrop2View.hstack(insuranceDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,subView,textStack,insuranceCodeTextField,bottomStack,signUpButton)
        
        
        NSLayoutConstraint.activate([
            bottomStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            userProfileImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        if MOLHLanguage.isRTLLanguage() {
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
        }else {
            
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        }
        
        //        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        subView.anchor(top: LogoImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 50, left: 0, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        textStack.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
        
        insuranceCodeTextField.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        bottomStack.anchor(top: insuranceCodeTextField.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        
        
        signUpButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
        
    }
    
    func getInsuraces()  {
        fetchEnglishData(isArabic: MOLHLanguage.isRTLLanguage())
        
    }
    
    func putDataInDrops(ir:[String],iid:[Int])  {
        self.insuracneArray = ir
        self.insuracneIDSArray = iid
        
    }
    
    fileprivate func fetchEnglishData(isArabic:Bool) {
        if isArabic {
            
            
            if let specificationsArray = userDefaults.value(forKey: UserDefaultsConstants.insuranceNameARArray) as? [String],let specificationIds = userDefaults.value(forKey: UserDefaultsConstants.insuranceIdArray) as? [Int]{
                putDataInDrops( ir: specificationsArray, iid: specificationIds)
                
            }
        }else {
            if let specificationsArray = userDefaults.value(forKey: UserDefaultsConstants.insuranceNameArray) as? [String],let specificationIds = userDefaults.value(forKey: UserDefaultsConstants.insuranceIdArray) as? [Int] {
                putDataInDrops( ir: specificationsArray, iid: specificationIds)
            }
        }
        self.insuranceDrop.optionArray = self.insuracneArray
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
    
    fileprivate func changeBoyGirlState(_ sender: UIButton,secondBtn:UIButton,isMale:Bool) {
        if sender.backgroundColor == nil {
            registerViewModel.gender = isMale ? "male" : "female" ;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: secondBtn)
        registerViewModel.gender = isMale ? "male" : "female"
    }
    
    @objc func tapDone(sender: Any, datePicker1: UIDatePicker) {
        if let datePicker = self.birthdayTextField.inputView as? UIDatePicker { // 2.1
            let dateformatter = DateFormatter() // 2.2
            dateformatter.dateFormat = "yyyy-MM-dd".localized
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
                    
                    registerViewModel.insuranceCode = texts.toInt()
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


