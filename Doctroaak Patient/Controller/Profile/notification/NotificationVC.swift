//
//  NotificationVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

class NotificationVC: CustomBaseViewVC {
    
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1000)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customNotificationView:CustomNotificationView = {
        let v = CustomNotificationView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        
        v.handledisplayNotification = {[unowned self] noty,index in
            self.makeDeleteNotify(id: noty.id,index)
        }
        //        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
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
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
           let v = CustomAlertMainLoodingView()
           v.setupAnimation(name: "heart_loading")
           return v
       }()
    
    fileprivate let patients:PatienModel!
    fileprivate let isFromMenu:Bool!
    
    //    fileprivate let api_token:String!
    //    fileprivate let user_id:Int!
    //
    //    init(TOKEN:String,ID:Int) {
    //        self.api_token=TOKEN
    //        self.user_id=ID
    //        super.init(nibName: nil, bundle: nil)
    //    }
    
    init(patient:PatienModel,isFromMenu:Bool) {
        self.isFromMenu=isFromMenu
        self.patients=patient
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate=self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNotifications()
    }
    
    //MARK:-User methods
    
    func getNotifications()  {
        let s = "vyAAbhTZXBRfB2tqo13GZCLHuzm8bsJz4ABFbf0YY3oxlkGiTj5uLrckGL6WvDUfBxmUJKIzoIUqwpXaSjxghnEn3h51"
        let d = 44
        
//        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
//        SVProgressHUD.show(withStatus: "Looding...".localized)
        self.showMainAlertLooder()
        PatientProfileSservicea.shared.getNotifications(api_token: patients.apiToken, user_id: patients.id) { (base, err) in
            if let err = err {
                                SVProgressHUD.showError(withStatus: err.localizedDescription)
//                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
//            SVProgressHUD.dismiss()
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.reloadData(user: user)
            }
        }
    }
    
    func showMainAlertLooder()  {
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingView, height: 200)
        customAlertMainLoodingView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
    }
    
    func reloadData(user:[PatientNotificationModel])  {
        self.customNotificationView.notificationsCollectionVC.notificationArray=user
        DispatchQueue.main.async {
            self.customNotificationView.notificationsCollectionVC.collectionView.reloadData()
        }
    }
    
    func makeDeleteNotify(id:Int,_ index:IndexPath)  {
//        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        SVProgressHUD.show(withStatus: "Looding...".localized)
        PatientProfileSservicea.shared.removeNotification(notification_id: id) { (base, err) in
            if let err = err {
                                SVProgressHUD.showError(withStatus: err.localizedDescription)
//                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()

//            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            DispatchQueue.main.async {
                self.customNotificationView.notificationsCollectionVC.notificationArray.remove(at: index.item)
                self.customNotificationView.notificationsCollectionVC.collectionView.reloadData()
                self.showToast(context: self, msg: MOLHLanguage.isRTLLanguage() ? "تمت العملية بنجاح" :  user.messageEn)//"Deleted successfully...".localized)
            }
        }
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customNotificationView)
        customNotificationView.fillSuperview()
        
        
        
    }
    
    @objc func handleBack()  {
        if isFromMenu {
            dismiss(animated: true)
        }else {
            dismiss(animated: true)
            
            //        navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}



extension NotificationVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        self.scrollView.isScrollEnabled = x < -60 ? false : true
        
    }
}
