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
//        view.defaultTextFont = .systemFont(ofSize: 14)
//        view.selectedTextFont = .systemFont(ofSize: 12)
        view.didSelectItemWith = {[unowned self] (index, title) in
            self.isActive = false
            if index == 0 {
                self.subStack.isHide(true)
                self.dateCenterTextField.isHide(false)
                self.lapBookViewModel.secondDates = nil
                [self.fullNameTextField,self.monthTextField,self.mobileNumberTextField,self.dayTextField,self.yearTextField,self.dateTextField].forEach({$0.text = ""})
                
            }else {
                self.subStack.isHide(false)
                self.dateCenterTextField.isHide(true)
                self.dateCenterTextField.text = ""
                self.lapBookViewModel.dates = nil
                
            }
        }
        return view
    }()
    lazy var dateTextField:UITextField={
        let t = UITextField()
        t.placeholder =  "Enter Date".localized
        t.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
        
        return t
    }()
    lazy var dateCenterTextField :UITextField={
        let t = UITextField()
        t.placeholder =  "Enter Date".localized
        t.setInputViewDatePicker(target: self, selector: #selector(tap2Done)) //1
        return t
    }()
    lazy var fullNameTextField = createMainTextFields(place: "Full name")
    lazy var mobileNumberTextField = createMainTextFields(place: "enter Mobile",type: .numberPad)
    
    
    
    lazy var dayTextField:UITextField = {
        let t = UITextField()
        t.placeholder =  "DD".localized
        t.setInputViewDatePicker(target: self, selector: #selector(tapAllDone)) //1
        t.tag = 0
        return t
    }()
    
    lazy var monthTextField:UITextField = {
        let t = UITextField()
        t.placeholder =  "MM".localized
        t.setInputViewDatePicker(target: self, selector: #selector(tapAllDone)) //1
        t.tag = 1
        return t
    }()
    lazy var yearTextField:UITextField = {
        let t = UITextField()
        t.placeholder =  "YYYY".localized
        t.setInputViewDatePicker(target: self, selector: #selector(tapAllDone)) //1
        t.tag = 2
        return t
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
        
        let tx = getStack(views: dayTextField,monthTextField,yearTextField, spacing: 8, distribution: .fillEqually, axis: .horizontal)
        let s = getStack(views:dateTextField,fullNameTextField,mobileNumberTextField,tx,genderStack, spacing: 16, distribution: .fillEqually, axis: .vertical)
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
    var days = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    lazy var years:[String] = {
        var vv = [String]()
        for s in stride(from: 2020, to: 1900, by: -1) {
            vv.append("\(s)")
        }
        return vv
    }()
    let lapBookViewModel = LAPBookViewModel()
    
    var index:Int = 0
    
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
        [monthTextField,dayTextField,yearTextField,dateCenterTextField,dateTextField].forEach { (t) in
            t.textAlignment = .center
            t.layer.cornerRadius = 8
            t.layer.borderWidth = 1
            t.layer.borderColor = UIColor.lightGray.cgColor
            t.clipsToBounds = true
            t.constrainHeight(constant: 60)
        }
        [mobileNumberTextField,fullNameTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        })
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,orderSegmentedView,dateCenterTextField,subStack,bookButton)
        
        NSLayoutConstraint.activate([
            dateCenterTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateCenterTextField.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 60)
        ])
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        
        
        
        orderSegmentedView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 108, left: 46, bottom: 0, right: 32))
        dateCenterTextField.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 32, left: 46, bottom: 0, right: 32))
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
    
    
    func putTextInTextFieldsAllDate(tf:UITextField,dp:UIDatePicker)  {
        dp.datePickerMode = UIDatePicker.Mode.date
        let dateMainformatter = DateFormatter() // 2.2
        
        let dateformatter = DateFormatter() // 2.2
        let date2formatter = DateFormatter() // 2.2
        let date3formatter = DateFormatter() // 2.2
        
        
        dateMainformatter.setLocalizedDateFormatFromTemplate("dd:MM:YYYY")
        
        dateformatter.setLocalizedDateFormatFromTemplate("dd")
        date2formatter.setLocalizedDateFormatFromTemplate("MM")
        
        date3formatter.setLocalizedDateFormatFromTemplate("YYYY")
        dayTextField.text = dateformatter.string(from: dp.date)
        monthTextField.text = date2formatter.string(from: dp.date)
        yearTextField.text = date3formatter.string(from: dp.date)
        
        //         tf.text = dateformatter.string(from: dp.date) //2.4
        lapBookViewModel.birthday = dateMainformatter.string(from: dp.date)
        
        endEditing(true)
        tf.resignFirstResponder() // 2.5
    }
    
    fileprivate func changeBoyGirlState(_ sender: UIButton,secondBtn:UIButton,isMale:Bool) {
        if sender.backgroundColor == nil {
            lapBookViewModel.isMale = isMale;return
        }else {
            addGradientInSenderAndRemoveOther(sender: sender, vv: secondBtn)
            lapBookViewModel.isMale = isMale
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
            }else {
                if  !texts.isValidPhoneNumber    {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    lapBookViewModel.mobileNumber = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    lapBookViewModel.mobileNumber = texts
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
        //
        if let datePicker = self.dateTextField.inputView as? UIDatePicker { // 2.1
            putTextInTextFields(tf: dateTextField, dp: datePicker,isOnly: false)
        }
        //
    }
    //
    @objc func tap2Done(sender: Any ) {
        if let datePicker = self.dateCenterTextField.inputView as? UIDatePicker { // 2.1
            putTextInTextFields(tf: dateCenterTextField, dp: datePicker,isOnly: true)
        }
    }
    //
    @objc func tap3Done(sender: Any) {
        if let datePicker = self.yearTextField.inputView as? UIDatePicker { // 2.1
            //
            putTextInTextFieldsAllDate( tf: yearTextField, dp: datePicker)
        }
    }
    
    @objc func tap4Done(sender: Any ) {
        if let datePicker = self.monthTextField.inputView as? UIDatePicker { // 2.1
            putTextInTextFieldsAllDate( tf: monthTextField, dp: datePicker)
        }
    }
    
    @objc func tapAllDone(sender: UITextField) {
        if let datePicker = self.dayTextField.inputView as? UIDatePicker {
            putTextInTextFieldsAllDate( tf: dayTextField, dp: datePicker)
        }
        
    }
    
    
    
}

