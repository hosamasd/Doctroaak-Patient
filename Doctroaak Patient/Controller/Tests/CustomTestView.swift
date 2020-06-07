//
//  CustomTestView.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/1/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH
import iOSDropDown

class CustomTestView: CustomBaseView {
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116-1"))
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
    
    lazy var titleLabel = UILabel(text: "Book", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Select Your Location", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var bookSegmentedView:UISegmentedControl = {
        let view = UISegmentedControl(items: ["Book for me","Book for another person"])
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.backgroundColor = UIColor.lightGray.cgColor
        view.constrainHeight(constant: 50)
        view.selectedSegmentIndex = 0
        view.tintColor = .black
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 20)
        /// Gradient
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(x: 0, y: 0, width:  UIScreen.main.bounds.width - 40, height: 20)
        let leftColor = #colorLiteral(red: 0.6002450585, green: 0.3833707869, blue: 0.9996971488, alpha: 1)
        let rightColor = #colorLiteral(red: 0.4903785586, green: 0.2679489255, blue: 0.9277817607, alpha: 1)
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        /// Create gradient image
        UIGraphicsBeginImageContext(gradient.frame.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let segmentedControlImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Normal Image
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size);
        let context:CGContext = UIGraphicsGetCurrentContext()!;
        context.setFillColor(#colorLiteral(red: 0.9352307916, green: 0.9353840947, blue: 0.9351981282, alpha: 1).cgColor)
        context.fill(rect)
        let normalImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        /// Set segmentedControl image
        view.setBackgroundImage(normalImage, for: .normal, barMetrics: .default)
        view.setBackgroundImage(segmentedControlImage, for: .selected, barMetrics: .default)
        view.addTarget(self, action: #selector(handleOpenOther), for: .valueChanged)
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
        t.textAlignment = .left
        t.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
        
        return t
    }()
    
    lazy var mainDropView =  makeMainSubViewWithAppendView(vv: [typeDrop])
    lazy var typeDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left
        i.arrowSize = 20
        i.placeholder = "Type".localized
        
        return i
    }()
    lazy var shift1Button = secondButtons(title: "Shift 1")
    lazy var shift2Button = secondButtons(title: "Shift 2")
    
    lazy var fullNameTextField = createMainTextFields(place: "Full name")
    lazy var mobileNumberTextField = createMainTextFields(place: "enter Mobile",type: .numberPad)
    
    lazy var dayTextField = createMainTextFields(place: "   DD")
    lazy var monthTextField = createMainTextFields(place: " MM")
    lazy var yearTextField = createMainTextFields(place: "  YYYY")
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
        button.layer.cornerRadius = 8
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        return button
    }()
    
    var isActive = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isActive {
            
            
            if boyButton.backgroundColor == nil {//|| bookButton.backgroundColor == nil || shift1Button.backgroundColor == nil {
                addGradientInSenderAndRemoveOther(sender: boyButton)
                boyButton.setTitleColor(.white, for: .normal)
            }
            if bookButton.backgroundColor == nil {
                addGradientInSenderAndRemoveOther(sender: bookButton)
                bookButton.setTitleColor(.white, for: .normal)
                
            }
            if shift1Button.backgroundColor == nil  {
                addGradientInSenderAndRemoveOther(sender: shift1Button)
                
                shift1Button.setTitleColor(.white, for: .normal)
                
                
            }
        }
        
    }
    
    override func setupViews() {
//        [fullNameTextField,mobileNumberTextField,dayTextField,boyButton].forEach({$0.constrainHeight(constant: 60)})
//        let sV = getStack(views: mainDateView,mainDropView, spacing: 16, distribution: .fillEqually, axis: .vertical)
//        let sssd = getStack(views: shift1Button,shift2Button, spacing: 16, distribution: .fillEqually, axis: .horizontal)
//        
//        
//        let mainStack = getStack(views: sV,sssd,subStack, spacing: 16, distribution: .fillProportionally, axis: .vertical)
//        
//        
//        dateTextField.fillSuperview(padding: .init(top: 16, left: 16, bottom: 0, right: 16))
//        typeDrop.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
//        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,bookSegmentedView)//,bookButton,mainStack)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: -30, left: 0, bottom: 0, right: -60))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: backImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: 0, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        bookSegmentedView.anchor(top: backImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 32, bottom: 16, right: 32))
//
//        mainStack.anchor(top: bookSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
//        bookButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 16, bottom: 16, right: 16))
        
    }
    
    func secondButtons(title:String) ->UIButton {
        let b  = UIButton()
        b.setTitle(title, for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.constrainHeight(constant: 50)
        b.layer.cornerRadius = 8
        b.clipsToBounds = true
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.lightGray.cgColor
        return b
    }
    
    
    func colorBackgroundSelectedButton(sender:UIButton,views:[UIButton])  {
        views.forEach { (bt) in
            bt.setTitleColor(.black, for: .normal)
            bt.backgroundColor = .gray
            //            bt.
        }
        //        sender.backgroundColor = ColorConstant.mainBackgroundColor
    }
    
    @objc func tapDone(sender: Any, datePicker1: UIDatePicker) {
        if let datePicker = self.dateTextField.inputView as? UIDatePicker { // 2.1
            datePicker.datePickerMode = UIDatePicker.Mode.date
            let dateformatter = DateFormatter() // 2.2
            dateformatter.setLocalizedDateFormatFromTemplate("yyyy")// 2.3
            self.dateTextField.text = dateformatter.string(from: datePicker.date) //2.4
            //            self.handleTextContents?(dateTextField.text ?? "",true)
        }
        self.dateTextField.resignFirstResponder() // 2.5
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
    }
    
    @objc func handleOpenOther(sender:UISegmentedControl)  {
        isActive = false
        subStack.isHide(sender.selectedSegmentIndex == 0 ? true : false)
    }
    
    
}


