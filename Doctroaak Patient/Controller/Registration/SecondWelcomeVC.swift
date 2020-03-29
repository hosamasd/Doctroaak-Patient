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
    
    //check to go specific way
    var index:Int = 0
    
    //MARK: -user methods
    
    override func setupViews() {
        view.addSubview(customSecondWelcomeView)
        customSecondWelcomeView.fillSuperview()
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    func goToLoginNextVC(index:Int) {
//        let medical = MainLoginsVC()
//        medical.index = index
//        navigationController?.pushViewController(medical, animated: true)
    }
    
    func goToRegisterNextVC(index:Int) {
//        let doctor = DoctorRegisterVC()
//        doctor.index = index
//        let medical = MainRegisterVC()
//        medical.index = index
//        let vc = index == 0 || index == 1 ? doctor : medical
//
//        navigationController?.pushViewController( vc, animated: true)
    }
    
    //TODO: -handle methods
    
    @objc func handleLogin()  {
        goToLoginNextVC(index: index )
    }
    
    @objc func handleRegister()  {
        goToRegisterNextVC(index: index )
    }
}
