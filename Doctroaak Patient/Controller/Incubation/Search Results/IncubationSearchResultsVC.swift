//
//  IncubationSearchResultsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class IncubationSearchResultsVC: CustomBaseViewVC {
    
    lazy var customIncubationResultsView:CustomIncubationResultsView = {
        let v = CustomIncubationResultsView()
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
    }
    
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = #colorLiteral(red: 0.9829737544, green: 0.9831344485, blue: 0.9829396605, alpha: 1)
        
        view.addSubViews(views: customIncubationResultsView)
        customIncubationResultsView.fillSuperview()
    }

}
