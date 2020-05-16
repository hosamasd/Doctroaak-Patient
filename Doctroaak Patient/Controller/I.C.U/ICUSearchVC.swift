//
//  ICUSearchVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD
import MOLH

class ICUSearchVC: CustomBaseViewVC {
    
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
        put()
    }
    
    //MARK:-User methods
    
    func put()  {
        SearchServices.shared.iCUGetSearchResults(city: 0, are: 0, latt: 10.0, lang: 10.0) { (base, err) in
            
        }
    }
    
    func setupViewModelObserver()  {
        customICUSearchView.icuViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customICUSearchView.searchButton)
        }
        
        customICUSearchView.icuViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                SVProgressHUD.show(withStatus: "Searching...".localized)
                
            }else {
                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
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
        mainView.addSubViews(views: customICUSearchView)
        customICUSearchView.fillSuperview()
    }
    
    fileprivate func convertLatLongToAddress(latitude:Double,longitude:Double){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: {[unowned self] (placemarks, error) -> Void in
            
            // Place details
            //            var placeMark: CLPlacemark?
            guard let   placeMark = placemarks?[0] else {return}
            self.customICUSearchView.addressLabel.text = placeMark.locality
            // Location name
            guard  let street = placeMark.subLocality, let city = placeMark.administrativeArea, let country = placeMark.country else {return}
            self.customICUSearchView.addressLabel.text =  " \(street) - \(city) - \(country)"
        })
        
        
    }
    
    func goToNext()  {
        let details = ICUSearchResultsVC()
        navigationController?.pushViewController(details, animated: true)
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSearch()  {
        
        customICUSearchView.icuViewModel.performSearchinging { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard (base?.data) != nil else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.goToNext()
            }
            
            
        }
        
    }
    
}
    
    
    
    //MARK:-extension
    
    
    extension ICUSearchVC : ChooseLocationVCProtocol{
        
        func getLatAndLong(lat: Double, long: Double) {
            convertLatLongToAddress(latitude: lat, longitude: long)
            self.customICUSearchView.icuViewModel.lat = lat
            self.customICUSearchView.icuViewModel.lng = long
        }
}
