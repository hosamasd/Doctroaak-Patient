//
//  LapSearchResultsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LapSearchResultsVC: CustomBaseViewVC {
    
    lazy var customLapResultsView:CustomLapResultsView = {
        let v = CustomLapResultsView()
        v.index = index
        v.handleCheckedIndex = {[unowned self] indexx in
            let selected = LAPSelectedSearchResultsVC(index: self.index)
//            selected.index = self.index
            self.navigationController?.pushViewController(selected, animated: true)
            }
        return v
    }()
    
    var index:Int = 0 //0 for lab 1 for residology

    
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
        
        view.addSubViews(views: customLapResultsView)
        customLapResultsView.fillSuperview()
    }

}
