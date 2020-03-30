//
//  DoctorBookVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class DoctorBookVC: CustomBaseViewVC {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1000)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var cusomBookView:CusomBookView = {
        let v = CusomBookView()
        v.boyButton.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
        v.girlButton.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
        v.shift1Button.addTarget(self, action: #selector(handle1Shift), for: .touchUpInside)
        v.shift2Button.addTarget(self, action: #selector(handle2Shift), for: .touchUpInside)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:-User methods
    
    override  func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        //        mainView.fillSuperview()
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: cusomBookView)
        cusomBookView.fillSuperview()
        
        
        
    }
    
    fileprivate func changeBoyGirlState(_ sender: UIButton,secondBtn:UIButton,isMale:Bool) {
        if sender.backgroundColor == nil {
//            registerViewModel.isMale = isMale;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: secondBtn)
//        registerViewModel.isMale = isMale
    }
    
    func changeShiftsState(_ sender: UIButton,secondBtn:UIButton,isShift1:Bool) {
        if sender.backgroundColor == nil {
            //            registerViewModel.isMale = isMale;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: secondBtn)
        //        registerViewModel.isMale = isMale
    }
    //TODO: -handle methods
    
    @objc func handleGirl(sender:UIButton)  {
        changeBoyGirlState(sender,secondBtn: cusomBookView.boyButton,isMale: false)
    }
    
    @objc func handleBoy(sender:UIButton)  {
        changeBoyGirlState(sender, secondBtn: cusomBookView.girlButton, isMale: true)
    }
    
  @objc  func handle1Shift(sender:UIButton)  {
        changeShiftsState(sender, secondBtn: cusomBookView.shift2Button, isShift1: false)

    }
    
    @objc  func handle2Shift(sender:UIButton)  {
        changeShiftsState(sender, secondBtn: cusomBookView.shift1Button, isShift1: true)
        
    }
}
