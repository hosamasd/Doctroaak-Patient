//
//  LAPBookVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LAPBookVC: CustomBaseViewVC {
    
    
    lazy var customLAPBookView:CustomLAPBookView = {
        let v = CustomLAPBookView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.boyButton.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
        v.girlButton.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
        return v
    }()
    
    fileprivate let index:Int!
    init(index:Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubViews(views: customLAPBookView)
        customLAPBookView.fillSuperview()
    }

    fileprivate func changeBoyGirlState(_ sender: UIButton,secondBtn:UIButton,isMale:Bool) {
        if sender.backgroundColor == nil {
            //            registerViewModel.isMale = isMale;return
        }else {
        addGradientInSenderAndRemoveOther(sender: sender, vv: secondBtn)
        //        registerViewModel.isMale = isMale
        }
    }
  
    //TODO: -handle methods
    
    @objc func handleGirl(sender:UIButton)  {
        changeBoyGirlState(sender,secondBtn: customLAPBookView.boyButton,isMale: false)
    }
    
    @objc func handleBoy(sender:UIButton)  {
        changeBoyGirlState(sender, secondBtn: customLAPBookView.girlButton, isMale: true)
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
}
