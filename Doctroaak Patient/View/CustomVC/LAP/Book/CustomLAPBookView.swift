//
//  CustomLAPBookView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import TTSegmentedControl

class CustomLAPBookView: CustomBaseView {
    
    var patient:PatienModel?{
                  didSet{
                      guard let patient = patient else { return  }
                    lapBookViewModel.patient_id=patient.id
                    lapBookViewModel.api_token=patient.apiToken
                  }
              }
    
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
    lazy var titleLabel = UILabel(text: "Book ", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Select Your Location", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var orderSegmentedView:TTSegmentedControl = {
        let view = TTSegmentedControl()
        view.itemTitles = ["Book for me","Book for another person"]
        view.allowChangeThumbWidth = false
        view.constrainHeight(constant: 50)
        view.thumbGradientColors = [#colorLiteral(red: 0.6887479424, green: 0.4929093719, blue: 0.9978651404, alpha: 1),#colorLiteral(red: 0.5526981354, green: 0.3201900423, blue: 1, alpha: 1)]
        view.useShadow = true
        view.didSelectItemWith = {[unowned self] (index, title) in
            self.isActive = false
            self.lapBookViewModel.isFirstOpetion = index == 0 ? true : false
            if index == 0 {
                self.subStack.isHide(true)
            }else {
                self.subStack.isHide(false)
                
            }
        }
        return view
    }()
    lazy var dateTextField:UITextField = {
        let t = createMainTextFields(place: " date".localized)
        t.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
        t.constrainHeight(constant: 60)
        return t
    }()
    lazy var secondDateTextField:UITextField = {
        let t = createMainTextFields(place: " date".localized)
        t.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
        t.constrainHeight(constant: 60)
        return t
    }()
    
    lazy var fullNameTextField = createMainTextFields(place: "Full name")
    lazy var mobileNumberTextField = createMainTextFields(place: "enter Mobile",type: .numberPad)
    lazy var ageTextField = createMainTextFields(place: "enter age",type: .numberPad)
    
    
    
    lazy var boyButton:UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Male", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.clipsToBounds = true
        button.leftImage(image: #imageLiteral(resourceName: "toilet"), renderMode: .alwaysOriginal)
        button.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
        
        return button
    }()
    lazy var subStack:UIStackView = {
        let genderStack = getStack(views: boyButton,girlButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let s = getStack(views:secondDateTextField,fullNameTextField,mobileNumberTextField,ageTextField,genderStack, spacing: 16, distribution: .fillEqually, axis: .vertical)
        s.isHide(true)
        return s
    }()
    
    
    lazy var bookButton:UIButton = {
        let button = UIButton()
        button.setTitle("Book", for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    let lapBookViewModel = LAPBookViewModel()
    
    var index:Int = 0
//    var  api_token:String?{didSet{lapBookViewModel.api_token=api_token} }
//    var  patient_id:Int?{didSet{lapBookViewModel.patient_id=patient_id}}
    var isActive = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isActive {
            if boyButton.backgroundColor == nil {
                addGradientInSenderAndRemoveOther(sender: boyButton)
                boyButton.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    override func setupViews() {
        //        dateTextField.fillSuperview(padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        [mobileNumberTextField,fullNameTextField,ageTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        })
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,orderSegmentedView,dateTextField,subStack,bookButton)
        
        //        mainDateView.centerInSuperview(size: .init(width: frame.width-128, height: 60))
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        
        
        
        orderSegmentedView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 108, left: 46, bottom: 0, right: 32))
        dateTextField.anchor(top: orderSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 46, bottom: 0, right: 32))
        //        dateCenterTextField.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 32, left: 46, bottom: 0, right: 32))
        subStack.anchor(top: orderSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 46, bottom: 0, right: 32))
        bookButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 32, bottom: 16, right: 32))
        
    }
    
    func createDateTextFields(place:String,tags:Int) ->UITextField  {
        let t = UITextField()
        t.placeholder = place.localized
        t.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
        t.layer.cornerRadius = 8
        t.clipsToBounds = true
        t.layer.borderWidth = 1
        t.layer.borderColor = UIColor.lightGray.cgColor
        t.textAlignment = .center
        t.constrainHeight(constant: 60)
        t.tag = tags
        return t
    }
    
    fileprivate func putTextInTextFields(tf:UITextField,dp:UIDatePicker,isOnly:Bool)  {
        dp.datePickerMode = UIDatePicker.Mode.date
        let dateformatter = DateFormatter() // 2.2
        dateformatter.setLocalizedDateFormatFromTemplate("dd:MM:yyyy")// 2.3
        tf.text = dateformatter.string(from: dp.date) //2.4
        if isOnly {
            lapBookViewModel.dates = dateformatter.string(from: dp.date)
        }else {
            lapBookViewModel.secondDates  = dateformatter.string(from: dp.date)
        }
        lapBookViewModel.index = index
        tf.resignFirstResponder() // 2.5
    }
    
    
    
    
    fileprivate func changeBoyGirlState(_ sender: UIButton,secondBtn:UIButton,isMale:Bool) {
        if sender.backgroundColor == nil {
            lapBookViewModel.male = isMale ?  "male" : "female";return
        }else {
            addGradientInSenderAndRemoveOther(sender: sender, vv: secondBtn)
            lapBookViewModel.male = isMale ?  "male" : "female"
        }
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
        lapBookViewModel.index = index
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == fullNameTextField {
                if  texts.count < 3    {
                    floatingLabelTextField.errorMessage = "Invalid   Name".localized
                    lapBookViewModel.fullName = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    lapBookViewModel.fullName = texts
                }
            }else  if text == ageTextField {
                if  texts.count < 1    {
                    floatingLabelTextField.errorMessage = "Invalid   Age".localized
                    lapBookViewModel.age = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    lapBookViewModel.age = texts.toInt()
                }
            } else {
                if  !texts.isValidPhoneNumber    {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    lapBookViewModel.mobile = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    lapBookViewModel.mobile = texts
                }
            }
        }
    }
    
    
    @objc func handleGirl(sender:UIButton)  {
        changeBoyGirlState(sender,secondBtn: boyButton,isMale: false)
    }
    
    @objc func handleBoy(sender:UIButton)  {
        changeBoyGirlState(sender, secondBtn: girlButton, isMale: true)
    }
    
    @objc func tapDone(sender: UITextField) {
        
//        lapBookViewModel.api_token=api_token
//        lapBookViewModel.patient_id=patient_id
        //               doctorBookViewModel.clinic_id=clinic_id
        if let datePicker = self.dateTextField.inputView as? UIDatePicker { // 2.1
            
            let dateformatter = DateFormatter() // 2.2
            dateformatter.dateFormat = "yyyy-MM-dd"
            self.dateTextField.text = dateformatter.string(from: datePicker.date) //2.4
            self.secondDateTextField.text = dateformatter.string(from: datePicker.date) //2.4
            lapBookViewModel.dates = dateformatter.string(from: datePicker.date) //2.4
            lapBookViewModel.secondDates = dateformatter.string(from: datePicker.date) //2.4
            
        }
        self.dateTextField.resignFirstResponder() // 2.5
        self.secondDateTextField.resignFirstResponder() // 2.5

    }
    
    
    
}

