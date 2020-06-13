//
//  HomeLeftMenuVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class HomeLeftMenuVC: CustomBaseViewVC {
    
    
    lazy var customMainHomeLeftView:CustomMainHomeLeftView = {
        let v = CustomMainHomeLeftView()
        v.handleCheckedIndex = {[unowned self] index in
            self.checkIfLoggined(index)
        }
        v.first8Stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLogout)))
        return v
    }()
    var patient:PatienModel?{
        didSet{
            guard let patient = patient else { return  }
            customMainHomeLeftView.patient=patient
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) {
            patient =    cacheObjectCodabe.storedValue
            
        }else {}
    }
    
    //MARK: -user methods
    
    
    override func setupNavigation()  {
        //        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(customMainHomeLeftView)
        customMainHomeLeftView.fillSuperview()
    }
    
    func checkIfLoggined(_ indexPath:IndexPath)  {
        guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC else {return}
        
        //        guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
        if indexPath.item ==  3 || indexPath.item == 4{
            if indexPath.item == 3 {
                baseSlid.closeMenu()
                showAlertForContacting()
            }else if indexPath.item == 4 {
                baseSlid.closeMenu()
                chooseLanguage()
            }
        }else if !userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin){
            baseSlid.closeMenu()
            showAlertForLogin()
        }else {
            guard let patient = patient else { return  }
            
            if indexPath.item==0 {
                baseSlid.closeMenu()
                let profile = ProfileVC()
                let nav = UINavigationController(rootViewController: profile)
                
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true)
                //                navigationController?.pushViewController(profile, animated: true)
            }else if indexPath.item == 1 {
                baseSlid.closeMenu()
                let profile = AnaylticsVC()
                let nav = UINavigationController(rootViewController: profile)
                
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true)
                
            }else if indexPath.item == 3 {
                baseSlid.closeMenu()
                showAlertForContacting()
            }else {
                baseSlid.closeMenu()
                let profile = NotificationVC(patient: patient, isFromMenu: true)
                let nav = UINavigationController(rootViewController: profile)
                
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true)
            }
            
        }
    }
    
    
    
    fileprivate func chooseLanguage()  {
        guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC else {return}
        
        //        guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
        
        baseSlid.closeMenu()
        baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customAlertChooseLanguageView, height: 200)
        baseSlid.present(baseSlid.customMainAlertVC, animated: true)
    }
    fileprivate func showAlertForContacting()  {
        guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC else {return}
        
        //        guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
        
        baseSlid.closeMenu()
        baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customContactUsView, height: 120)
        baseSlid.present(baseSlid.customMainAlertVC, animated: true)
    }
    
    fileprivate func showAlertForLogin()  {
        
        //        guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
        guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC else {return}
        
        baseSlid.closeMenu()
        baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customAlertLoginView, height: 200)
        baseSlid.customAlertLoginView.problemsView.loopMode = .loop
        baseSlid.present(baseSlid.customMainAlertVC, animated: true)
    }
    
    fileprivate  func performLogout()  {
        guard let patient = patient else { return  }
        cacheObjectCodabe.deleteFile(patient)
        userDefaults.set(false, forKey: UserDefaultsConstants.isPatientLogin)
        userDefaults.synchronize()
        self.patient = nil
        DispatchQueue.main.async {
            self.customMainHomeLeftView.first8Stack.isHide(true)
            self.customMainHomeLeftView.userNameLabel.text = ""
            self.customMainHomeLeftView.userImage.image =  #imageLiteral(resourceName: "Group 4143")
        }
    }
    
    fileprivate func createAlerts() {
        let alert = UIAlertController(title: "Warring...".localized, message: "Do You Want To Log Out?".localized, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Log Out".localized, style: .destructive) {[unowned self] (_) in
            self.performLogout()
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) {[unowned self] (_) in
            alert.dismiss(animated: true)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    //TODO: -handle methods
    
    @objc func handleLogout()  {
        
        guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC else {return}
        baseSlid.closeMenu()
        createAlerts()
    }
    
    
}
