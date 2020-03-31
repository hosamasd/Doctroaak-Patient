//
//  CustomLAPBookView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

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
    
    lazy var orderSegmentedView:UISegmentedControl = {
        let view = UISegmentedControl(items: ["Book for me","Book for another person"])
        view.layer.cornerRadius = 16
        layer.masksToBounds = true
        view.clipsToBounds = true
        view.apportionsSegmentWidthsByContent = true
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
    lazy var dateTextField:UITextField = {
        let t = UITextField()
        t.placeholder = "enter date".localized
        t.textAlignment = .left
        t.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
        t.layer.cornerRadius = 8
        t.clipsToBounds = true
        t.layer.borderWidth = 1
        t.layer.borderColor = UIColor.lightGray.cgColor
         t.textAlignment = .center
        return t
    }()
    lazy var dateCenterTextField:UITextField = {
        let t = UITextField()
        t.placeholder = "enter date".localized
        t.textAlignment = .left
        t.setInputViewDatePicker(target: self, selector: #selector(tap2Done)) //1
        t.layer.cornerRadius = 8
        t.clipsToBounds = true
        t.layer.borderWidth = 1
        t.layer.borderColor = UIColor.lightGray.cgColor
        t.textAlignment = .center
        t.constrainHeight(constant: 60)
        return t
    }()
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
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,orderSegmentedView,dateCenterTextField,subStack,bookButton)
        
        NSLayoutConstraint.activate([
            dateCenterTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateCenterTextField.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        
        
        
        orderSegmentedView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 46, bottom: 0, right: 32))
        dateCenterTextField.anchor(top: orderSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 32, left: 46, bottom: 0, right: 32))
        subStack.anchor(top: orderSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 46, bottom: 0, right: 32))
        bookButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
    @objc func tapDone(sender: Any, datePicker1: UIDatePicker) {
        if let datePicker = self.dateTextField.inputView as? UIDatePicker { // 2.1
            datePicker.datePickerMode = UIDatePicker.Mode.date
            let dateformatter = DateFormatter() // 2.2
            dateformatter.setLocalizedDateFormatFromTemplate("dd:MM:yyyy")// 2.3
            self.dateTextField.text = dateformatter.string(from: datePicker.date) //2.4
            //            self.handleTextContents?(dateTextField.text ?? "",true)
        }
        self.dateTextField.resignFirstResponder() // 2.5
    }
    
    @objc func tap2Done(sender: Any, datePicker1: UIDatePicker) {
        if let datePicker = self.dateCenterTextField.inputView as? UIDatePicker { // 2.1
            datePicker.datePickerMode = UIDatePicker.Mode.date
            let dateformatter = DateFormatter() // 2.2
            dateformatter.setLocalizedDateFormatFromTemplate("dd:MM:yyyy")// 2.3
            self.dateCenterTextField.text = dateformatter.string(from: datePicker.date) //2.4
            //            self.handleTextContents?(dateTextField.text ?? "",true)
        }
        self.dateCenterTextField.resignFirstResponder() // 2.5
    }
    
    
    @objc  func handleOpenOther(sender:UISegmentedControl)  {
       isActive = false
        if sender.selectedSegmentIndex == 0 {
            subStack.isHide(true)
            dateCenterTextField.isHide(false)
        }else {
            subStack.isHide(false)
            dateCenterTextField.isHide(true)
        }
    }
}


