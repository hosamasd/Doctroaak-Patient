//
//  ForgetPasswordVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

class ForgetPasswordVC:   CustomBaseViewVC {
    
    lazy var customMainAlertVC:CustomMainAlertVC = {
           let t = CustomMainAlertVC()
           t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
           t.modalTransitionStyle = .crossDissolve
           t.modalPresentationStyle = .overCurrentContext
           return t
       }()
    lazy var customAlertLoginView:CustomAlertLoginView = {
           let v = CustomAlertLoginView()
        v.setupAnimation(name: "4970-unapproved-cross")
        v.handleOkTap = {[unowned self] in
            self.handleremoveLoginAlert()
        }
           return v
       }()
    lazy var customForgetPassView:CustomForgetPassView = {
        let v = CustomForgetPassView()
        v.nextButton.addTarget(self, action: #selector(handleDonePayment), for: .touchUpInside)
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    
    //MARK:-User methods
    
    func che()  {
        RegistrationServices.shared.MainForgetPassword(phone: "99999999992") { (base, err) in
            
        }
    }
    
    func setupViewModelObserver()  {
        customForgetPassView.forgetPassViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customForgetPassView.nextButton)
        }
        
        customForgetPassView.forgetPassViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                                SVProgressHUD.show(withStatus: "Resending password...".localized)
                
            }else {
                                SVProgressHUD.dismiss()
                                self.activeViewsIfNoData()
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
    
     func handleremoveLoginAlert()  {
          
          removeViewWithAnimation(vvv: customAlertLoginView)
          customMainAlertVC.dismiss(animated: true)
      }
    
    @objc func handleDismiss()  {
              dismiss(animated: true, completion: nil)
          }
    //TODO: -handle methods
    
  
    
    @objc func handleDonePayment()  {
        let verifiy = NewPassVC()
        navigationController?.pushViewController(verifiy, animated: true)
        
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
}

