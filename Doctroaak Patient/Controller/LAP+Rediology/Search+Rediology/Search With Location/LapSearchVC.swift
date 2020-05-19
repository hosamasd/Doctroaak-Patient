//
//  LapSearchVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD
import MOLH

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
        v.index=index
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.handlerChooseLocation = {[unowned self] in
            let loct = ChooseLocationVC()
            loct.delgate = self
            self.navigationController?.pushViewController(loct, animated: true)
        }
        v.searchButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        return v
    }()
    
    var apiToken:String?
       var patientId:Int? 
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
//                check()
    }
    
    //MARK:-User methods
    
    func check()  {
        SearchServices.shared.labGetSearchResults(firstOption: false, lab_id: 1,city: 1,are: 1, insurance: 0, delivery: 0,latt: 0.2,lang: 10.00) { (base, err) in
            print(err)
        }
    }
    
    func setupViewModelObserver()  {
        customLapSearchView.lAPSearchViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customLapSearchView.searchButton)
        }
        
        customLapSearchView.lAPSearchViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
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
        mainView.addSubViews(views: customLapSearchView)
        customLapSearchView.fillSuperview()
    }
    
    fileprivate func convertLatLongToAddress(latitude:Double,longitude:Double){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: {[unowned self] (placemarks, error) -> Void in
            
            // Place details
            //            var placeMark: CLPlacemark?
            guard let   placeMark = placemarks?[0] else {return}
            self.customLapSearchView.addressLabel.text =  placeMark.locality
            
            // Location name
            guard  let street = placeMark.subLocality, let city = placeMark.administrativeArea, let country = placeMark.country else {return}
            self.customLapSearchView.addressLabel.text =  " \(street) - \(city) - \(country)"
            
        })
        
        
    }
    
    func goToNext(_ patient:[LapSearchModel]? = nil , _ radiology:[RadiologySearchModel]? = nil)  {
        let details = LapSearchResultsVC(index:index)
        details.apiToken=apiToken
        details.patientId=patientId
        details.labArrayResults=patient ?? []
        details.radiologyArrayResults=radiology ?? []
        navigationController?.pushViewController(details, animated: true)
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func makeLabSearch() {
        customLapSearchView.lAPSearchViewModel.performLabSearching { (base, err) in
            
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
    
    fileprivate func makeRadiologySearch() {
        customLapSearchView.lAPSearchViewModel.performRadiologySearching { (base, err) in
            
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.goToNext(nil,user)
            }
            
        }
    }
    
    
    @objc func handleSearch()  {
        
        index == 0 ? makeLabSearch() : makeRadiologySearch()
    }
}

//MARK:-extension


extension LapSearchVC : ChooseLocationVCProtocol{
    
    func getLatAndLong(lat: Double, long: Double) {
        convertLatLongToAddress(latitude: lat, longitude: long)
        self.customLapSearchView.lAPSearchViewModel.lat = lat
        self.customLapSearchView.lAPSearchViewModel.lng = long
        self.customLapSearchView.lAPSearchViewModel.index = index

    }
    
}
