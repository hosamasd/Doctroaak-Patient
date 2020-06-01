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
           v.constrainHeight(constant: 1000)
           v.constrainWidth(constant: view.frame.width)
           return v
       }()
    
    lazy var customFirstSkipPaymentView:CustomFirstSkipPaymentView = {
           let v = CustomFirstSkipPaymentView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        v.handleNextOperation = {[unowned self] in
//            self.handlessNext()
        }
           return v
       }()
    
    var infoDetails:[[String]]? {
        didSet{
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    
    //MARK: -user methods
    
    func handlessNext()  {
        
        if customFirstSkipPaymentView.mainBeforePaymentCollectionVC.pageControl.currentPage+1 < customFirstSkipPaymentView.mainBeforePaymentCollectionVC.pages.count-1 {
            let nextIndex = min(customFirstSkipPaymentView.mainBeforePaymentCollectionVC.pageControl.currentPage + 1, customFirstSkipPaymentView.mainBeforePaymentCollectionVC.pages.count - 1)
               
               
               let indexPath = IndexPath(item: nextIndex, section: 0)
            customFirstSkipPaymentView.mainBeforePaymentCollectionVC.pageControl.currentPage = nextIndex
            customFirstSkipPaymentView.mainBeforePaymentCollectionVC.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
               
            customFirstSkipPaymentView.mainBeforePaymentCollectionVC.backButton.image = customFirstSkipPaymentView.mainBeforePaymentCollectionVC.pageControl.currentPage == 0 ? #imageLiteral(resourceName: "buttons-square-gray") : #imageLiteral(resourceName: "buttons-square-grayd")
               
               
            if nextIndex == customFirstSkipPaymentView.mainBeforePaymentCollectionVC.pages.count - 1 {
                   
                customFirstSkipPaymentView.mainBeforePaymentCollectionVC.hideOrUnhide(b: false, b2: true)
                   //                return
               }
           }else {
               let indexPath = IndexPath(item: 3, section: 0)
               
            customFirstSkipPaymentView.mainBeforePaymentCollectionVC.pageControl.currentPage = 3
            customFirstSkipPaymentView.mainBeforePaymentCollectionVC.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            customFirstSkipPaymentView.mainBeforePaymentCollectionVC.hideOrUnhide(b: true, b2: false)
           }
    }
    
    func fetchData()  {
        userDefaults.bool(forKey: UserDefaultsConstants.isPaymentDetailsInfo) ? () : getStaticData()
    }
    
    func getStaticData()  {
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen

        SVProgressHUD.show(withStatus: "Looding...")
        
        MainServices.shared.getPaymentDetails { (base, err) in
            
        if let err = err {
                      SVProgressHUD.showError(withStatus: err.localizedDescription)
                      self.activeViewsIfNoData();return
                  }
                  SVProgressHUD.dismiss()
                  self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            let flattened = user.reduce([]) { $0 + $1 }
            let arabicPages = Array(flattened[0...3])
            let englishPages = Array(flattened[4...7])
            
                  DispatchQueue.main.async {
                    self.customFirstSkipPaymentView.mainBeforePaymentCollectionVC.pages = MOLHLanguage.isRTLLanguage() ? arabicPages : englishPages
                    self.customFirstSkipPaymentView.mainBeforePaymentCollectionVC.collectionView.reloadData()
                  }
    }
    }
    
       override func setupViews() {
           
            view.addSubview(customFirstSkipPaymentView)
                  customFirstSkipPaymentView.fillSuperview()
//                  scrollView.addSubview(mainView)
//                  mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
//                  mainView.addSubViews(views: customFirstSkipPaymentView)
//                  customFirstSkipPaymentView.fillSuperview()
       }
    
    override func setupNavigation()  {
          navigationController?.navigationBar.isHide(true)
      }
    
    func handleNext()  {
//        if customFirstSkipPaymentView.mainBeforePaymentCollectionVC.pageControl.currentPage+1 < pages.count-1 {
//                   let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
//                   
//                   
//                   let indexPath = IndexPath(item: nextIndex, section: 0)
//                   pageControl.currentPage = nextIndex
//                   collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//                   
//                   backButton.image = pageControl.currentPage == 0 ? #imageLiteral(resourceName: "buttons-square-gray") : #imageLiteral(resourceName: "buttons-square-grayd")
//                   
//                   
//                   if nextIndex == pages.count - 1 {
//                       
//                       hideOrUnhide(b: false, b2: true)
//                       //                return
//                   }
//               }else {
//                   let indexPath = IndexPath(item: 3, section: 0)
//                   
//                   pageControl.currentPage = 3
//                   collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//                   hideOrUnhide(b: true, b2: false)
//               }
    }
    
    @objc func handleDismiss()  {
        dismiss(animated: true)
    }
}
