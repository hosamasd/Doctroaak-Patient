//
//  CardiologyVC.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CardiologyVC: UIViewController {
    
    lazy var customCardiologyView:CustomCardiologyView = {
        let v = CustomCardiologyView()
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
    }
    
    
    func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    func setupViews()  {
        view.backgroundColor = #colorLiteral(red: 0.9829737544, green: 0.9831344485, blue: 0.9829396605, alpha: 1)
        
        view.addSubViews(views: customCardiologyView)
        customCardiologyView.fillSuperview()
//        mainView.addSubViews(views: customDetailsView)
//        customDetailsView.fillSuperview()
        
        
        
    }
}
