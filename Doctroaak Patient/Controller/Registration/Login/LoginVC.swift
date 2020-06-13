//
//  LoginVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import SVProgressHUD
import MOLH
import UIKit

protocol LoginVCPrototcol {
    //    func useApiAndPatienId(api:String,patient:Int)
    func useApiAndPatienId(patient:PatienModel)
    
}


class LoginVC: CustomBaseViewVC {
    
    lazy var customLoginsView:CustomLoginsView = {
        let v = CustomLoginsView()
        v.createAccountButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        v.forgetPasswordButton.addTarget(self, action: #selector(handleForget), for: .touchUpInside)
        v.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        
        return v
    }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    
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
            self.handleDismiss()
        }
        return v
    }()
    
    var isFromNewPass:Bool = false
    
    var delgate:LoginVCPrototcol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginViewModelObserver()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        super.viewWillAppear(animated)
        
        if userDefaults.bool(forKey: UserDefaultsConstants.isRegisterDoneAfterBooking) {
            dismiss(animated: true)
            userDefaults.set(false, forKey: UserDefaultsConstants.isRegisterDoneAfterBooking)
            userDefaults.synchronize()
        }else {}
    }
    
    //MARK:-User methods
    
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubview(customLoginsView)
        customLoginsView.fillSuperview()
    }
    
    fileprivate func setupLoginViewModelObserver(){
        
        customLoginsView.loginViewModel.bindableIsFormValidate.bind {[unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customLoginsView.loginButton)
        }
        customLoginsView.loginViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                self.showMainAlertLooder()
            }else {
                //                SVProgressHUD.dismiss()
                self.handleDismiss()
                
                self.activeViewsIfNoData()
            }
        })
    }
    
    
    fileprivate func saveToken(use:PatienModel)  {
        
        userDefaults.set(true, forKey: UserDefaultsConstants.isPatientLogin)
        userDefaults.set(use.id, forKey: UserDefaultsConstants.patientID)
        userDefaults.set(use.apiToken, forKey: UserDefaultsConstants.patientAPITOKEN)
        
        userDefaults.set(use.phone, forKey: UserDefaultsConstants.patienMobileNumber)
        userDefaults.set(use.name, forKey: UserDefaultsConstants.patientName)
        userDefaults.set(use.url, forKey: UserDefaultsConstants.patientPhotoUrl)
        userDefaults.synchronize()
        
        cachePatient(use)
        dismiss(animated: true) {[unowned self] in
            //            self.delgate?.useApiAndPatienId(api: use.apiToken, patient: use.id)
            self.delgate?.useApiAndPatienId(patient: use)
        }
    }
    
    fileprivate  func cachePatient(_ patient:PatienModel)  {
        cacheObjectCodabe.save(patient)
        print(cacheObjectCodabe.storedValue)
    }
    
    fileprivate func showMainAlertLooder()  {
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingView, height: 200)
        customAlertMainLoodingView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
    }
    
    //TODO: -handle methods

    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @objc  func handleRegister()  {
        isFromNewPass = false
        let register = RegisterVC()
        navigationController?.pushViewController(register, animated: true)
        
    }
    
    @objc  func handleLogin()  {
        isFromNewPass = false
        
        customLoginsView.loginViewModel.performLogging { (base, err) in
            
            if let err = err {
                //                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                
                self.activeViewsIfNoData();return
            }
            //            SVProgressHUD.dismiss()
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.saveToken(use: user)
            }
            
        }
    }
    
    @objc func handleForget()  {
        isFromNewPass = false
        
        let forget = ForgetPasswordVC()
        navigationController?.pushViewController(forget, animated: true)
    }
    
    @objc func handleBack()  {
        if isFromNewPass {
            navigationController?.popViewController(animated: true)
        }else{
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
}
