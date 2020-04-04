//
//  LAPBookVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LAPBookVC: CustomBaseViewVC {
    
    
    lazy var customLAPBookView:CustomLAPBookView = {
        let v = CustomLAPBookView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.index = index
//        v.boyButton.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
//        v.girlButton.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
//        v.mobileNumberTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
//        v.fullNameTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
//        
//        v.dateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
//        v.dateCenterTextField.setInputViewDatePicker(target: self, selector: #selector(tap2Done)) //1
//        v.dayTextField.setInputViewDatePicker(target: self, selector: #selector(tapAllDone)) //1
//        v.monthTextField.setInputViewDatePicker(target: self, selector: #selector(tap4Done(sender:))) //1
//        v.yearTextField.setInputViewDatePicker(target: self, selector: #selector(tap3Done(sender:))) //1
//        v.orderSegmentedView.addTarget(self, action: #selector(handleOpenOther), for: .valueChanged)
        return v
    }()
    
    fileprivate let index:Int!
    init(index:Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    let lapBookViewModel = LAPBookViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        
        customLAPBookView.lapBookViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
                  guard let isValid = isValidForm else {return}
                  //            self.customLoginView.loginButton.isEnabled = isValid
                  
                  self.changeButtonState(enable: isValid, vv: self.customLAPBookView.bookButton)
              }
              
        customLAPBookView.lapBookViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isValid) in
                  if isValid == true {
                      //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                      //                SVProgressHUD.show(withStatus: "Login...".localized)
                      
                  }else {
                      //                SVProgressHUD.dismiss()
                      //                self.activeViewsIfNoData()
                  }
              })
        
//        lapBookViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
//            guard let isValid = isValidForm else {return}
//            //            self.customLoginView.loginButton.isEnabled = isValid
//
//            self.changeButtonState(enable: isValid, vv: self.customLAPBookView.bookButton)
//        }
//
//        lapBookViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isValid) in
//            if isValid == true {
//                //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
//                //                SVProgressHUD.show(withStatus: "Login...".localized)
//
//            }else {
//                //                SVProgressHUD.dismiss()
//                //                self.activeViewsIfNoData()
//            }
//        })
    }
    
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubViews(views: customLAPBookView)
        customLAPBookView.fillSuperview()
    }
    
//    fileprivate func changeBoyGirlState(_ sender: UIButton,secondBtn:UIButton,isMale:Bool) {
//        if sender.backgroundColor == nil {
//            lapBookViewModel.isMale = isMale;return
//        }else {
//            addGradientInSenderAndRemoveOther(sender: sender, vv: secondBtn)
//            lapBookViewModel.isMale = isMale
//        }
//    }
//    
//   fileprivate func putTextInTextFieldsAllDate(tf:UITextField,dp:UIDatePicker)  {
//        dp.datePickerMode = UIDatePicker.Mode.date
//        let dateMainformatter = DateFormatter() // 2.2
//        let dateformatter = DateFormatter() // 2.2
//        let date2formatter = DateFormatter() // 2.2
//        let date3formatter = DateFormatter() // 2.2
//        
//        
//        dateMainformatter.setLocalizedDateFormatFromTemplate("dd:MM:YYYY")
//        dateformatter.setLocalizedDateFormatFromTemplate("dd")
//        date2formatter.setLocalizedDateFormatFromTemplate("MM")
//        
//        date3formatter.setLocalizedDateFormatFromTemplate("YYYY")
//        customLAPBookView.dayTextField.text = dateformatter.string(from: dp.date)
//        customLAPBookView.monthTextField.text = date2formatter.string(from: dp.date)
//        customLAPBookView.yearTextField.text = date3formatter.string(from: dp.date)
//        
//        //         tf.text = dateformatter.string(from: dp.date) //2.4
//        lapBookViewModel.birthday = dateMainformatter.string(from: dp.date)
//        tf.resignFirstResponder() // 2.5
//    }
//    
//   fileprivate func putTextInTextFields(tf:UITextField,dp:UIDatePicker,isOnly:Bool)  {
//        dp.datePickerMode = UIDatePicker.Mode.date
//        let dateformatter = DateFormatter() // 2.2
//        dateformatter.setLocalizedDateFormatFromTemplate("dd:MM:yyyy")// 2.3
//        tf.text = dateformatter.string(from: dp.date) //2.4
//        if isOnly {
//            lapBookViewModel.dates = dateformatter.string(from: dp.date)
//        }else {
//            lapBookViewModel.secondDates  = dateformatter.string(from: dp.date)
//        }
//        lapBookViewModel.index = index
//        tf.resignFirstResponder() // 2.5
//    }
    
    //TODO: -handle methods
    
//    @objc  func handleOpenOther(sender:UISegmentedControl)  {
//        
//        customLAPBookView.isActive = false
//        if sender.selectedSegmentIndex == 0 {
//            customLAPBookView.subStack.isHide(true)
//            customLAPBookView.dateCenterTextField.isHide(false)
//            lapBookViewModel.secondDates = nil
//            [customLAPBookView.fullNameTextField,customLAPBookView.monthTextField,customLAPBookView.mobileNumberTextField,customLAPBookView.dayTextField,customLAPBookView.yearTextField,customLAPBookView.dateCenterTextField].forEach({$0.text = ""})
//        }else {
//            customLAPBookView.subStack.isHide(false)
//            customLAPBookView.dateCenterTextField.isHide(true)
//            customLAPBookView.dateCenterTextField.text = ""
//            lapBookViewModel.dates = nil
//        }
//    }
    
//    @objc func textFieldDidChange(text: UITextField)  {
//        lapBookViewModel.index = index
//        guard let texts = text.text else { return  }
//        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
//            if text == customLAPBookView.fullNameTextField {
//                if  texts.count < 3    {
//                    floatingLabelTextField.errorMessage = "Invalid   Name".localized
//                    lapBookViewModel.fullName = nil
//                }
//                else {
//                    floatingLabelTextField.errorMessage = ""
//                    lapBookViewModel.fullName = texts
//                }
//            }else {
//                if  !texts.isValidPhoneNumber    {
//                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
//                    lapBookViewModel.mobileNumber = nil
//                }
//                else {
//                    floatingLabelTextField.errorMessage = ""
//                    lapBookViewModel.mobileNumber = texts
//                }
//            }
//        }
//    }
//    @objc func handleGirl(sender:UIButton)  {
//        changeBoyGirlState(sender,secondBtn: customLAPBookView.boyButton,isMale: false)
//    }
//
//    @objc func handleBoy(sender:UIButton)  {
//        changeBoyGirlState(sender, secondBtn: customLAPBookView.girlButton, isMale: true)
//    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    
    
//    @objc func tapDone(sender: UITextField) {
//
//        if let datePicker = customLAPBookView.dateTextField.inputView as? UIDatePicker { // 2.1
//            putTextInTextFields(tf: customLAPBookView.dateTextField, dp: datePicker, isOnly: false)
//        }
//
//    }
//
//    @objc func tap2Done(sender: Any ) {
//        if let datePicker = customLAPBookView.dateCenterTextField.inputView as? UIDatePicker { // 2.1
//            putTextInTextFields(tf: customLAPBookView.dateCenterTextField, dp: datePicker, isOnly: true)
//        }
//    }
//
//    @objc func tap3Done(sender: Any) {
//        if let datePicker = customLAPBookView.yearTextField.inputView as? UIDatePicker { // 2.1
//
//            putTextInTextFieldsAllDate( tf: customLAPBookView.yearTextField, dp: datePicker)
//        }
//    }
//
//    @objc func tap4Done(sender: Any ) {
//        if let datePicker = customLAPBookView.monthTextField.inputView as? UIDatePicker { // 2.1
//            putTextInTextFieldsAllDate( tf: customLAPBookView.monthTextField, dp: datePicker)
//        }
//    }
//
//    @objc func tapAllDone(sender: UITextField) {
//        if let datePicker = customLAPBookView.dayTextField.inputView as? UIDatePicker {
//            putTextInTextFieldsAllDate( tf: customLAPBookView.dayTextField, dp: datePicker)
//        }
//
//    }
    
}
