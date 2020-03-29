//
//  HomeMenuVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class HomeMenuVC: CustomBaseViewVC {
    
    lazy var customMainHomeView:CustomMainHomeView = {
        let v = CustomMainHomeView()
        return v
    }()
    var index:Int? = 0
    
    
    
    
    //MARK: -user methods
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(customMainHomeView)
        customMainHomeView.fillSuperview()
        
    }
}
