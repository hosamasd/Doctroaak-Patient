//
//  FirstSkipPaymentVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class FirstSkipPaymentVC: CustomBaseViewVC {
    
    lazy var customFirstSkipPaymentView:CustomFirstSkipPaymentView = {
           let v = CustomFirstSkipPaymentView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
           return v
       }()
    
    //MARK: -user methods
       
       override func setupViews() {
           
           view.addSubview(customFirstSkipPaymentView)
           customFirstSkipPaymentView.fillSuperview()
       }
    
    override func setupNavigation()  {
          navigationController?.navigationBar.isHide(true)
      }
    
    @objc func handleDismiss()  {
        dismiss(animated: true)
    }
}
