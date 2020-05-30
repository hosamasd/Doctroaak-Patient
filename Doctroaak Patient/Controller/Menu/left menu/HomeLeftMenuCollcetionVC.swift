//
//  HomeLeftMenuCollcetionVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class HomeLeftMenuCollcetionVC: BaseCollectionVC {
    
    var images:[UIImage] = [#imageLiteral(resourceName: "icon"),#imageLiteral(resourceName: "ic_language_24px"),#imageLiteral(resourceName: "ic_notifications_active_24px").withRenderingMode(.alwaysTemplate),#imageLiteral(resourceName: "ic_phone_24px"),#imageLiteral(resourceName: "ic_language_24px")]
    var deatas = ["Profile","Anayltics","Notifications","Contact Us","Language"]
    
    
    
    fileprivate let cellId = "cellId"
    
    var handleCheckedIndex:((IndexPath)->Void)?
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deatas.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MainLeftMenuCell
        cell.Image6.image = images[indexPath.item]
        cell.Label6.text = deatas[indexPath.item]
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleCheckedIndex?(indexPath)
//        checkIfLoggined(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 60)
    }
    
    //TODO: -handle methods
    
//    func checkIfLoggined(_ indexPath:IndexPath)  {
//        guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
//        if !userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin)  && indexPath.item == 4{
//            showAlertForLogin()
//            
//        }else if indexPath.item == 4 {
//            chooseLanguage()
//        }else {
//            if indexPath.item==0 {
//                baseSlid.closeMenu()
//                let profile = ProfileVC()
//                profile.modalPresentationStyle = .fullScreen
//                present(profile, animated: true)
////                navigationController?.pushViewController(profile, animated: true)
//            }else if indexPath.item == 1 {
//                baseSlid.closeMenu()
//                let profile = AnaylticsVC()
//                profile.modalPresentationStyle = .fullScreen
//                present(profile, animated: true)
////                navigationController?.pushViewController(profile, animated: true)
//            }
//            
//            //        if !userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) &&  indexPath.item==0 {
//            //            showAlertForLogin()
//            //        }else if indexPath.item==1{
//            //             baseSlid.closeMenu()
//            //
//            //          let ans =  AnaylticsVC()
//            //            navigationController?.pushViewController(ans, animated: true)
//            //        }
//            //        if !userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) && indexPath.item != 4 {
//            //            showAlertForLogin()
//            //            baseSlid.closeMenu()
//            ////            baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customAlertLoginView, height: 200)
//            ////            baseSlid.customAlertLoginView.problemsView.loopMode = .loop
//            ////            baseSlid.present(baseSlid.customMainAlertVC, animated: true)
//            //
//            //        }else if indexPath.item == 4  {
//            //            baseSlid.closeMenu()
//            //                       baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customAlertChooseLanguageView, height: 200)
//            //                       baseSlid.present(baseSlid.customMainAlertVC, animated: true)
//            //        }else{
//            //            baseSlid.didSelectItemAtIndex(index: indexPath)
//            //
//            //        }
//        }
//    }
//    
//    
//    
//    func chooseLanguage()  {
//        guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
//        
//        baseSlid.closeMenu()
//        baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customAlertChooseLanguageView, height: 200)
//        baseSlid.present(baseSlid.customMainAlertVC, animated: true)
//    }
//    
//    func showAlertForLogin()  {
//        guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
//        
//        baseSlid.closeMenu()
//        baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customAlertLoginView, height: 200)
//        baseSlid.customAlertLoginView.problemsView.loopMode = .loop
//        baseSlid.present(baseSlid.customMainAlertVC, animated: true)
//    }
    override func setupCollection() {
        collectionView.backgroundColor = .white
        collectionView.register(MainLeftMenuCell.self, forCellWithReuseIdentifier: cellId)
    }
}
