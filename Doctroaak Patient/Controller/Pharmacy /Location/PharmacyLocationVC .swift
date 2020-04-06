//
//  PharmacyLocationVC .swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class PharmacyLocationVC: CustomBaseViewVC {
    
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
    lazy var customPharmacyLocationView:CustomPharmacyLocationView = {
        let v = CustomPharmacyLocationView()
        v.handlerChooseLocation = {[unowned self] in
            let loct = ChooseLocationVC()
            loct.delgate = self
            self.navigationController?.pushViewController(loct, animated: true)
        }
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
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
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customPharmacyLocationView)
        customPharmacyLocationView.fillSuperview()
    }
    
    //TODO: -handle methods
    
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
  @objc  func handleNext()  {
    let order = PharmacyOrderVC()
    navigationController?.pushViewController(order, animated: true)
    }
    
}



//MARK:-Extensions

extension PharmacyLocationVC: ChooseLocationVCProtocol {
    func getLatAndLong(lat: Double, long: Double) {
        customPharmacyLocationView.pharamacyLocationViewModel.lat = "\(lat)"
        customPharmacyLocationView.pharamacyLocationViewModel.lng = "\(long)"
        customPharmacyLocationView.addressLabel.text = "\(lat), \(long)"

        print(lat, "            ",long)
    }
    
    
}