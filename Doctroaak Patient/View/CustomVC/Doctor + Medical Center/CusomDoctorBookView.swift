//
//  CusomBookView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import iOSDropDown
import SkyFloatingLabelTextField
import TTSegmentedControl


class CusomDoctorBookView: CustomBaseView {
    
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
    
    lazy var titleLabel = UILabel(text: "Book", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Select Your Location", font: .systemFont(ofSize: 18), textColor: .white)
    lazy var bookSegmentedView:TTSegmentedControl = {
        let view = TTSegmentedControl()
        view.itemTitles = ["Book for me","Book for another person"]
        view.allowChangeThumbWidth = false
        view.constrainHeight(constant: 50)
        view.thumbGradientColors = [#colorLiteral(red: 0.6887479424, green: 0.4929093719, blue: 0.9978651404, alpha: 1),#colorLiteral(red: 0.5526981354, green: 0.3201900423, blue: 1, alpha: 1)]
        view.useShadow = true
        view.didSelectItemWith = {[unowned self] (index, title) in
            self.isActive = false
            if index == 0 {
                self.doctorBookViewModel.notes = ""
            }
            self.subStack.isHide(index == 0 ? true : false)
            index == 0 ?  self.updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116"),tr: 0,tops: 200,bottomt:80,log: -48 ,centerImg: 250) : self.updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116-1"),tr: 60,tops: 60,bottomt:0,log: 0, centerImg: 100 )
            self.doctorBookViewModel.isFirstOpetion = index == 0 ? true : false
            self.resetAll()
        }
        return view
    }()
    lazy var mainDateView:UIView =  {
        let l = makeMainSubViewWithAppendView(vv: [dateTextField])
        l.constrainHeight(constant: 60)
        return l
    }()
    lazy var dateTextField:UITextField = {
        let t = UITextField()
        t.placeholder = "enter date".localized
        t.textAlignment = .center
        t.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
        
        return t
    }()
    
    lazy var mainDropView = makeMainSubViewWithAppendView(vv: [typeDrop])
    lazy var typeDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.optionArray = ["New","Consultation","Continue"]
        i.arrowSize = 20
        i.placeholder = "Type".localized
        i.didSelect {[unowned self] (txt, index, _) in
            self.doctorBookViewModel.type = index+1
            self.doctorBookViewModel.secondType = index+1
        }
        return i
    }()
    lazy var shift1Button = secondButtons(title: "Shift 1")
    lazy var shift2Button = secondButtons(title: "Shift 2")
    
    lazy var fullNameTextField = createMainTextFields(place: "Full name")
    lazy var mobileNumberTextField = createMainTextFields(place: "enter Mobile",type: .numberPad)
    lazy var ageTextField = createMainTextFields(place: "enter Age",type: .numberPad)
    
    lazy var boyButton:UIButton = createMainButton(title: "Male",img:#imageLiteral(resourceName: "toilet"), bg: false)
    
    lazy var girlButton:UIButton = createMainButton(title: "Female",img:#imageLiteral(resourceName: "toile11t"), bg: true)
    lazy var subStack:UIStackView = {
        let genderStack = getStack(views: boyButton,girlButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let s = getStack(views:fullNameTextField,mobileNumberTextField,ageTextField,genderStack, spacing: 16, distribution: .fillProportionally, axis: .vertical)
        s.isHide(true)
        return s
    }()
    lazy var bookButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Book", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.layer.cornerRadius = 8
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        return button
    }()
    let doctorBookViewModel = DoctorBookViewModel()
    
    var  api_token:String = ""
       var patient_id:Int = 1
     var clinic_id:Int = 1
    var constainedLogoAnchor:AnchoredConstraints!
    var bubleViewBottomTitleConstraint:NSLayoutConstraint!
    var bubleViewTopSegConstraint:NSLayoutConstraint!
    
    var isDataFound = false
    var isSecondIndex = false
    var isActive = true
//    var api_token:String!
//    var patient_id:Int!
//    var clinic_id:Int!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isActive {
            
            
            if boyButton.backgroundColor == nil {//|| bookButton.backgroundColor == nil || shift1Button.backgroundColor == nil {
                addGradientInSenderAndRemoveOther(sender: boyButton)
                boyButton.setTitleColor(.white, for: .normal)
            }
            
            if shift1Button.backgroundColor != nil  {
                addGradientInSenderAndRemoveOther(sender: shift1Button)
                
                shift1Button.setTitleColor(.white, for: .normal)
            }
        }
        
    }
    
    override func setupViews() {
        [mobileNumberTextField,fullNameTextField,ageTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)})
        boyButton.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
        girlButton.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
        shift1Button.addTarget(self, action: #selector(handle1Shift), for: .touchUpInside)
        shift2Button.addTarget(self, action: #selector(handle2Shift), for: .touchUpInside)
        [titleLabel,bookSegmentedView,LogoImage].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        [fullNameTextField,mobileNumberTextField,ageTextField,boyButton].forEach({$0.constrainHeight(constant: 60)})
        let sV = getStack(views: mainDateView,mainDropView, spacing: 16, distribution: .fillEqually, axis: .vertical)
        let sssd = getStack(views: shift1Button,shift2Button, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        
        let mainStack = getStack(views: sV,sssd,subStack, spacing: 16, distribution: .fillProportionally, axis: .vertical)
        
        
        dateTextField.fillSuperview(padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        typeDrop.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,bookSegmentedView,bookButton,mainStack)
        
        
        constainedLogoAnchor = LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 30, left: -48, bottom: 0, right: 0))
        
        //        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        bubleViewBottomTitleConstraint = titleLabel.bottomAnchor.constraint(equalTo: backImage.bottomAnchor, constant: 80)
        bubleViewBottomTitleConstraint.isActive = true
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        //        bookSegmentedView.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 86, left: 32, bottom: 16, right: 32))
        bookSegmentedView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 200, left: 32, bottom: 16, right: 32))
        
        bubleViewTopSegConstraint = bookSegmentedView.topAnchor.constraint(equalTo: backImage.bottomAnchor, constant: 200)
        bubleViewTopSegConstraint.isActive = true
        
        mainStack.anchor(top: bookSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
        bookButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 16, bottom: 16, right: 16))
        
    }
    
    func resetAll()  {
        mobileNumberTextField.text = nil
        ageTextField.text = nil
    }
    
    fileprivate func secondButtons(title:String) ->UIButton {
        let b  = UIButton()
        b.setTitle(title, for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.constrainHeight(constant: 50)
        b.layer.cornerRadius = 8
        b.clipsToBounds = true
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.lightGray.cgColor
        b.backgroundColor = ColorConstants.disabledButtonsGray
        return b
    }
    
    
    fileprivate  func colorBackgroundSelectedButton(sender:UIButton,views:[UIButton])  {
        views.forEach { (bt) in
            bt.setTitleColor(.black, for: .normal)
            bt.backgroundColor = .gray
        }
    }
    
    
    func createMainButton(title:String,img:UIImage,bg:Bool?) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        if (bg == true) {
            button.backgroundColor = ColorConstants.disabledButtonsGray
        }else{}
        
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.clipsToBounds = true
        button.leftImage(image: img, renderMode: .alwaysOriginal)
        return button
        
    }
    
    fileprivate func updateOtherLabels(img:UIImage,tr:CGFloat,tops:CGFloat,bottomt:CGFloat,log:CGFloat,centerImg:CGFloat) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.LogoImage.image = img
            self.constainedLogoAnchor.trailing?.constant = tr
            self.constainedLogoAnchor.leading?.constant = log
            self.bubleViewBottomTitleConstraint.constant = bottomt
            self.bubleViewTopSegConstraint.constant = tops
            
        })
    }
    
    
    fileprivate func changeBoyGirlState(_ sender: UIButton,secondBtn:UIButton,isMale:Bool) {
        if sender.backgroundColor == nil {
            doctorBookViewModel.isMale = isMale ? "male" : "female";return
            
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: secondBtn)
        doctorBookViewModel.isMale = isMale ? "male" : "female";return
        
    }
    
    fileprivate func changeShiftsState(_ sender: UIButton,secondBtn:UIButton,isShift1:Bool) {
        if sender.backgroundColor == nil {
            doctorBookViewModel.shiftOne = isShift1;return
            
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: secondBtn)
        doctorBookViewModel.shiftOne = isShift1;return
        
    }
    
    //TODO: -handle methods
    
    @objc func handleGirl(sender:UIButton)  {
        changeBoyGirlState(sender,secondBtn: boyButton,isMale: false)
    }
    
    @objc func handleBoy(sender:UIButton)  {
        changeBoyGirlState(sender, secondBtn: girlButton, isMale: true)
    }
    
    @objc  func handle1Shift(sender:UIButton)  {
        changeShiftsState(sender, secondBtn: shift2Button, isShift1: false)
        doctorBookViewModel.part = 0
    }
    
    @objc  func handle2Shift(sender:UIButton)  {
        changeShiftsState(sender, secondBtn: shift1Button, isShift1: true)
        doctorBookViewModel.part = 1

    }
    
    @objc func textFieldDidChange(text: UITextField)  {
        
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == fullNameTextField {
                if  texts.count < 3    {
                    floatingLabelTextField.errorMessage = "Invalid   Name".localized
                    doctorBookViewModel.fullName = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    doctorBookViewModel.fullName = texts
                }
            } else  if text == ageTextField {
                if  texts.count < 1    {
                    floatingLabelTextField.errorMessage = "Invalid   Age".localized
                    doctorBookViewModel.age = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    doctorBookViewModel.age = texts.toInt()
                }
            } else
                if  !texts.isValidPhoneNumber    {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    doctorBookViewModel.mobile = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    doctorBookViewModel.mobile = texts
            }
        }
        
    }
    
    @objc func tapDone(sender: Any, datePicker1: UIDatePicker) {
        doctorBookViewModel.api_token=api_token
        doctorBookViewModel.patient_id=patient_id
        doctorBookViewModel.clinic_id=clinic_id
        if let datePicker = self.dateTextField.inputView as? UIDatePicker { // 2.1
            
            let dateformatter = DateFormatter() // 2.2
            dateformatter.dateFormat = "yyyy-MM-dd"
            self.dateTextField.text = dateformatter.string(from: datePicker.date) //2.4
            doctorBookViewModel.date = dateformatter.string(from: datePicker.date) //2.4
            doctorBookViewModel.secondDate = dateformatter.string(from: datePicker.date) //2.4
            
        }
        self.dateTextField.resignFirstResponder() // 2.5
        
    }
    
    
}

