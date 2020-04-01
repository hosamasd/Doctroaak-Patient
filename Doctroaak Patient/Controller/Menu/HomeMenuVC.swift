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
        v.constrainHeight(constant: 800)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    
    lazy var customMainHomeView:CustomMainHomeView = {
        let v = CustomMainHomeView()
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
}
