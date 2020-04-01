//
//  VerificationVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class VerificationVC: CustomBaseViewVC {
    
    
    lazy var customVerificationView:CustomVerificationView = {
        let v = CustomVerificationView()
        [v.firstNumberTextField,v.secondNumberTextField,v.thirdNumberTextField,v.forthNumberTextField].forEach({$0.delegate = self})
        v.firstNumberTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.secondNumberTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.thirdNumberTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.forthNumberTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.resendButton.addTarget(self, action: #selector(handleResendCode), for: .touchUpInside)
        v.confirmButton.addTarget(self, action: #selector(handleConfirm), for: .touchUpInside)
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        
        return v
    }()
    var index:Int = 0
    
    fileprivate var timer = Timer()
    fileprivate var seconds = 30
    let sMSCodeViewModel = SMSCodeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimer()
        setupViewModelObserver()
    }
    
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
        sMSCodeViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            self.changeButtonState(enable: isValid, vv: self.customVerificationView.confirmButton)
        }
        sMSCodeViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                
            }else {
                //                SVProgressHUD.dismiss()
                //                self.activeViewsIfNoData()
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
    
    //TODO: -handle Methods
    
    @objc fileprivate func updateTimer() {
        if seconds == 0 {
            resetViews()
        }else {
            seconds -= 1
            
            upadteLabels()
        }
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
        sMSCodeViewModel.index = index
        guard let texts = text.text, !texts.isEmpty  else {self.changeButtonState(enable: false, vv: self.customVerificationView.confirmButton);  return  }
        
        if texts.utf16.count==1{
            switch text{
            case customVerificationView.firstNumberTextField:
                sMSCodeViewModel.smsCode = texts
                customVerificationView.secondNumberTextField.becomeFirstResponder()
            case customVerificationView.secondNumberTextField:
                sMSCodeViewModel.sms2Code = texts
                customVerificationView.thirdNumberTextField.becomeFirstResponder()
            case customVerificationView.thirdNumberTextField:
                sMSCodeViewModel.sms3Code = texts
                customVerificationView.forthNumberTextField.becomeFirstResponder()
            case customVerificationView.forthNumberTextField:
                sMSCodeViewModel.sms4Code = texts
                customVerificationView.forthNumberTextField.resignFirstResponder()
            default:
                break
            }
        }else{
            
        }
    }
    
    @objc func handleResendCode()  {
        setupTimer()
    }
    
    @objc  func handleConfirm()  {
        let  vc = index == 0 ? BaseSlidingVC() :   NewPassVC()
        navigationController?.pushViewController(vc, animated: true)
        
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


