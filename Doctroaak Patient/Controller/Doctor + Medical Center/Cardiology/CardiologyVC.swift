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
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))

        v.handleCheckedIndex = {[unowned self] indexPath in
            let cDetails = DeatilsVC()
            self.navigationController?.pushViewController(cDetails, animated: true)
        }
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
        
        view.addSubViews(views: customCardiologyView)
        customCardiologyView.fillSuperview()
    }
    
    
    @objc  func handleBack()  {
          navigationController?.popViewController(animated: true)
      }
}
