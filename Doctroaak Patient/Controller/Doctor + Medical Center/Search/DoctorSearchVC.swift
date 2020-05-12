//
//  DoctorSearchVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MapKit

class DoctorSearchVC: CustomBaseViewVC {
    
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
    lazy var customDoctorSearchView:CustomDoctorSearchView = {
        let v = CustomDoctorSearchView()
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
        customDoctorSearchView.doctorSearchViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customDoctorSearchView.searchButton)
        }
        
        customDoctorSearchView.doctorSearchViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
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
        mainView.addSubViews(views: customDoctorSearchView)
        customDoctorSearchView.fillSuperview()
    }
    
    fileprivate func convertLatLongToAddress(latitude:Double,longitude:Double){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: {[unowned self] (placemarks, error) -> Void in
            
            // Place details
            //            var placeMark: CLPlacemark?
            guard let   placeMark = placemarks?[0] else {return}
            
            // Location name
            guard  let street = placeMark.subLocality, let city = placeMark.administrativeArea, let country = placeMark.country else {return}
            self.customDoctorSearchView.addressLabel.text =  " \(street) - \(city) - \(country)"
            self.customDoctorSearchView.doctorSearchViewModel.lat = "\(latitude)"
            self.customDoctorSearchView.doctorSearchViewModel.lng = "\(longitude)"
        })
        
        
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSearch()  {
        let card = CardiologyVC()
        navigationController?.pushViewController(card, animated: true)
        
    }
}

//MARK:-Extensions

extension DoctorSearchVC: ChooseLocationVCProtocol {
    
    func getLatAndLong(lat: Double, long: Double) {
        convertLatLongToAddress(latitude: lat, longitude: long)
    }
    
}
