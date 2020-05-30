//
//  LAPBookVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SVProgressHUD
import MOLH

class LAPBookVC: CustomBaseViewVC {
    
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
    lazy var customLAPBookView:CustomLAPBookView = {
        let v = CustomLAPBookView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.index = index
        v.lapBookViewModel.lab_id=self.labId
        v.patient_id = patient_id ?? 0
        v.lapBookViewModel.image = self.img
        v.lapBookViewModel.orderDetails = self.orders
        v.api_token = api_token ?? ""
        v.bookButton.addTarget(self, action: #selector(handleBook), for: .touchUpInside)
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
            self.handleremoveLoginAlert()
        }
        return v
    }()
    
    
    var orders:[RadiologyOrderModel]?
    var img:UIImage?
    
    var  api_token:String?
    var  patient_id:Int?
    fileprivate let labId:Int!
    
    fileprivate let index:Int!
    init(index:Int,labId:Int) {
        self.labId=labId
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let id=userDefaults.integer(forKey: UserDefaultsConstants.patientID)
        guard let api = userDefaults.string(forKey: UserDefaultsConstants.patientAPITOKEN) else { return  }
        patient_id=id
        api_token=api
    }
    
    
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        
        customLAPBookView.lapBookViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customLAPBookView.bookButton)
        }
        
        customLAPBookView.lapBookViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isValid) in
            if isValid == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                SVProgressHUD.show(withStatus: "Booking...".localized)
                
            }else {
                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
            }
        })
    }
    
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customLAPBookView)
        customLAPBookView.fillSuperview()
    }
    
    func presentLogin()  {
        let login = LoginVC()
        login.delgate=self
        let nav = UINavigationController(rootViewController: login)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func handleremoveLoginAlert()  {
        removeViewWithAnimation(vvv: customAlertLoginView)
        customMainAlertVC.dismiss(animated: true)
        presentLogin()
        
    }
    
    func presentAlert()  {
        
        customMainAlertVC.addCustomViewInCenter(views: customAlertLoginView, height: 200)
        customAlertLoginView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
        
    }
    
    func getNotes() ->String {
        guard let name = customLAPBookView.lapBookViewModel.fullName,let  mobile = customLAPBookView.lapBookViewModel.mobile,let age = customLAPBookView.lapBookViewModel.age  else { return "" }
        let ss = ","
        let agee="\(age)"
        let isMale = customLAPBookView.lapBookViewModel.male
        
        return name+ss+mobile+ss+agee+ss+isMale
    }
    
    fileprivate func makeLabSearch() {
        customLAPBookView.lapBookViewModel.performLabBooking(notess: getNotes()) { (base, err) in
            
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let message = base else {return }
            
            DispatchQueue.main.async {
                self.showToast(context: self, msg: (MOLHLanguage.isRTLLanguage() ? message.message : message.messageEn) ?? "")
            }
            
        }
    }
    
    fileprivate func makeRadiologySearch() {
        
        
        
        customLAPBookView.lapBookViewModel.performRadiologyBooking(notess: getNotes()) { (base, err) in
            
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let message = base else {return }
            
            DispatchQueue.main.async {
                self.showToast(context: self, msg: (MOLHLanguage.isRTLLanguage() ? message.message : message.messageEn) ?? "")
                
                //                            self.createAlert(title: "Information", message: (MOLHLanguage.isRTLLanguage() ? message.message : message.messageEn) ?? "" , style: .alert)
                //                self.dismiss(animated: true, completion: nil)
                //                       self.saveToken(user_id: user.id,user.phone)
            }
            
        }
    }
    
    //TODO: -handle methods
    
    
    @objc  func handleBack()  {
        
        if api_token == nil && patient_id == nil  {
            presentAlert()
        }else {
            guard let api = api_token,let patientId = patient_id else { return  }
            customLAPBookView.lapBookViewModel.api_token=api
            customLAPBookView.lapBookViewModel.patient_id=patientId
            index == 0 ? makeLabSearch() : makeRadiologySearch()
            
            
        }
    }
    
    
    
    
    @objc func handleBook()  {
        if api_token == nil && patient_id == nil  {
            presentAlert()
        }else {
            guard let api = api_token,let patientId = patient_id else { return  }
            customLAPBookView.lapBookViewModel.api_token=api
            customLAPBookView.lapBookViewModel.patient_id=patientId
            index == 0 ? makeLabSearch() : makeRadiologySearch()
        }
    }
    
    @objc func handleDismiss()  {
        dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LAPBookVC:LoginVCPrototcol {
    
    func useApiAndPatienId(api: String, patient: Int) {
        api_token = api
        patient_id=patient
        handleBack()
    }
}
