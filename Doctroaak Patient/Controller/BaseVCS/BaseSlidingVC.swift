//
//  BaseSlidingVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import MOLH

class BaseSlidingVC: UIViewController {
    
    
    
    lazy var redView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    lazy var blueView:UIView = {
        let v = UIView(backgroundColor: .blue)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    lazy var darkCoverView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var customAlertChooseLanguageView:CustomAlertChooseLanguageView = {
        let v = CustomAlertChooseLanguageView()
        [v.englishButton,v.arabicButton,v.cancelButton].forEach({$0.addTarget(self, action: #selector(handleLanguages), for: .touchUpInside)})
        return v
    }()
    lazy var customMainAlertVC:CustomMainAlertVC = {
        let t = CustomMainAlertVC()
        t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    lazy var customAlertLoginView:CustomAlertLoginView = {
        let v = CustomAlertLoginView()
        v.setupAnimation(name: "4970-unapproved-cross")
        v.handleOkTap = {[unowned self] in
            self.handleremoveLoginAlert()
        }
        return v
    }()
    
    lazy var customContactUsView:CustomContactUsView = {
        let v = CustomContactUsView()
        v.handleChoosedOption = {[unowned self] index in
            self.takeSpecificAction(index)
        }
        return v
    }()
    //     var rightViewController: UIViewController = UINavigationController(rootViewController: HomeVC())
    var rightViewController: UIViewController = UINavigationController(rootViewController: HomeMenuVC())
    fileprivate let velocityThreshold: CGFloat = 500
    fileprivate let menuWidth:CGFloat = 300
    fileprivate var isMenuOpen:Bool = false
    var redViewTrailingConstraint: NSLayoutConstraint!
    var redViewLeadingConstarint:NSLayoutConstraint!
    var links = [
        "http://sphinxat.com/",
        "https://www.facebook.com/",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupViews()
        setupGesture()
        setupViewControllers()
        
        
        darkCoverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapped)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !userDefaults.bool(forKey: UserDefaultsConstants.isWelcomeVCAppear) {
            let welcome = WelcomeVC()
            welcome.modalPresentationStyle = .fullScreen
            present(welcome, animated: true)
        }else {}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func takeSpecificAction(_ index:Int)  {
        if index == 2 {
            self.callNumber(phoneNumber: "0123666")
        }else if index == 3 {
            self.sendUsingWhats()
        }else {
            guard let url = URL(string: self.links[index]) else { return  }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        removeViewWithAnimation(vvv: customContactUsView)
        customMainAlertVC.dismiss(animated: true)
    }
    
    func callNumber(phoneNumber:String) {
        if let phoneCallURL:URL = URL(string:"tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:])
            }
        }
    }
    
    func sendUsingWhats()  {
        let urlWhats = "whatsapp://send?text=\("Hello World")"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.open(whatsappURL as URL)
                }
                else {
                    print("please install whatsapp")
                }
            }
        }
    }
    
    //    override var preferredStatusBarStyle: UIStatusBarStyle {
    //        return isMenuOpen ? .lightContent : .default
    //    }
    
    //MARK: -user methods
    
    fileprivate func setupViews()  {
        //        view.backgroundColor = .red
        view.addSubViews(views: redView,blueView)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
        ])
        self.redViewLeadingConstarint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        //        redViewLeadingConstraint.constant = 150
        redViewLeadingConstarint.isActive = true
        redViewTrailingConstraint = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        redViewTrailingConstraint.isActive = true
        
        
    }
    
    fileprivate func setupGesture()  {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePaneed))
        //        pan.delegate = self
        view.addGestureRecognizer(pan)
    }
    
    fileprivate func setupViewControllers()  {
        let homeView = rightViewController.view!
        
        //        let menuVC = MenuVC()
        let menuVC = HomeLeftMenuVC()
        let menuView = menuVC.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(homeView)
        redView.addSubview(darkCoverView)
        blueView.addSubview(menuView)
        
        homeView.fillSuperview()
        menuView.fillSuperview()
        darkCoverView.fillSuperview()
        
        addChild(rightViewController)
        addChild(menuVC)
    }
    
    
    
    func handleEnded(gesture:UIPanGestureRecognizer)  {
        let translate = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        // Cleaning up this section of code to solve for Lesson #10 Challenge of velocity and darkCoverView
        if isMenuOpen {
            if abs(velocity.x) > velocityThreshold {
                closeMenu()
                return
            }
            if abs(translate.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if abs(velocity.x) > velocityThreshold {
                openMenu()
                return
            }
            
            if translate.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
        
    }
    
    
    
    func didSelectItemAtIndex(index:IndexPath)  {
        
        
        performRightViewCleanUp()
        closeMenu()
        
        switch index.row {
        case 0:
            rightViewController = UINavigationController(rootViewController: ProfileVC())
            //        case 1:
            //            rightViewController = UINavigationController(rootViewController: ListVC())
            //        case 2:
        //            rightViewController = BookmarkVC()
        default:
            let vc = UIViewController()
            vc.view.backgroundColor = .red
            rightViewController = UINavigationController(rootViewController: vc)
            print(index.item)
            //
            //            let tabBarController = UITabBarController()
            //            let momentsController = UIViewController()
            //            momentsController.navigationItem.title = "Moments"
            //            momentsController.view.backgroundColor = .orange
            //            let navController = UINavigationController(rootViewController: momentsController)
            //            navController.tabBarItem.title = "Moments"
            //            tabBarController.viewControllers = [navController]
            //            rightViewController = tabBarController
        }
        redView.addSubview(rightViewController.view)
        addChild(rightViewController)
        redView.bringSubviewToFront(darkCoverView)
        
        
    }
    
    func performRightViewCleanUp()  {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    
    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpen ? 1 : 0
        })
    }
    
    func closeMenu() {
        redViewLeadingConstarint.constant = 0
        redViewTrailingConstraint.constant = 0
        isMenuOpen = false
        performAnimations()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func openMenu() {
        isMenuOpen = true
        redViewLeadingConstarint.constant = menuWidth
        performAnimations()
        setNeedsStatusBarAppearanceUpdate() // for indicate system to any changes in status bar
    }
    
    //TODO: -handle methods
    
    @objc func handleTapped()  {
        closeMenu()
    }
    
    @objc  func handlePaneed(gesture:UIPanGestureRecognizer)  {
        let transltaion = gesture.translation(in: view)
        var x = transltaion.x
        x = isMenuOpen ? x+menuWidth : x
        x = min(menuWidth, x)
        x = max(0, x)
        redViewLeadingConstarint.constant = x
        darkCoverView.alpha = x / menuWidth
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    func handleremoveLoginAlert()  {
        removeViewWithAnimation(vvv: customAlertLoginView)
        customMainAlertVC.dismiss(animated: true)
        let login = LoginVC()
        let nav = UINavigationController(rootViewController: login)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
    }
    
    @objc func handleDismiss()  {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleLanguages(sender:UIButton)  {
        switch sender.tag {
        case 0:
            //english
            print("english")
            !MOLHLanguage.isArabic() ? () : print("not englisg")
        case 1:
            //arabic
            print("arabic")
            MOLHLanguage.isArabic() ? () : print("not arabic")
        default:
            ()
        }
        removeViewWithAnimation(vvv: customAlertChooseLanguageView)
        customMainAlertVC.dismiss(animated: true)
        
    }
}
