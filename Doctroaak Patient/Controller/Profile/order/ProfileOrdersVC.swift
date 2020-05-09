//
//  ProfileOrdersVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ProfileOrdersVC: CustomBaseViewVC {
    
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
    lazy var customProfileOrdersView:CustomProfileOrdersView = {
        let v = CustomProfileOrdersView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        
        v.handleCheckedIndex = {[unowned self] indexPath in
            let cDetails = DeatilsVC()
            self.navigationController?.pushViewController(cDetails, animated: true)
        }
        return v
    }()
    lazy var mainBottomView:UIView = {
           let v = UIView(backgroundColor: .white)
//           v.backgroundColor = .red
           v.layer.cornerRadius = 16
           v.clipsToBounds = true
           v.addSubview(customBottomOrdersView)
           return v
       }()
       lazy var customBottomOrdersView = CustomBottomOrdersView()
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        
        view.addSubview(scrollView)
              scrollView.fillSuperview()
              scrollView.addSubview(mainView)
              //        mainView.fillSuperview()
              mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
              mainView.addSubViews(views: customProfileOrdersView,mainBottomView)
        customProfileOrdersView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 20, right: 0))
        mainBottomView.anchor(top: customProfileOrdersView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        customBottomOrdersView.centerInSuperview(size: .init(width: view.frame.width-64, height: 40))
//        view.addSubview(scrollView)
//        scrollView.fillSuperview()
//        scrollView.addSubview(mainView)
//        //        mainView.fillSuperview()
//        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
//        mainView.addSubViews(views: customProfileOrdersView)
//        customProfileOrdersView.fillSuperview()
    }
    
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
}
