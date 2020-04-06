//
//  ICUSearchVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ICUSearchVC: CustomBaseViewVC {
    
    
    lazy var customICUSearchView:CustomICUSearchView = {
        let v = CustomICUSearchView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.handlerChooseLocation = {[unowned self] in
                          let loct = ChooseLocationVC()
                          loct.delgate = self
                          self.navigationController?.pushViewController(loct, animated: true)
                      }
                      v.searchButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        customICUSearchView.icuViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customICUSearchView.searchButton)
        }
        
        customICUSearchView.icuViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
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
        
        view.addSubViews(views: customICUSearchView)
        customICUSearchView.fillSuperview()
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSearch()  {
           let details = ICUSearchResultsVC()
           navigationController?.pushViewController(details, animated: true)
       }
    
}



//MARK:-extension


extension ICUSearchVC : ChooseLocationVCProtocol{
    
    func getLatAndLong(lat: Double, long: Double) {
        customICUSearchView.icuViewModel.lat = "\(lat)"
        customICUSearchView.icuViewModel.lng = "\(long)"
        customICUSearchView.addressLabel.text = "\(lat) ,  \(long)"
        print(lat, "            ",long)
    }
    
}
