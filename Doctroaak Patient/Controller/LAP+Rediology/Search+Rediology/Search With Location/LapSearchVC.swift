//
//  LapSearchVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LapSearchVC: CustomBaseViewVC {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 900)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    
    lazy var customLapSearchView:CustomLapSearchView = {
        let v = CustomLapSearchView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.handlerChooseLocation = {[unowned self] in
            let loct = ChooseLocationVC()
            loct.delgate = self
            self.navigationController?.pushViewController(loct, animated: true)
        }
        return v
    }()
    
    
    fileprivate let index:Int!
    
    init(index:Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
           super.viewDidLoad()
           setupViewModelObserver()
       }
       
       //MARK:-User methods
       
       func setupViewModelObserver()  {
          customLapSearchView.lAPSearchViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
               guard let isValid = isValidForm else {return}
               //            self.customLoginView.loginButton.isEnabled = isValid
               
               self.changeButtonState(enable: isValid, vv: self.customLapSearchView.searchButton)
           }
           
           customLapSearchView.lAPSearchViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
               if isReg == true {
                   //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                   //                SVProgressHUD.show(withStatus: "Login...".localized)
                   
               }else {
                   //                SVProgressHUD.dismiss()
                   //                self.activeViewsIfNoData()
               }
           })
       }
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        //        mainView.fillSuperview()
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customLapSearchView)
        customLapSearchView.fillSuperview()
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
}

extension LapSearchVC : ChooseLocationVCProtocol{
    func getLatAndLong(lat: Double, long: Double) {
        customLapSearchView.lAPSearchViewModel.lat = "\(lat)"
        customLapSearchView.lAPSearchViewModel.lng = "\(long)"
        print(lat, "            ",long)
    }
    
}
