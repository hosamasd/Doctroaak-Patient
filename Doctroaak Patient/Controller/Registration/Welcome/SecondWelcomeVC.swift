//
//  SecondWelcomeVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class SecondWelcomeVC: CustomBaseViewVC {
    
    lazy var customSecondWelcomeView:CustomSecondWelcomeView = {
        let v = CustomSecondWelcomeView()
        v.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        v.registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return v
    }()
    
  
    
    //MARK: -user methods
    
    override func setupViews() {
        view.addSubview(customSecondWelcomeView)
        customSecondWelcomeView.fillSuperview()
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    

    
    //TODO: -handle methods
    
    @objc func handleLogin()  {

        let medical = LoginVC()
        navigationController?.pushViewController(medical, animated: true)
    }
    
    @objc func handleRegister()  {
        let register = RegisterVC()
        navigationController?.pushViewController(register, animated: true)
    }
}
