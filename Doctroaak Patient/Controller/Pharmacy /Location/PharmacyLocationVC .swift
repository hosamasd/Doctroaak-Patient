//
//  PharmacyLocationVC .swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class PharmacyLocationVC: CustomBaseViewVC {
    
    lazy var customPharmacyLocationView:CustomPharmacyLocationView = {
        let v = CustomPharmacyLocationView()
        v.handlerChooseLocation = {[unowned self] in
            let loct = ChooseLocationVC()
            loct.delgate = self
            self.navigationController?.pushViewController(loct, animated: true)
        }
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        return v
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        customPharmacyLocationView.pharamacyLocationViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customPharmacyLocationView.nextButton)
        }
        
        customPharmacyLocationView.pharamacyLocationViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
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
        
        view.addSubViews(views: customPharmacyLocationView)
        customPharmacyLocationView.fillSuperview()
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
}



//MARK:-Extensions

extension PharmacyLocationVC: ChooseLocationVCProtocol {
    func getLatAndLong(lat: Double, long: Double) {
        customPharmacyLocationView.pharamacyLocationViewModel.lat = "\(lat)"
        customPharmacyLocationView.pharamacyLocationViewModel.lng = "\(long)"
        print(lat, "            ",long)
    }
    
    
}
