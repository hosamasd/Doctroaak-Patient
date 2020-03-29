//
//  WelcomeVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class WelcomeVC: CustomBaseViewVC {
    
    lazy var customWelcomeView:CustomWelcomeView = {
        let v = CustomWelcomeView()
        return v
    }()
    
    lazy var views = [
        customWelcomeView.drImage,
        customWelcomeView.docotrLabel,
        customWelcomeView.copyWriteLabel,
    ]
    var timer: Timer?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAnimation()
    }
    
    //MARK: -user methods
    
    override func setupViews() {
        
        view.addSubview(customWelcomeView)
        customWelcomeView.fillSuperview()
    }
    
    fileprivate func setupAnimation()  {
        views.forEach({$0.alpha = 1})
        
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        let translateButtons = CGAffineTransform.init(translationX: -1000, y: 0)
        
        [ customWelcomeView.docotrLabel, customWelcomeView.copyWriteLabel].forEach({$0.transform = translateButtons})
        self.customWelcomeView.drImage.transform = translateTransform
        
        UIView.animate(withDuration: 0.5) {
            self.customWelcomeView.drImage.transform = .identity
        }
        
        self.addTransform()
        
        UIView.animate(withDuration: 0.7, delay: 0.6 * 1.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            [ self.customWelcomeView.docotrLabel, self.customWelcomeView.copyWriteLabel].forEach({$0.transform = .identity})
            self.goToNextVC()
        })
    }
    
    func goToNextVC()  {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+12) {
            self.handleNext()
        }
        
    }
    
    
    
    func addTransform()  {
        var rotationAnimation = CABasicAnimation()
        rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: (Double.pi))
        rotationAnimation.duration = 1.0
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = 10.0
        self.customWelcomeView.drImage.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    //TODO: -handle methods
    
    @objc func handleNext()  {
        let welcome = SecondWelcomeVC()
        let nav = UINavigationController(rootViewController:welcome)
        present(nav, animated: true)
        //        navigationController?.pushViewController(welcome, animated: true)
        
    }
}

