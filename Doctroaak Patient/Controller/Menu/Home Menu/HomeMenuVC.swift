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
    
    var index:Int? = 0
    
    
    
    
    //MARK: -user methods
    
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
        navigationController?.pushViewController(services, animated: true)
        
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
