//
//  IncubationSearchVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class IncubationSearchVC: CustomBaseViewVC {
    
    lazy var customIncubationSearchView:CustomIncubationSearchView = {
        let v = CustomIncubationSearchView()
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
           customIncubationSearchView.incubationSearchViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
               guard let isValid = isValidForm else {return}
               //            self.customLoginView.loginButton.isEnabled = isValid
               
               self.changeButtonState(enable: isValid, vv: self.customIncubationSearchView.searchButton)
           }
           
           customIncubationSearchView.incubationSearchViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
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
        
        view.addSubViews(views: customIncubationSearchView)
        customIncubationSearchView.fillSuperview()
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSearch()  {
        let details = IncubationSearchResultsVC()
        navigationController?.pushViewController(details, animated: true)
    }
    
}



//MARK:-extension


extension IncubationSearchVC : ChooseLocationVCProtocol{
    
    func getLatAndLong(lat: Double, long: Double) {
        customIncubationSearchView.incubationSearchViewModel.lat = "\(lat)"
        customIncubationSearchView.incubationSearchViewModel.lng = "\(long)"
        customIncubationSearchView.addressLabel.text = "\(lat) ,  \(long)"
        print(lat, "            ",long)
    }
    
}
