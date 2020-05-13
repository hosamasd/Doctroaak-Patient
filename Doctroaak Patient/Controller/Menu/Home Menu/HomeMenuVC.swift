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
    var patient_Id:Int?
    var patientAPITOKEN:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        putUserId()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAnimation()
    }
    
    
    //MARK: -user methods
    
    func putUserId()  {
        if userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) {
            patient_Id = userDefaults.integer(forKey: UserDefaultsConstants.patientUserID)
            patientAPITOKEN = userDefaults.string(forKey: UserDefaultsConstants.patientAPITOKEN)
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
    
    func chooseVC(isDetail:Bool)  {
        let vc = isDetail ?  FirstSkipPaymentVC() : MainPaymentVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func checkIfUserLogin()  {
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
    
    @objc func handleGoServices()  {
        let services = ServicesVC()
        services.patientApiToken=patientAPITOKEN
        services.patient_id=patient_Id
        let nav = UINavigationController(rootViewController: services)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        //        navigationController?.pushViewController(services, animated: true)
        
    }
    
    @objc func handleOpenMenu()  {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.openMenu()
        
    }
    
    func handleremoveLoginAlert()  {
        
        removeViewWithAnimation(vvv: customAlertLoginView)
        customMainAlertVC.dismiss(animated: true)
    }
    
    @objc func handleGoFavorites()  {
        let favorite = PatientFavoriteDoctorsVC()
        navigationController?.pushViewController(favorite,animated:true)
        
    }
    
    @objc func handleGoMyOrders()  {
        print(666)
    }
    
    @objc func handleDismiss()  {
        dismiss(animated: true, completion: nil)
    }
}
