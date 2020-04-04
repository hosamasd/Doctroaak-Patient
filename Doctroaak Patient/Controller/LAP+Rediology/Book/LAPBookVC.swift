//
//  LAPBookVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LAPBookVC: CustomBaseViewVC {
    
    
    lazy var customLAPBookView:CustomLAPBookView = {
        let v = CustomLAPBookView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.index = index
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        
        customLAPBookView.lapBookViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customLAPBookView.bookButton)
        }
        
        customLAPBookView.lapBookViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isValid) in
            if isValid == true {
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
        
        view.addSubViews(views: customLAPBookView)
        customLAPBookView.fillSuperview()
    }
    
    //TODO: -handle methods
    
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    
}
