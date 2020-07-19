//
//  DoctorListsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH
import SVProgressHUD

class DoctorListsVC: CustomBaseViewVC {
    
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
    lazy var customDoctorListsView:CustomDoctorListsView = {
        let v = CustomDoctorListsView()
        v.index = self.index
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.handleCheckedIndex = {[unowned self] spy in
            let vc = DoctorSearchVC(spy: spy, index: self.index)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return v
    }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    lazy var customAlertLoginView:CustomAlertLoginView = {
              let v = CustomAlertLoginView()
              v.setupAnimation(name: "4970-unapproved-cross")
              v.handleOkTap = {[unowned self] in
                  self.handleDismiss()
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
    
    fileprivate let index:Int!
    init(index:Int) {
        self.index=index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSpecification()
        scrollView.delegate=self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !ConnectivityInternet.isConnectedToInternet {
            showToast(context: self, msg: "No interntetI Connection".localized)
        }
    }
    
    
    func getSpecification()  {
        if userDefaults.bool(forKey: UserDefaultsConstants.isSpecificationsCached) {
            getData()
        }
    }
    
    func getData()  {
        UIApplication.shared.beginIgnoringInteractionEvents()
        showMainAlertLooder()
//        SVProgressHUD.show(withStatus: "Looding...".localized)
        MainServices.shared.getSpecificationss { (base, err) in
            if let err=err{
//                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)

                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
//            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let specificationsArray = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            self.customDoctorListsView.doctorListCollectionVC.specificationArray = specificationsArray
            
            DispatchQueue.main.async {
                self.customDoctorListsView.doctorListCollectionVC.collectionView.reloadData()
                
                self.view.layoutIfNeeded()
            }
        }
        
        
    }
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customDoctorListsView)
        customDoctorListsView.fillSuperview()
    }
    
   
    
    func showMainAlertLooder()  {
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingView, height: 200)
        customAlertMainLoodingView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
}


extension DoctorListsVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        self.scrollView.isScrollEnabled = x < -60 ? false : true
        
    }
}
