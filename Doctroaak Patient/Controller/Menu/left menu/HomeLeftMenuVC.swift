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
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
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
            guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
            if !userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin)  && indexPath.item == 4{
                showAlertForLogin()
                
            }else if indexPath.item == 4 {
                chooseLanguage()
            }else {
                if indexPath.item==0 {
                    baseSlid.closeMenu()
                    let profile = ProfileVC()
                    profile.modalPresentationStyle = .fullScreen
                    present(profile, animated: true)
    //                navigationController?.pushViewController(profile, animated: true)
                }else if indexPath.item == 1 {
                    baseSlid.closeMenu()
                    let profile = AnaylticsVC()
                    profile.modalPresentationStyle = .fullScreen
                    present(profile, animated: true)
    //                navigationController?.pushViewController(profile, animated: true)
                }
                
                //        if !userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) &&  indexPath.item==0 {
                //            showAlertForLogin()
                //        }else if indexPath.item==1{
                //             baseSlid.closeMenu()
                //
                //          let ans =  AnaylticsVC()
                //            navigationController?.pushViewController(ans, animated: true)
                //        }
                //        if !userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) && indexPath.item != 4 {
                //            showAlertForLogin()
                //            baseSlid.closeMenu()
                ////            baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customAlertLoginView, height: 200)
                ////            baseSlid.customAlertLoginView.problemsView.loopMode = .loop
                ////            baseSlid.present(baseSlid.customMainAlertVC, animated: true)
                //
                //        }else if indexPath.item == 4  {
                //            baseSlid.closeMenu()
                //                       baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customAlertChooseLanguageView, height: 200)
                //                       baseSlid.present(baseSlid.customMainAlertVC, animated: true)
                //        }else{
                //            baseSlid.didSelectItemAtIndex(index: indexPath)
                //
                //        }
            }
        }
        
        
        
        func chooseLanguage()  {
            guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
            
            baseSlid.closeMenu()
            baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customAlertChooseLanguageView, height: 200)
            baseSlid.present(baseSlid.customMainAlertVC, animated: true)
        }
        
        func showAlertForLogin()  {
            guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
            
            baseSlid.closeMenu()
            baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customAlertLoginView, height: 200)
            baseSlid.customAlertLoginView.problemsView.loopMode = .loop
            baseSlid.present(baseSlid.customMainAlertVC, animated: true)
        }
    
    //TODO: -handle methods
    
    @objc func handleOne()  {
        print(9999999)
    }
}
