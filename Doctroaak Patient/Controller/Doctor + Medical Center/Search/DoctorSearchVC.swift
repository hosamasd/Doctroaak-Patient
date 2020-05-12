//
//  DoctorSearchVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD
import MOLH

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
        v.specificationId=specificationId
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.handlerChooseLocation = {[unowned self] in
            let loct = ChooseLocationVC()
            loct.delgate = self
            self.navigationController?.pushViewController(loct, animated: true)
        }
        v.searchButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        return v
    }()
    
    fileprivate let specificationId:Int!
    init(spy:Int) {
        self.specificationId = spy
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
        customDoctorSearchView.doctorSearchViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customDoctorSearchView.searchButton)
        }
        
        customDoctorSearchView.doctorSearchViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
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
            
            // Address dictionary
            print(placeMark.locality)
                  // Location name
                  if let locationName = placeMark.addressDictionary!["Name"] as? String,let city = placeMark.addressDictionary!["City"] as? String ,let country = placeMark.addressDictionary!["Country"] as? String {
                    self.customDoctorSearchView.addressLabel.text =  " \(locationName) - \(String(describing: city)) - \(String(describing: country))"
                        self.customDoctorSearchView.doctorSearchViewModel.lat = latitude
                    self.customDoctorSearchView.doctorSearchViewModel.specificationId = self.specificationId
                        self.customDoctorSearchView.doctorSearchViewModel.lng = longitude
                  }

                  
            // Location name
//            let street = placeMark.subLocality; let city = placeMark.administrativeArea;let country = placeMark.country
//            self.customDoctorSearchView.addressLabel.text =  " \(placeMark.subLocality ?? "") - \(String(describing: city)) - \(String(describing: country))"
//            self.customDoctorSearchView.doctorSearchViewModel.lat = latitude
//            self.customDoctorSearchView.doctorSearchViewModel.lng = longitude
            
        })
        
        
    }
    
    func goToNext(_ doctors:[PatientSearchDoctorsModel])  {
        let card = CardiologyDoctorsResultsVC(doctors:doctors)
        navigationController?.pushViewController(card, animated: true)
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSearch()  {
        customDoctorSearchView.doctorSearchViewModel.performLogging { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.goToNext(user)
            }
            
            
            
            
        }
    }
}

//MARK:-Extensions

extension DoctorSearchVC: ChooseLocationVCProtocol {
    
    func getLatAndLong(lat: Double, long: Double) {
        convertLatLongToAddress(latitude: lat, longitude: long)
    }
    
}
