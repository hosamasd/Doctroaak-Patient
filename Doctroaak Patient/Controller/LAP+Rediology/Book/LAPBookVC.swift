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
        v.lapBookViewModel.rad_id=self.labId
        
        v.lapBookViewModel.image = self.img
        v.lapBookViewModel.orderDetails = self.orders
        //        v.api_token = api_token ?? ""
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
    lazy var customAlertSuccessView:CustomAlertSuccessView = {
        let v = CustomAlertSuccessView()
        v.setupAnimation(name: "4970-unapproved-cross")
        v.handleOkTap = {[unowned self] in
            self.handleOkSuccess()
        }
        return v
    }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    
    var orders:[RadiologyOrderModel]?
    var img:UIImage?
    var patient:PatienModel?{
        didSet{
            guard let patient = patient else { return  }
            customLAPBookView.patient=patient
        }
    }
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
        scrollView.delegate=self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) {
            patient=cacheObjectCodabe.storedValue
            
        }else {}
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
//                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Booking...".localized)
                self.showMainAlertLooder()
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
    
    fileprivate func presentLogin()  {
        let login = LoginVC()
        login.delgate=self
        let nav = UINavigationController(rootViewController: login)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    fileprivate func handleremoveLoginAlert()  {
        removeViewWithAnimation(vvv: customAlertLoginView)
        customMainAlertVC.dismiss(animated: true)
        presentLogin()
        
    }
    
    fileprivate func presentAlert()  {
        
        customMainAlertVC.addCustomViewInCenter(views: customAlertLoginView, height: 200)
        customAlertLoginView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
        
    }
    
    fileprivate func getNotes() ->String {
        guard let name = customLAPBookView.lapBookViewModel.fullName,let  mobile = customLAPBookView.lapBookViewModel.mobile,let age = customLAPBookView.lapBookViewModel.age  else { return "" }
        let ss = ","
        let agee="\(age)"
        let isMale = customLAPBookView.lapBookViewModel.male
        
        return name+ss+mobile+ss+agee+ss+isMale
    }
    
    fileprivate func makeLabSearch() {
        customLAPBookView.lapBookViewModel.performLabBooking(notess: getNotes()) { (base, err) in
            
            if let err = err {
                //                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            //            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let message = base else {return }
            
            let ar = message.message ?? message.messageEn ?? ""
            
            
            DispatchQueue.main.async {
                self.presentSuccessAlert(txt: ar )
            }
            
        }
    }
    
    fileprivate func showMessage(_ mess:String)  {
        let height = "".getFrameForText(text: mess)
        
        customMainAlertVC.addCustomViewInCenter(views: customAlertSuccessView, height: height.height+80)
        customAlertSuccessView.discriptionInfoLabel.text = mess
        customAlertSuccessView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
    }
    
    fileprivate func makeRadiologySearch() {
        
        
        
        customLAPBookView.lapBookViewModel.performRadiologyBooking(notess: getNotes()) { (base, err) in
            
            if let err = err {
                //                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            //            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let message = base else {return }
            
            let ar = message.message ?? message.messageEn ?? ""
            
            
            DispatchQueue.main.async {
                self.presentSuccessAlert(txt: ar )
            }
            
        }
    }
    
    fileprivate func presentSuccessAlert(txt:String)  {
        
        customMainAlertVC.addCustomViewInCenter(views: customAlertSuccessView, height: 200)
        customAlertSuccessView.problemsView.loopMode = .loop
        
        customAlertSuccessView.discriptionInfoLabel.text = txt
        present(customMainAlertVC, animated: true)
        
    }
    
    fileprivate  func showMainAlertLooder()  {
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
    
    
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    @objc func handleBook()  {
        if patient == nil {
            presentAlert()
        }else {
            //            guard let api = api_token,let patientId = patient_id else { return  }
            guard let api = patient?.apiToken,let patientId = patient?.id else { return  }
            
            customLAPBookView.lapBookViewModel.api_token=api
            customLAPBookView.lapBookViewModel.patient_id=patientId
            index == 0 ? makeLabSearch() : makeRadiologySearch()
        }
    }
    
    @objc func handleOkSuccess()  {
        removeViewWithAnimation(vvv: customAlertLoginView)
        customMainAlertVC.dismiss(animated: true)
        let orders = ProfileOrdersVC(isFromOrder: true)
        navigationController?.pushViewController(orders, animated: true)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:-extension

extension LAPBookVC:LoginVCPrototcol {
    
    func useApiAndPatienId(patient: PatienModel) {
        self.patient = patient
        
    }
}


extension LAPBookVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        self.scrollView.isScrollEnabled = x < -60 ? false : true
        
    }
}
