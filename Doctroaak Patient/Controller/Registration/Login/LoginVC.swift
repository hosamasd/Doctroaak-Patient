//
//  LoginVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import SkyFloatingLabelTextField

class LoginVC: CustomBaseViewVC {
    
    lazy var customLoginsView:CustomLoginsView = {
        let v = CustomLoginsView()
        v.phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.createAccountButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        v.forgetPasswordButton.addTarget(self, action: #selector(handleForget), for: .touchUpInside)
        v.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        
        return v
    }()
    
   
    
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginViewModelObserver()
    }
    
    //MARK:-User methods
    
    fileprivate func setupLoginViewModelObserver(){
        
        loginViewModel.bindableIsFormValidate.bind {[unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customLoginsView.loginButton)
        }
        loginViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                
            }else {
                //                SVProgressHUD.dismiss()
                //                self.activeViewsIfNoData()
            }
        })
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubview(customLoginsView)
        customLoginsView.fillSuperview()
    }
    
    //TODO: -handle methods
    
    @objc func textFieldDidChange(text: UITextField)  {
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == customLoginsView.phoneNumberTextField {
                if  !texts.isValidPhoneNumber    {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    loginViewModel.phone = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    loginViewModel.phone = texts
                }
                
            }else
                if(texts.count < 8 ) {
                    floatingLabelTextField.errorMessage = "password must have 8 character".localized
                    loginViewModel.password = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    loginViewModel.password = texts
                    
            }
        }
    }
    
    @objc  func handleRegister()  {
        let register = RegisterVC()
        navigationController?.pushViewController(register, animated: true)
        
    }
    
    @objc  func handleLogin()  {
        print("login")
    }
    
    @objc func handleForget()  {
        let forget = ForgetPasswordVC()
        navigationController?.pushViewController(forget, animated: true)
    }
    
    @objc func handleBack()  {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
