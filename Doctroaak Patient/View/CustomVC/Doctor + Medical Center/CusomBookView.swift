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


class CusomBookView: CustomBaseView {
    
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
        view.defaultTextFont = .systemFont(ofSize: 14)
        view.selectedTextFont = .systemFont(ofSize: 12)
        view.didSelectItemWith = {[unowned self] (index, title) in
            self.isActive = false
            self.subStack.isHide(index == 0 ? true : false)
            index == 0 ?  self.updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116"),tr: 0,tops: 200,bottomt:80,log: -48 ,centerImg: 250) : self.updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116-1"),tr: 60,tops: 60,bottomt:0,log: 0, centerImg: 100 )
            self.doctorBookViewModel.isFirstOpetion = index == 0 ? true : false
            
        }
        return view
    }()
    lazy var mainDateView:UIView = {
        let l = UIView(backgroundColor: .white)
        l.layer.cornerRadius = 8
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
        l.addSubview(dateTextField)
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
        i.optionArray = ["one","two","three"]
        i.arrowSize = 20
        i.placeholder = "Type".localized
        i.didSelect {[unowned self] (txt, index, _) in
            self.doctorBookViewModel.type = txt
            self.doctorBookViewModel.secondType = txt
        }
        return i
    }()
    lazy var shift1Button = secondButtons(title: "Shift 1")
    lazy var shift2Button = secondButtons(title: "Shift 2")
    
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
        return button
    }()
    lazy var girlButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Female", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.clipsToBounds = true
        button.leftImage(image: #imageLiteral(resourceName: "toile11t"), renderMode: .alwaysOriginal)
        return button
    }()
    lazy var subStack:UIStackView = {
        let genderStack = getStack(views: boyButton,girlButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let tx = getStack(views: dayTextField,monthTextField,yearTextField, spacing: 8, distribution: .fillEqually, axis: .horizontal)
        let s = getStack(views:fullNameTextField,mobileNumberTextField,tx,genderStack, spacing: 16, distribution: .fillProportionally, axis: .vertical)
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
    
    //    var days = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    //    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    //    lazy var years:[String] = {
    //        var vv = [String]()
    //        for s in stride(from: 2020, to: 1900, by: -1) {
    //            vv.append("\(s)")
    //        }
    //        return vv
    //    }()
    
    let doctorBookViewModel = DoctorBookViewModel()
    
    
    var constainedLogoAnchor:AnchoredConstraints!
    var bubleViewBottomTitleConstraint:NSLayoutConstraint!
    var bubleViewTopSegConstraint:NSLayoutConstraint!
    
    var isDataFound = false
    var isSecondIndex = false
    var isActive = true
    
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
        [mobileNumberTextField,fullNameTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)})
        boyButton.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
        girlButton.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
        shift1Button.addTarget(self, action: #selector(handle1Shift), for: .touchUpInside)
        shift2Button.addTarget(self, action: #selector(handle2Shift), for: .touchUpInside)
        [titleLabel,bookSegmentedView,LogoImage].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        [monthTextField,dayTextField,yearTextField].forEach { (t) in
            t.textAlignment = .center
            t.layer.cornerRadius = 8
            t.layer.borderWidth = 1
            t.layer.borderColor = UIColor.lightGray.cgColor
            t.clipsToBounds = true
        }
        [fullNameTextField,mobileNumberTextField,dayTextField,boyButton].forEach({$0.constrainHeight(constant: 60)})
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
            doctorBookViewModel.isMale = isMale;return
            
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: secondBtn)
        doctorBookViewModel.isMale = isMale;return
        
    }
    
   fileprivate func changeShiftsState(_ sender: UIButton,secondBtn:UIButton,isShift1:Bool) {
        if sender.backgroundColor == nil {
            doctorBookViewModel.shiftOne = isShift1;return
            
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: secondBtn)
        doctorBookViewModel.shiftOne = isShift1;return
        
    }
    
  fileprivate  func putTextInTextFieldsAllDate(tf:UITextField,dp:UIDatePicker)  {
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
        doctorBookViewModel.fullDate = dateMainformatter.string(from: dp.date)
        
        endEditing(true)
        tf.resignFirstResponder() // 2.5
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
        
    }
    
    @objc  func handle2Shift(sender:UIButton)  {
        changeShiftsState(sender, secondBtn: shift1Button, isShift1: true)
        
    }
    
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
               }else {
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
       }
       
       @objc func tapDone(sender: Any, datePicker1: UIDatePicker) {
           if let datePicker = self.dateTextField.inputView as? UIDatePicker { // 2.1
               datePicker.datePickerMode = UIDatePicker.Mode.date
               let dateformatter = DateFormatter() // 2.2
               dateformatter.setLocalizedDateFormatFromTemplate("dd:MM:yyyy")// 2.3
               let tzt = dateformatter.string(from: datePicker.date) //2.4
               
               self.dateTextField.text = tzt
               doctorBookViewModel.date = tzt
               doctorBookViewModel.secondDate = tzt
               //            self.handleTextContents?(dateTextField.text ?? "",true)
           }
           self.dateTextField.resignFirstResponder() // 2.5
       }
       
    
}

//
//extension CusomBookView:UIPickerViewDelegate,UIPickerViewDataSource{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerView == dayPickerView ? days.count  : pickerView==monthPickerView ?  months.count : years.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerView == dayPickerView ? days[row] : pickerView==monthPickerView ?   months[row] : years[row]
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView==dayPickerView {
//            dayTextField.text = days[row]
//        }else if pickerView==monthPickerView{
//            monthTextField.text = months[row]
//        }else {
//            yearTextField.text = years[row]
//        }
//        
//    }
//}
