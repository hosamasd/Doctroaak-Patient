//
//  MainPaymentVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class MainPaymentVC: CustomBaseViewVC {
    
    lazy var customClinicPaymentView:CustomMainPaymentView = {
        let v = CustomMainPaymentView()
        v.index = index
        v.doneButton.addTarget(self, action: #selector(handleDonePayment), for: .touchUpInside)
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        return v
    }()
    
    //check to go specific way
    fileprivate let index:Int!
      init(indexx:Int) {
          self.index = indexx
          super.init(nibName: nil, bundle: nil)
      }
    
   
//    let paymentViewModel = PaymentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        customClinicPaymentView.paymentViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customClinicPaymentView.doneButton)
        }
        
        customClinicPaymentView.paymentViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
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
        view.addSubview(customClinicPaymentView)
        customClinicPaymentView.fillSuperview()
        
    }
    
    @objc func handleDonePayment()  {
        print(999)
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
