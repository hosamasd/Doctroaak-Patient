//
//  NewPassVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import SkyFloatingLabelTextField

class NewPassVC: CustomBaseViewVC {
    
    lazy var customNewPassView:CustomNewPassView = {
        let v = CustomNewPassView()
        v.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        
        v.doneButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return v
    }()
    
    var index:Int = 0
    
    let newPassViewModel = NewPassViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        newPassViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customNewPassView.doneButton)
        }
        
        newPassViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                
            }else {
                //                SVProgressHUD.dismiss()
                //                self.activeViewsIfNoData()
            }
        })
    }
    
    override  func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.addSubview(customNewPassView)
        customNewPassView.fillSuperview()
        
    }
    
    //TODO: -handle methods
    
    @objc func textFieldDidChange(text: UITextField)  {
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == customNewPassView.confirmPasswordTextField {
                if text.text != customNewPassView.passwordTextField.text {
                    floatingLabelTextField.errorMessage = "Passowrd should be same".localized
                    newPassViewModel.confirmPassword = nil
                }
                else {
                    newPassViewModel.confirmPassword = texts
                    floatingLabelTextField.errorMessage = ""
                }
            }else
            {
                if(texts.count < 8 ) {
                    floatingLabelTextField.errorMessage = "password must have 8 character".localized
                    newPassViewModel.password = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    newPassViewModel.password = texts
                }
            }
            
            
        }
    }
    
    @objc func handleNext()  {
        let login = LoginVC()
        navigationController?.pushViewController(login, animated: true)
        
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
}
