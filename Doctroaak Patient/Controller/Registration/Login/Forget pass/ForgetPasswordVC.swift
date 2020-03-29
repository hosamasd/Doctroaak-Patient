//
//  ForgetPasswordVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ForgetPasswordVC:   CustomBaseViewVC {
    
    
    
    lazy var customForgetPassView:CustomForgetPassView = {
        let v = CustomForgetPassView()
        v.numberTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.nextButton.addTarget(self, action: #selector(handleDonePayment), for: .touchUpInside)
        return v
    }()

    let forgetPassViewModel = ForgetPassViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        forgetPassViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customForgetPassView.nextButton)
        }
        
        forgetPassViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
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
        view.addSubview(customForgetPassView)
        customForgetPassView.fillSuperview()
        
    }
    
    //TODO: -handle methods
    
    @objc func textFieldDidChange(text: UITextField)  {
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if  !texts.isValidPhoneNumber    {
                floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                forgetPassViewModel.phone = nil
            }
            else {
                floatingLabelTextField.errorMessage = ""
                forgetPassViewModel.phone = texts
            }
            
            
        }
    }
    
    @objc func handleDonePayment()  {
        let verifiy = VerificationVC()
        verifiy.isFromForgetPassw = true
        navigationController?.pushViewController(verifiy, animated: true)
        
        print(999)
    }
}

