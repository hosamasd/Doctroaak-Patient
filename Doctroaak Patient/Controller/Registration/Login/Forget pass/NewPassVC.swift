//
//  NewPassVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import MOLH
import SVProgressHUD

class NewPassVC: CustomBaseViewVC {
    
    lazy var customNewPassView:CustomNewPassView = {
        let v = CustomNewPassView()
        v.phone=phone
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        
        v.doneButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return v
    }()
    
    fileprivate let phone:String!
    init(phone:String) {
        self.phone=phone
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        customNewPassView.newPassViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customNewPassView.doneButton)
        }
        
        customNewPassView.newPassViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                SVProgressHUD.show(withStatus: "Saving password...".localized)
                
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
        view.addSubview(customNewPassView)
        customNewPassView.fillSuperview()
        
    }
    
    func goToNext()  {
           let login = LoginVC()
        login.isFromNewPass = true
                  navigationController?.pushViewController(login, animated: true)
       }
    
    //TODO: -handle methods
    
    
    
    @objc func handleNext()  {
        customNewPassView.newPassViewModel.performLogging { (base, err) in
            
        if let err = err {
                       SVProgressHUD.showError(withStatus: err.localizedDescription)
                       self.activeViewsIfNoData();return
                   }
                   SVProgressHUD.dismiss()
                   self.activeViewsIfNoData()
                   guard let user = base else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}

            if user.messageEn == "Information Update   " {
            DispatchQueue.main.async {
                self.showToast(context: self, msg: MOLHLanguage.isRTLLanguage() ? base?.message ?? "" : base?.messageEn ?? "")

                self.goToNext()
            }
            }else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn);return}
        
        }
        
        
       
        
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
}
