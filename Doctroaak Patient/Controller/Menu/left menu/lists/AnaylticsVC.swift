//
//  AnaylticsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class AnaylticsVC: CustomBaseViewVC {
    
    
    lazy var customAnaylticsView:CustomAnaylticsView = {
        let v = CustomAnaylticsView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.addSubview(customAnaylticsView)
        customAnaylticsView.fillSuperview()
        
    }
    
    //TODO: -handle methods
    
    
    @objc func handleBack()  {
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
}
