//
//  CustomProfileView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import SkyFloatingLabelTextField
import SDWebImage

class CustomProfileView: CustomBaseView {
    
    var patient:PatienModel?{
           didSet{
               guard let patient = patient else { return  }
            let urlString = patient.photo
            guard let url = URL(string: urlString) else { return  }
            doctorProfileImage.sd_setImage(with: url)
            addressTextField.text = patient.address
            emailTextField.text = patient.email
            phoneTextField.text = patient.phone
            birthdayTextField.text = patient.birthdate ?? ""
            putOtherData(patient)

            DispatchQueue.main.async {
                self.addGradientInSenderAndRemoveOther(sender: patient.gender == "male" ? self.boyButton : self.girlButton)

            }
        }
       }
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116").withRenderingMode(.alwaysOriginal))
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
    lazy var titleLabel = UILabel(text: "Profile", font: .systemFont(ofSize: 35), textColor: .white)
    
    lazy var doctorProfileImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4143"))
        i.constrainWidth(constant: 100)
        i.constrainHeight(constant: 100)
        i.layer.cornerRadius = 50
        i.clipsToBounds = true
        return i
    }()
    lazy var doctorEditProfileImageView: UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142"))
        i.constrainWidth(constant: 28)
        i.constrainHeight(constant: 28)
        i.layer.cornerRadius = 8
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var addressTextField:SkyFloatingLabelTextField = {
        let t = SkyFloatingLabelTextField()
        t.keyboardType = UIKeyboardType.default
        t.placeholder = " Address".localized
        t.titleColor = .black
        t.title = "enter your Address".localized
        t.placeholderColor = .black
        t.lineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
        t.selectedLineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
        t.errorColor = UIColor.red
        return t
    }()
    lazy var phoneTextField:SkyFloatingLabelTextField = {
        let t = SkyFloatingLabelTextField()
        t.lineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
        t.placeholder = "Phone".localized
        t.keyboardType = UIKeyboardType.numberPad
        t.title = "Phone".localized
        t.placeholderColor = .black
        t.isUserInteractionEnabled=false

        t.selectedLineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
        return t
    }()
    lazy var emailTextField:SkyFloatingLabelTextField = {
        let t = SkyFloatingLabelTextField()
        t.keyboardType = UIKeyboardType.emailAddress
        t.placeholder = "enter your email".localized
        t.titleColor = .black
        t.title = "your email".localized
        t.placeholderColor = .black
        t.lineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
        t.selectedLineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
        t.errorColor = UIColor.red
        t.constrainHeight(constant: 60)
        t.isUserInteractionEnabled=false
        return t
    }()
    lazy var birthdayTextField:SkyFloatingLabelTextField = {
        let t = SkyFloatingLabelTextField()
        //           t.keyboardType = UIKeyboardType.emailAddress
        t.placeholder = "enter your Birthday".localized
        t.titleColor = .black
        t.title = " Birthday".localized
        t.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
        
        t.placeholderColor = .black
        t.lineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
        t.selectedLineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
        t.errorColor = UIColor.red
        //           t.constrainHeight(constant: 50)
        return t
    }()
    lazy var boyButton:UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Male", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .white

        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.clipsToBounds = true
        button.leftImage(image: #imageLiteral(resourceName: "toilet"), renderMode: .alwaysOriginal)
        button.isEnabled = false
        
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
        button.isEnabled = false
        
        return button
    }()
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
//        button.isEnabled = false
        return button
    }()
    
    let edirProfileViewModel = EdirProfileViewModel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradientInSenderAndRemoveOther(sender: nextButton)
    }
    
    override func setupViews() {
        [ phoneTextField,emailTextField,addressTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)})
        let genderStack = getStack(views: boyButton,girlButton, spacing: 8, distribution: .fillEqually, axis: .horizontal)
        
        let subView = UIView(backgroundColor: .clear)
        subView.addSubViews(views: doctorProfileImage,doctorEditProfileImageView)
        subView.constrainWidth(constant: 100)
        subView.constrainHeight(constant: 100)
        doctorEditProfileImageView.anchor(top: nil, leading: nil, bottom: doctorProfileImage.bottomAnchor, trailing: doctorProfileImage.trailingAnchor,padding: .init(top: 0, left:0 , bottom:10, right: 10))
        
        let textStack = getStack(views: addressTextField,emailTextField,phoneTextField,birthdayTextField,genderStack, spacing: 24, distribution: .fillEqually, axis: .vertical)
        
        addSubViews(views: LogoImage,backImage,titleLabel,subView,textStack,nextButton)
        
        //         insuranceDrop.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        NSLayoutConstraint.activate([
            subView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        subView.anchor(top: LogoImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 50, left: 0, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        textStack.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
        
        
        
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
        
    }
    
    func putOtherData(_ patient:PatienModel) {
        edirProfileViewModel.name=patient.name
        edirProfileViewModel.email=patient.email
        edirProfileViewModel.birthday=patient.birthdate
        edirProfileViewModel.male=patient.gender
        edirProfileViewModel.address=patient.address
        edirProfileViewModel.user_id=patient.id
        edirProfileViewModel.api_token=patient.apiToken
        edirProfileViewModel.image=doctorEditProfileImageView.image ?? UIImage()
        edirProfileViewModel.isPhotoEdit=false
        edirProfileViewModel.phone=patient.phone
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == phoneTextField {
                if  !texts.isValidPhoneNumber    {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    edirProfileViewModel.phone = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    edirProfileViewModel.phone = texts
                }
                
            }else if text == emailTextField {
                if  !texts.isValidEmail    {
                    floatingLabelTextField.errorMessage = "Invalid   Email".localized
                    edirProfileViewModel.email = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    edirProfileViewModel.email = texts
                }
                
            }else   {
                if (texts.count < 3 ) {
                    floatingLabelTextField.errorMessage = "Invalid Address".localized
                    edirProfileViewModel.address = nil
                }
                else {
                    
                    edirProfileViewModel.address = texts
                    floatingLabelTextField.errorMessage = ""
                }
                
            }
            
        }
    }
    
    @objc func tapDone(sender: Any, datePicker1: UIDatePicker) {
        if let datePicker = self.birthdayTextField.inputView as? UIDatePicker { // 2.1
            let dateformatter = DateFormatter() // 2.2
            dateformatter.dateFormat = "yyyy-MM-dd"
            self.birthdayTextField.text = dateformatter.string(from: datePicker.date) //2.4
            edirProfileViewModel.birthday = dateformatter.string(from: datePicker.date) //2.4
        }
        self.birthdayTextField.resignFirstResponder() // 2.5
        
    }
}
