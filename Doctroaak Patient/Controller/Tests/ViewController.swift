//
//  ViewController.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ViewController: CustomBaseViewVC {

    lazy var cusomBookView:CustomTestView = {
        let v = CustomTestView()
//        v.boyButton.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
//        v.girlButton.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
//        v.shift1Button.addTarget(self, action: #selector(handle1Shift), for: .touchUpInside)
//        v.shift2Button.addTarget(self, action: #selector(handle2Shift), for: .touchUpInside)
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }

    override func setupViews() {
        view.addSubViews(views: cusomBookView)
        cusomBookView.fillSuperview()
    }
}

