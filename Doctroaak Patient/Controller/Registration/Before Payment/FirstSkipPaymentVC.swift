//
//  FirstSkipPaymentVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

class FirstSkipPaymentVC: CustomBaseViewVC {
    
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
    
    lazy var customFirstSkipPaymentView:CustomFirstSkipPaymentView = {
        let v = CustomFirstSkipPaymentView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        v.handlePaymentAction = {[unowned self] in
            self.checkLoginState()
            
        }
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
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    var infoDetails:[[String]]? {
        didSet{
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        scrollView.delegate=self
    }
    
    
    //MARK: -user methods
    
    override func setupViews() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customFirstSkipPaymentView)
        customFirstSkipPaymentView.fillSuperview()
        //        view.addSubview(customFirstSkipPaymentView)
        //        customFirstSkipPaymentView.fillSuperview()
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    fileprivate func checkLoginState()  {
        if !userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) {
            customMainAlertVC.addCustomViewInCenter(views: customAlertLoginView, height: 200)
            present(customMainAlertVC, animated: true)
        }else {
            let payment = MainPaymentVC()
            self.navigationController?.pushViewController(payment, animated: true)
        }
    }
    
    fileprivate  func fetchData()  {
        getStaticData()
        //        !userDefaults.bool(forKey: UserDefaultsConstants.isPaymentDetailsInfo) ? () : getStaticData()
    }
    
    fileprivate func getStaticData()  {
        //        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        
        //        SVProgressHUD.show(withStatus: "Looding...")
        self.showMainAlertLooder()
        MainServices.shared.getPaymentDetails { (base, err) in
            
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            
            //            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            let flattened = user.reduce([]) { $0 + $1 }
            let arabicPages = Array(flattened[0...3])
            let englishPages = Array(flattened[4...7])
            
            
            DispatchQueue.main.async {
                self.customFirstSkipPaymentView.mainBeforePaymentCollectionVC.pages = MOLHLanguage.isRTLLanguage() ? arabicPages : englishPages
                self.customFirstSkipPaymentView.mainBeforePaymentCollectionVC.pageControl.numberOfPages = arabicPages.count
                self.customFirstSkipPaymentView.mainBeforePaymentCollectionVC.collectionView.reloadData()
            }
        }
    }
    
    
    
    
    
    fileprivate func handleremoveLoginAlert()  {
        removeViewWithAnimation(vvv: customAlertLoginView)
        customMainAlertVC.dismiss(animated: true)
        let login = LoginVC()
        let nav = UINavigationController(rootViewController: login)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
    }
    
    fileprivate func showMainAlertLooder()  {
        self.customMainAlertVC.addCustomViewInCenter(views: self.customAlertMainLoodingView, height: 200)
        self.customAlertMainLoodingView.problemsView.play()
        self.customAlertMainLoodingView.problemsView.loopMode = .loop
        self.present(self.customMainAlertVC, animated: true)
        
        
    }
    
    //TODO: -handle methods
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertLoginView)
        
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}


extension FirstSkipPaymentVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        self.scrollView.isScrollEnabled = x < -60 ? false : true
        
    }
}
