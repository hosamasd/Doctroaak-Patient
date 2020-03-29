//
//  RegisterVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import SkyFloatingLabelTextField
import UIMultiPicker


class RegisterVC: CustomBaseViewVC {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1200)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    
    lazy var customRegisterView:CustomRegisterView = {
        let v = CustomRegisterView()
        v.insuranceDrop.options = insuracneArray
        v.boyButton.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
        v.girlButton.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
        v.insuranceDrop.addTarget(self, action: #selector(handleHidePicker), for: .valueChanged)
        v.mobileNumberTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.emailTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.fullNameTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.addressTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.insuranceCodeTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.userEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenGallery)))
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.signUpButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        v.birthdayTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
        v.mainDrop3View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenCloseInsurance)))
        v.acceptButton.addTarget(self, action: #selector(handleAgree), for: .touchUpInside)
        //        v.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        return v
    }()
    
    //check to go specific way
    var index:Int = 0
    var iiii = ""
    var de = ""
    var insuracneArray = ["one","two","three","sdfdsfsd"]
    let registerViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        registerViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customRegisterView.signUpButton)
        }
        
        registerViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                
            }else {
                //                SVProgressHUD.dismiss()
                //                self.activeViewsIfNoData()
            }
        })
    }
    
    override func setupViews() {
        
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customRegisterView)
        customRegisterView.fillSuperview()
    }
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    fileprivate func changeBoyGirlState(_ sender: UIButton,secondBtn:UIButton,isMale:Bool) {
        if sender.backgroundColor == nil {
            registerViewModel.isMale = isMale;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: secondBtn)
        registerViewModel.isMale = isMale
    }
    
    //TODO: -handle methods
    
    @objc func textFieldDidChange(text: UITextField)  {
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == customRegisterView.mobileNumberTextField {
                if  !texts.isValidPhoneNumber    {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    registerViewModel.phone = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    registerViewModel.phone = texts
                }
                
            }else if text == customRegisterView.emailTextField {
                if  !texts.isValidEmail    {
                    floatingLabelTextField.errorMessage = "Invalid   Email".localized
                    registerViewModel.email = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    registerViewModel.email = texts
                }
                
            }else   if text == customRegisterView.confirmPasswordTextField {
                if text.text != customRegisterView.passwordTextField.text {
                    floatingLabelTextField.errorMessage = "Passowrd should be same".localized
                    registerViewModel.confirmPassword = nil
                }
                else {
                    registerViewModel.confirmPassword = texts
                    floatingLabelTextField.errorMessage = ""
                }
            }else  if text == customRegisterView.passwordTextField {
                if(texts.count < 8 ) {
                    floatingLabelTextField.errorMessage = "password must have 8 character".localized
                    registerViewModel.password = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    registerViewModel.password = texts
                }
            }else  if text == customRegisterView.addressTextField {
                if (texts.count < 3 ) {
                    floatingLabelTextField.errorMessage = "Invalid Address".localized
                    registerViewModel.address = nil
                }
                else {
                    
                    registerViewModel.address = texts
                    floatingLabelTextField.errorMessage = ""
                }
                
            }else if text == customRegisterView.fullNameTextField {
                if (texts.count < 3 ) {
                    floatingLabelTextField.errorMessage = "Invalid name".localized
                    registerViewModel.name = nil
                }
                else {
                    
                    registerViewModel.name = texts
                    floatingLabelTextField.errorMessage = ""
                }
                
            }else  {
                if (texts.count < 5 ) {
                    floatingLabelTextField.errorMessage = "Invalid Code".localized
                    registerViewModel.insuranceCode = nil
                }
                else {
                    
                    registerViewModel.insuranceCode = texts
                    floatingLabelTextField.errorMessage = ""
                }
                
            }
        }
    }
    
    @objc func handleOpenGallery()  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc  func handleNext()  {
        let verify = VerificationVC()
        navigationController?.pushViewController(verify, animated: true)
    }
    
    @objc func tapDone(sender: Any, datePicker1: UIDatePicker) {
        if let datePicker = self.customRegisterView.birthdayTextField.inputView as? UIDatePicker { // 2.1
            let dateformatter = DateFormatter() // 2.2
            dateformatter.dateStyle = .medium // 2.3
            self.customRegisterView.birthdayTextField.text = dateformatter.string(from: datePicker.date) //2.4
            registerViewModel.birthday = dateformatter.string(from: datePicker.date) //2.4
        }
        self.customRegisterView.birthdayTextField.resignFirstResponder() // 2.5
        
    }
    
    
    
    @objc func handleHidePicker(sender:UIMultiPicker)  {
        sender.selectedIndexes.forEach { (i) in
            
            de += insuracneArray[i] + ","
        }
        iiii = de
        customRegisterView.insuracneText.text = iiii
        registerViewModel.insurance = iiii
        de = ""
    }
    
    @objc func handleOpenCloseInsurance()  {
        customRegisterView.insuranceDrop.isHidden = !customRegisterView.insuranceDrop.isHidden
    }
    
    @objc func handleAgree(sender:UIButton)  {
        
        registerViewModel.isAccept = !registerViewModel.isAccept!
        sender.isSelected = !sender.isSelected
    }
    
    
    
    @objc func handleGirl(sender:UIButton)  {
        changeBoyGirlState(sender,secondBtn: customRegisterView.boyButton,isMale: false)
    }
    
    @objc func handleBoy(sender:UIButton)  {
        changeBoyGirlState(sender, secondBtn: customRegisterView.girlButton, isMale: true)
    }
    
}



//MARK:-Extension

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            registerViewModel.image = img
            customRegisterView.userProfileImage.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            registerViewModel.image = img
            customRegisterView.userProfileImage.image = img
        }
        
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        registerViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}
