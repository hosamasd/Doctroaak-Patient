//
//  VerificationVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

class VerificationVC: CustomBaseViewVC {
    
    
    lazy var customVerificationView:CustomVerificationView = {
        let v = CustomVerificationView()
        v.user_id = user_id
        [v.firstNumberTextField,v.secondNumberTextField,v.thirdNumberTextField,v.forthNumberTextField].forEach({$0.delegate = self})
        
        v.resendButton.addTarget(self, action: #selector(handleResendCode), for: .touchUpInside)
        v.confirmButton.addTarget(self, action: #selector(handleConfirm), for: .touchUpInside)
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        
        return v
    }()
    
    fileprivate var timer = Timer()
    fileprivate var seconds = 30
    
    fileprivate let  isFromForget:Bool!
    fileprivate let user_id:Int!
    init(user_id:Int,isFromForget:Bool) {
        self.user_id = user_id
        self.isFromForget=isFromForget
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimer()
        setupViewModelObserver()
    }
    
    //    func check()  {
    //        RegistrationServices.shared.MainResendSmsCodeAgain(user_id: 47) { (base, err) in
    //
    //        }
    //    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customVerificationView.firstNumberTextField.becomeFirstResponder()
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubview(customVerificationView)
        customVerificationView.fillSuperview()
    }
    
    func setupViewModelObserver()  {
        customVerificationView.sMSCodeViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            self.changeButtonState(enable: isValid, vv: self.customVerificationView.confirmButton)
        }
        customVerificationView.sMSCodeViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                SVProgressHUD.show(withStatus: "Login...".localized)
                
            }else {
                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
            }
        })
    }
    
    func setupTimer()  {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    fileprivate func upadteLabels() {
        DispatchQueue.main.async {
            self.customVerificationView.timerLabel.textColor = #colorLiteral(red: 0.5667257905, green: 0.9375677705, blue: 0.8425782323, alpha: 1)
            self.customVerificationView.timerLabel.text = self.timeString(time: TimeInterval(self.seconds))
            self.customVerificationView.resendButton.setTitleColor(#colorLiteral(red: 0.7814221978, green: 0.7986494303, blue: 0.843649447, alpha: 1), for: .normal)
            self.customVerificationView.resendButton.isEnabled = false
        }
        
    }
    
    fileprivate func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i",  minutes, seconds)
    }
    
    func resetViews()  {
        timer.invalidate()
        seconds = 30
        self.customVerificationView.timerLabel.text = "00:00"
        self.customVerificationView.timerLabel.textColor = #colorLiteral(red: 0.7814221978, green: 0.7986494303, blue: 0.843649447, alpha: 1)
        self.customVerificationView.resendButton.setTitleColor(#colorLiteral(red: 0.6663027406, green: 0.8534387946, blue: 0.9110504985, alpha: 1), for: .normal)
        self.customVerificationView.resendButton.isEnabled = true
    }
    
    func resetViewModel()  {
        customVerificationView.sMSCodeViewModel.smsCode = nil
        customVerificationView.sMSCodeViewModel.sms2Code = nil
        customVerificationView.sMSCodeViewModel.sms3Code = nil
        customVerificationView.sMSCodeViewModel.sms4Code = nil
        [customVerificationView.firstNumberTextField,customVerificationView.secondNumberTextField,customVerificationView.thirdNumberTextField,customVerificationView.forthNumberTextField,customVerificationView.fifthNumberTextField].forEach({$0.text = ""})
    }
    
    func updateStates(user:PatienModel)  {
        userDefaults.set(true, forKey: UserDefaultsConstants.isRegisterDoneAfterBooking)
        userDefaults.set(true, forKey: UserDefaultsConstants.isPatientLogin)
        
        userDefaults.set(user.apiToken, forKey: UserDefaultsConstants.patientAPITOKEN)
        userDefaults.set(user.id, forKey: UserDefaultsConstants.patientUserID)
        userDefaults.set(user.name, forKey: UserDefaultsConstants.patientName)
        userDefaults.set(user.url, forKey: UserDefaultsConstants.patientPhotoUrl)

        userDefaults.synchronize()
        cacheObjectCodabe.save(user)

    }
    
    func goToNext(user:PatienModel)  {
        self.updateStates(user:user)
//        navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    
    //TODO: -handle Methods
    
    @objc fileprivate func updateTimer() {
        if seconds == 0 {
            resetViews()
        }else {
            seconds -= 1
            
            upadteLabels()
        }
    }
    
    @objc func handleResendCode()  {
        setupTimer()
        resetViewModel()
        customVerificationView.sMSCodeViewModel.performResendSMSCode { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            SVProgressHUD.showSuccess(withStatus: "SMS Code is sent again....".localized)
            self.activeViewsIfNoData()
        }    }
    
    @objc  func handleConfirm()  {
        
        customVerificationView.sMSCodeViewModel.performLogging { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn);self.setupTimer(); return}
            
            DispatchQueue.main.async {
                self.goToNext(user:user)
            }
        }      
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension VerificationVC: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 1
    }
}


