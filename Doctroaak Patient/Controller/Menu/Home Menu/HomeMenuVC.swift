//
//  HomeMenuVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class HomeMenuVC: CustomBaseViewVC {
    
    
    
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
    
    
    
    lazy var customMainHomeView:CustomMainHomeView = {
        let v = CustomMainHomeView()
        v.handleDetails = {[unowned self] in
            self.presentBeforePaymentVC()
        }
        v.handlePayments = {[unowned self] in
            self.checkIfUserLogin()
        }
        v.mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleGoServices)))
        v.main2View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleGoFavorites)))
        v.main3View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleGoMyOrders)))
        v.notifyImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenNotifications)))
        v.listImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenMenu)))
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
    
    lazy var views = [ customMainHomeView.mainView,customMainHomeView.main2View,customMainHomeView.main3View]
    //    var patient_Id:Int?
    //    var patientAPITOKEN:String?
    var patient:PatienModel?{
        didSet{
            guard let patient = patient else { return  }
            //               customMainHomeView.patient=patient
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        putUserId()
        setupAnimation()
        scrollView.delegate=self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) {
            patient=cacheObjectCodabe.storedValue
        }else{}
    }
    
    //MARK: -user methods
    
    func putUserId()  {
        if userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) {
            patient=cacheObjectCodabe.storedValue
            //            patient_Id = userDefaults.integer(forKey: UserDefaultsConstants.patientUserID)
            //            patientAPITOKEN = userDefaults.string(forKey: UserDefaultsConstants.patientAPITOKEN)
        }else {}
    }
    
    fileprivate func setupAnimation()  {
        views.forEach({$0.alpha = 1})
        
        customMainHomeView.mainView.transform = CGAffineTransform.init(translationX: 0, y: 1000)
        customMainHomeView.main3View.transform = CGAffineTransform.init(translationX: 0, y: -1000)
        customMainHomeView.main2View.transform = CGAffineTransform.init(translationX: -1000, y: 0)
        UIView.animate(withDuration: 0.7, delay: 0.6, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            [ self.customMainHomeView.mainView,self.customMainHomeView.main2View,self.customMainHomeView.main3View].forEach({$0.transform = .identity})
        })
    }
    
    override func setupNavigation()  {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func setupViews()  {
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubview(customMainHomeView)
        customMainHomeView.fillSuperview()
        
    }
    
   fileprivate func chooseVC(isDetail:Bool)  {
        let vc = isDetail ?  FirstSkipPaymentVC() : MainPaymentVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
   fileprivate func checkIfUserLogin()  {
        if userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) {
            chooseVC(isDetail: false)
        }else {
            customMainAlertVC.addCustomViewInCenter(views: customAlertLoginView, height: 200)
            customAlertLoginView.problemsView.loopMode = .loop
            present(customMainAlertVC, animated: true)
        }
    }
    
    fileprivate func presentBeforePaymentVC() {
        chooseVC(isDetail: true)
    }
    
    func handleremoveLoginAlert()  {
        removeViewWithAnimation(vvv: customAlertLoginView)
        customMainAlertVC.dismiss(animated: true)
        let login = LoginVC()
        login.delgate = self
        let nav = UINavigationController(rootViewController: login)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    fileprivate func openAlertForLogin() {
        customMainAlertVC.addCustomViewInCenter(views: customAlertLoginView, height: 200)
        customAlertLoginView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
    }
    
    //TODO: -handle methods
    
    
    @objc func handleGoServices()  {
        let services = ServicesVC()
        services.patient=self.patient
        let nav = UINavigationController(rootViewController: services)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
    }
    
    @objc func handleOpenMenu()  {
        (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? BaseSlidingVC)?.openMenu()
    }
    
    
    
    @objc func handleOpenNotifications()  {
        if patient==nil && !userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin){
            openAlertForLogin()
        }else {
            guard let patient = patient else { return  }
            let notify = NotificationVC(patient: patient, isFromMenu: false)
            let nav = UINavigationController(rootViewController: notify)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
            //            navigationController?.pushViewController(notify, animated: true)
        }
    }
    
    @objc func handleGoFavorites()  {
        if patient == nil {
            openAlertForLogin()
        }else {
            guard let patient = patient else { return  }
            let favorite = PatientFavoriteDoctorsVC(index: 0)
            favorite.patient=patient
            let nav = UINavigationController(rootViewController: favorite)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
            
            //            navigationController?.pushViewController(favorite,animated:true)
        }
    }
    
    @objc func handleGoMyOrders()  {
        if patient==nil && !userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) {
            openAlertForLogin()
            
        }else {
            let order = ProfileOrdersVC(isFromOrder: false)
            order.patient=patient
            let nav = UINavigationController(rootViewController: order)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertLoginView)
        
        dismiss(animated: true, completion: nil)
        
        
    }
}

//MARK:-extension

extension HomeMenuVC:LoginVCPrototcol {
    func useApiAndPatienId(patient: PatienModel) {
        self.patient = cacheObjectCodabe.storedValue
    }
    
    
}


extension HomeMenuVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        self.scrollView.isScrollEnabled = x < -60 ? false : true
        
    }
}
