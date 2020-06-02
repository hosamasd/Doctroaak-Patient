//
//  CustomMainPaymentView.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import TTSegmentedControl
import SkyFloatingLabelTextField

class CustomMainPaymentView: CustomBaseView {
    
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
    
    lazy var titleLabel = UILabel(text: "Payment".localized, font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Select the payment method".localized, font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var vodafoneImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Vodafone_Sim_Card"))
        i.contentMode = .scaleAspectFill
        //        i.isHide(true)
        i.constrainWidth(constant: 250)
        return i
    }()
    lazy var fawryImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Component 9 – 2"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 250)
        i.isHide(true)
        return i
    }()
    lazy var visaCardImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "tw-visa-gold-card-498x28"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 250)
        i.isHide(true)
        return i
    }()
    lazy var rightImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Rectangle 1724_22"))
        i.constrainWidth(constant: 8)
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var leftImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Rectangle 1724"))
        i.constrainWidth(constant: 8)
        i.contentMode = .scaleAspectFill
        i.alpha = 0
        return i
    }()
    
    lazy var chooseTitleLabel = UILabel(text: "You will pay 200 pounds for the/n subscription card".localized, font: .systemFont(ofSize: 16), textColor: .black,textAlignment: .center,numberOfLines: 2)
    lazy var bookSegmentedView:TTSegmentedControl = {
        let view = TTSegmentedControl()
        view.itemTitles = ["Vodafone cash".localized,"Fawry".localized,"Visa card".localized]
        view.allowChangeThumbWidth = false
        view.constrainHeight(constant: 50)
        view.thumbGradientColors = [#colorLiteral(red: 0.6887479424, green: 0.4929093719, blue: 0.9978651404, alpha: 1),#colorLiteral(red: 0.5526981354, green: 0.3201900423, blue: 1, alpha: 1)]
        view.useShadow = true
        view.didSelectItemWith = {[unowned self] (index, title) in
            self.paymentViewModel.firstChosen = index == 0 ? true : false
            self.paymentViewModel.secondChosen = index == 1 ? true : false
            self.paymentViewModel.thirdChosen = index == 2 ? true : false
            
            
            self.hideOrUnhide(tag: index)
            
        }
        return view
    }()
    lazy var choosePayLabel = UILabel(text: "Enter your phone number :".localized, font: .systemFont(ofSize: 18), textColor: .black,textAlignment: .center)
    
    lazy var numberTextField:UITextField = {
        let s = createMainTextFields(padding:100,place: "(324) 242-2457", type: .default,secre: true)
        let button = UIImageView(image: #imageLiteral(resourceName: "Group 4142-3"))
        button.frame = CGRect(x: CGFloat(s.frame.size.width - 80), y: CGFloat(0), width: CGFloat(80), height: CGFloat(50))
        s.leftView = button
        s.leftViewMode = .always
        return s
    }()
    lazy var codeTextField:UITextField = {
        let t = createMainTextFields(place: "65986")
        t.textAlignment = .center
        t.isHide(true)
        return t
    }()
    
    lazy var visaTextField:UITextField = {
        let t = createMainTextFields(place: "222 1257 6632 ***   ")
        t.textAlignment = .center
        t.constrainHeight(constant: 60)
        //           t.isHide(true)
        return t
    }()
    lazy var cvcVisaTextField:UITextField = {
        let t = createMainTextFields(place: "222 ")
        t.textAlignment = .center
        //              t.isHide(true)
        return t
    }()
    lazy var monthVisaTextField:SkyFloatingLabelTextField = {
        let t = SkyFloatingLabelTextField()
        t.placeholder = " 04/20 ".localized
        //           t.titleColor = .lightGray
        t.title = " Expiration Date".localized
        t.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
        
        //           t.placeholderColor = .lightGray
        t.lineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
        t.selectedLineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
        t.textAlignment = .center
        t.errorColor = UIColor.red
        //           t.constrainHeight(constant: 50)
        return t
    }()
    lazy var doneButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done".localized, for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    lazy var visaInfoStack:UIStackView = {
        let v = getStack(views: visaTextField,cvcVisaTextField,monthVisaTextField, spacing: 8, distribution: .fillEqually, axis: .vertical)
        v.isHide(true)
        return v
    }()
    
    let paymentViewModel = PaymentViewModel()
    
    
    
    override func setupViews() {
        [numberTextField,codeTextField,visaTextField].forEach({$0.constrainHeight(constant: 60)})
        [numberTextField,codeTextField,visaTextField,cvcVisaTextField,monthVisaTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)})
        
        
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,vodafoneImage,fawryImage,visaCardImage,doneButton,leftImage,rightImage,bookSegmentedView,chooseTitleLabel,choosePayLabel,codeTextField,numberTextField,visaInfoStack,doneButton)
        
        NSLayoutConstraint.activate([
            //            bookSegmentedView.centerXAnchor.constraint(equalTo: centerXAnchor),
            vodafoneImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            fawryImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            visaCardImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
        //
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        //        visaCardImage.anchor(top: soonLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 32, left: 0, bottom: 0, right: 0))
        vodafoneImage.anchor(top: soonLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        fawryImage.anchor(top: soonLabel.bottomAnchor, leading: nil, bottom: vodafoneImage.bottomAnchor, trailing: nil,padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        visaCardImage.anchor(top: soonLabel.bottomAnchor, leading: nil, bottom: vodafoneImage.bottomAnchor, trailing: nil,padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        
        
        leftImage.anchor(top: soonLabel.bottomAnchor, leading: nil, bottom: vodafoneImage.bottomAnchor, trailing: vodafoneImage.leadingAnchor,padding: .init(top: 32, left: 0, bottom: 0, right: -8))
        rightImage.anchor(top: soonLabel.bottomAnchor, leading: vodafoneImage.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 32, left: -8, bottom: 0, right: 0))
        bookSegmentedView.anchor(top: vodafoneImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        chooseTitleLabel.anchor(top: bookSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        choosePayLabel.anchor(top: chooseTitleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        numberTextField.anchor(top: choosePayLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        codeTextField.anchor(top: choosePayLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        visaInfoStack.anchor(top: choosePayLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        doneButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
    
    func createButtons(image:UIImage,tags:Int) -> UIButton {
        let b = UIButton()
        b.setImage(image, for: .normal)
        b.tag = tags
        return b
    }
    
    func hideOrUnhide(tag:Int)  {
        rightImage.image = tag == 0 ? #imageLiteral(resourceName: "Rectangle 1724_22") : #imageLiteral(resourceName: "Rectangle 1724-1")
        leftImage.image = tag == 2 ? #imageLiteral(resourceName: "Rectangle 1724_22") : #imageLiteral(resourceName: "Rectangle 1724")
        
        choosePayLabel.text = tag == 0 ? "Enter your phone number :".localized : tag == 1 ? "Eneter the code :".localized : "Visa number :".localized
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.rightImage.alpha = tag == 0 ? 1 :  tag == 1 ?  1 : 0
            self.leftImage.alpha = tag == 0 ? 0 : 1
            
            self.vodafoneImage.isHide(tag == 0 ? false : true)
            self.fawryImage.isHide(tag == 1 ? false : true)
            self.visaCardImage.isHide(tag == 2 ? false : true)
            self.numberTextField.isHide(tag == 0 ? false : true)
            self.codeTextField.isHide(tag == 1 ? false : true)
            self.visaInfoStack.isHide(tag == 2 ? false : true)
            
            
        })
    }
    
    
    //TODO: -handle methods
    
    @objc func tapDone(sender: Any, datePicker1: UIDatePicker) {
        if let datePicker = self.monthVisaTextField.inputView as? UIDatePicker { // 2.1
            let dateformatter = DateFormatter() // 2.2
            dateformatter.dateFormat = "MM/YY"
            self.monthVisaTextField.text = dateformatter.string(from: datePicker.date) //2.4
            paymentViewModel.visaMonthCard = dateformatter.string(from: datePicker.date) //2.4
        }
        self.monthVisaTextField.resignFirstResponder() // 2.5
        
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == numberTextField {
                if  !texts.isValidPhoneNumber    {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    paymentViewModel.vodafoneVode = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    paymentViewModel.vodafoneVode = texts
                }
                
            }else if text == visaTextField {
                if  texts.count < 8    {
                    floatingLabelTextField.errorMessage = "Invalid   visa number".localized
                    paymentViewModel.visaCard = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    paymentViewModel.visaCard = texts
                }
                
            }else if text == cvcVisaTextField {
                if texts.count < 3 {
                    floatingLabelTextField.errorMessage = "Invalid CVC  visa number".localized
                    paymentViewModel.visaCVCCard = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    paymentViewModel.visaCVCCard = texts
                }
                
                
                
            } else
                if(texts.count < 6 ) {
                    floatingLabelTextField.errorMessage = "code must have 6 character".localized
                    paymentViewModel.fawryCode = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    paymentViewModel.fawryCode = texts
                    
            }
        }
    }
    
    
    @objc func handleChoosedButton(sender:UIButton)  {
        
        sender.setImage( #imageLiteral(resourceName: "Ellipse 128"), for: .normal)
        switch sender.tag {
        case 1:
            hideOrUnhide(tag: 1)
        default:
            hideOrUnhide(tag: 2)
        }
        [codeTextField,numberTextField].forEach({$0.text = ""})
        paymentViewModel.fawryCode = nil
        paymentViewModel.vodafoneVode = nil
    }
}
