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
        scrollView.delegate=self
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
//                                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                                SVProgressHUD.show(withStatus: "Login...".localized)
                
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
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubview(customMainPaymentView)
        customMainPaymentView.fillSuperview()
        
    }
    
    func doThis()  {
        let random = Int.random(in: 1...200)
        
        let paymentAPIKey = "ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6VXhNaUo5LmV5SndjbTltYVd4bFgzQnJJam94TWpZMU5Td2libUZ0WlNJNklqRTFPVEl5TVRNM09UVXVORGd5TWpjMklpd2lZMnhoYzNNaU9pSk5aWEpqYUdGdWRDSjkuYzJZVmFhbE1hUmtudzB3RjVKcTNzUWdFQU9QQ2xtd1d3N2RCdXotekxiWnduZkl0ZEh6Y1NsT3gtOURnM1Eyc2sybXl5WFktZ29HcXhqdVVRVGdrdHc="
        
        let isEnglish = MOLHLanguage.isRTLLanguage() ? false : true
        let bData = [  "first_name": "Clifford",
                    "last_name": "Nicolas",
                    "street": "Ethan Land",
                    "building": "8028",
                    "floor": "42",
                    "apartment": "803",
                    "city": "Jaskolskiburgh",
                    "state": "Utah",
                    "country": "CR",
                    "email": "claudette09@exa.com",
                    "phone_number": "+86(8)9135210487",
                    "postal_code": "01898",
                    "extra_description": " ",
                    "shipping_method": "UNK",
                    
                   ]
        
        AcceptPaymentServices.shared.firsttRequest(first:paymentAPIKey) { (base, err) in
            if let err=err{
                print(err.localizedDescription)
            }
            guard let pp = base,let id = base?.profile?.id else {return}
        
            AcceptPaymentServices.shared.secondRequest(auth_token: pp.token ?? "", id: "\(id)", random: random) { (se, err) in
                if let err=err{
                    print(err.localizedDescription)
                }
                guard let ss = se else {return}
                AcceptPaymentServices.shared.thirdLastTokenRequest(auth_token: pp.token ?? "") { (last, err) in
                     if let err=err{
                                       print(err.localizedDescription)
                                   }
                                   guard let last = last else {return}
                    let sds = last.token
                    
                    DispatchQueue.main.async {
                                                self.presentPayment(billingData:bData,isEnglish: isEnglish,key: sds)

                    }
                }
            }
            
        }
       
        
        
    }
    
    func presentPayment(billingData:[String:String],isEnglish:Bool,key:String)  {
        do {
                   
                   try accept.presentPayVC(vC: self, billingData: billingData, paymentKey: key, saveCardDefault:
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
         print(999)
    }
    
    func paymentAttemptFailed(_ error: AcceptSDKError, detailedDescription: String) {
        print(error)
        SVProgressHUD.showError(withStatus: detailedDescription)
    }
    
    func transactionRejected(_ payData: PayResponse) {
         print(999)
    }
    
    func transactionAccepted(_ payData: PayResponse) {
         print(999)
        customMainPaymentView.paymentViewModel.isPaymentOperationDone = payData.success
    }
    
    func transactionAccepted(_ payData: PayResponse, savedCardData: SaveCardResponse) {
         print(999)
    }
    
    func userDidCancel3dSecurePayment(_ pendingPayData: PayResponse) {
         print(999)
    }
}


extension MainPaymentVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        self.scrollView.isScrollEnabled = x < -60 ? false : true
        
    }
}
