//
//  CustomMainForgetPassView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import SkyFloatingLabelTextField


class CustomForgetPassView: CustomBaseView {
    
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
    
    lazy var titleLabel = UILabel(text: "Forget".localized, font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Password".localized, font: .systemFont(ofSize: 30), textColor: .white)
    lazy var choosePayLabel = UILabel(text: "Enter your phone number :".localized, font: .systemFont(ofSize: 18), textColor: .black,textAlignment: .center)
    
    lazy var numberTextField:UITextField = {
        let s = createMainTextFields(padding:100,place: "(324) 242-2457", type: .phonePad)
        s.textAlignment = .center
        let button = UIImageView(image: #imageLiteral(resourceName: "Group 4142-3"))
        button.frame = CGRect(x: CGFloat(s.frame.size.width - 80), y: CGFloat(0), width: CGFloat(80), height: CGFloat(50))
        s.leftView = button
        s.leftViewMode = .always
        s.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)

        return s
    }()
    lazy var nextButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save".localized, for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        
        button.clipsToBounds = true
//        button.isEnabled = false
        return button
    }()
    
    let forgetPassViewModel = ForgetPassViewModel()

    override func layoutSubviews() {
        addGradientInSenderAndRemoveOther(sender: nextButton)
    }
    
    override func setupViews() {
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,nextButton,choosePayLabel,numberTextField)
        
        
        choosePayLabel.centerInSuperview(size: .init(width: frame.width, height: 120))
        //
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        numberTextField.anchor(top: choosePayLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 32, bottom: 16, right: 32))
        
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
          guard let texts = text.text else { return  }
          if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
              if  !texts.isValidPhoneNumber    {
                  floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                  forgetPassViewModel.phone = nil
              }
              else {
                  floatingLabelTextField.errorMessage = ""
                  forgetPassViewModel.phone = texts
              }
              
              
          }
      }
}
