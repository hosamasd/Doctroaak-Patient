//
//  MainPaymentVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import SVProgressHUD
import AcceptSDK
import MOLH

let paymentAPIKey = "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnVZVzFsSWpvaU1UVTVNVFV6TXpJM01pNDFPVFl6T0RFaUxDSmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRJMk5UVjkuMV9zVEdtZEp3a0l0ZTlWVE1SYnpmUTNETGw1emVTNUdSV0Vxa0E4SWZQdTJsdzlHWjZqcmlUQVdLYzlIYkZFZDRMcjd5ajBTQVNpdnpuT29ZX1pQemc="

class MainPaymentVC: CustomBaseViewVC {
    
    
    
    
    
    
    lazy var customMainPaymentView:CustomMainPaymentView = {
        let v = CustomMainPaymentView()
        v.doneButton.addTarget(self, action: #selector(handleDonePayment), for: .touchUpInside)
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.paymentButton.addTarget(self, action: #selector(handlePayment), for: .touchUpInside)
        return v
    }()
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 900)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    
    let accept = AcceptSDK()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        //        doThis()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        customMainPaymentView.paymentViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customMainPaymentView.doneButton)
        }
        
        customMainPaymentView.paymentViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
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
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubview(customMainPaymentView)
        customMainPaymentView.fillSuperview()
        
    }
    
    func doThis()  {
        let isEnglish = MOLHLanguage.isRTLLanguage() ? false : true
        
        let bData = [  "apartment": "NA",
                       "email": "dr_hamdimahmoud@yahoo.com",
                       "floor": "NA",
                       "first_name": "hamdi",
                       "street": "asd",
                       "building": "asd",
                       "phone_number": "01001384592",
                       "shipping_method": "visa",
                       "postal_code": "123456",
                       "city": "cairo",
                       "country": "egypt",
                       "last_name": "mahmoud",
                       "state": "cairo"
        ]
        
        do {
            
            try accept.presentPayVC(vC: self, billingData: bData, paymentKey: paymentAPIKey, saveCardDefault:
                true, showSaveCard: true, showAlerts: true,isEnglish: isEnglish)
            
            customMainPaymentView.paymentViewModel.isPaymentOperationDone = true
        } catch AcceptSDKError.MissingArgumentError(let errorMessage) {
            
            print(errorMessage)
            customMainPaymentView.paymentViewModel.isPaymentOperationDone = false
            
        }  catch let error {
            print(error.localizedDescription)
            customMainPaymentView.paymentViewModel.isPaymentOperationDone = false
            
        }
        
        
    }
    
    //TODO: -handle methods
    
    
    @objc func handleDonePayment()  {
        
        
        print(999)
    }
    
    @objc func handleBack()  {
        dismiss(animated: true)
        
        //        navigationController?.popViewController(animated: true)
    }
    
    @objc func handlePayment()  {
        doThis()
    }
    
}

extension MainPaymentVC: AcceptSDKDelegate  {
    
    func userDidCancel() {
        
    }
    
    func paymentAttemptFailed(_ error: AcceptSDKError, detailedDescription: String) {
        SVProgressHUD.showError(withStatus: detailedDescription)
    }
    
    func transactionRejected(_ payData: PayResponse) {
    }
    
    func transactionAccepted(_ payData: PayResponse) {
        customMainPaymentView.paymentViewModel.isPaymentOperationDone = payData.success
    }
    
    func transactionAccepted(_ payData: PayResponse, savedCardData: SaveCardResponse) {
        
    }
    
    func userDidCancel3dSecurePayment(_ pendingPayData: PayResponse) {
        
    }
}
