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
        v.index=self.index
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
    lazy var customAlertLoginView:CustomAlertLoginView = {
        let v = CustomAlertLoginView()
        v.setupAnimation(name: "4970-unapproved-cross")
        v.handleOkTap = {[unowned self] in
            self.handleDismiss()
        }
        return v
    }()
    lazy var customMainAlertVC:CustomMainAlertVC = {
           let t = CustomMainAlertVC()
           t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
           t.modalTransitionStyle = .crossDissolve
           t.modalPresentationStyle = .overCurrentContext
           return t
       }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
           let v = CustomAlertMainLoodingView()
           v.setupAnimation(name: "heart_loading")
           return v
       }()
    
    fileprivate let specificationId:Int!
    fileprivate let index:Int!
    
    init(spy:Int,index:Int) {
        self.specificationId = spy
        self.index=index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        scrollView.delegate=self
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
//                SVProgressHUD.show(withStatus: "Searching...".localized)
                self.showMainAlertLooder()
            }else {
//                SVProgressHUD.dismiss()
                self.handleDismiss()

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
            let xc = placeMark.locality
            self.customDoctorSearchView.addressLabel.text =  xc ?? ""
            
            // Location name
            if let locationName = placeMark.addressDictionary!["Name"] as? String,let city = placeMark.addressDictionary!["City"] as? String ,let country = placeMark.addressDictionary!["Country"] as? String {
                self.customDoctorSearchView.addressLabel.text =  " \(locationName) - \(String(describing: city)) - \(String(describing: country))"
                
            }
        })
        
        
    }
    
    func goToNext(_ doctors:[PatientSearchDoctorsModel])  {
        
        let card = CardiologyDoctorsResultsVC(doctors:doctors,index: index)
        navigationController?.pushViewController(card, animated: true)
    }
    
    func showMainAlertLooder()  {
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingView, height: 200)
        customAlertMainLoodingView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSearch()  {
        customDoctorSearchView.doctorSearchViewModel.performDoctorSearching { (base, err) in
            if let err = err {
                //                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                
                self.activeViewsIfNoData();return
            }
//            SVProgressHUD.dismiss()
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.goToNext(user)
            }
            
            
            
            
        }
    }
    
    @objc func handleDismiss()  {
                 removeViewWithAnimation(vvv: customAlertMainLoodingView)
                 DispatchQueue.main.async {
                     self.dismiss(animated: true, completion: nil)
                 }
             }
}

//MARK:-Extensions

extension DoctorSearchVC: ChooseLocationVCProtocol {
    
    func getLatAndLong(lat: Double, long: Double) {
        convertLatLongToAddress(latitude: lat, longitude: long)
        self.customDoctorSearchView.doctorSearchViewModel.lat = lat
        self.customDoctorSearchView.doctorSearchViewModel.specificationId = self.specificationId
        
        self.customDoctorSearchView.doctorSearchViewModel.lng = long
        
        
    }
    
}


extension DoctorSearchVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        self.scrollView.isScrollEnabled = x < -60 ? false : true
        
    }
}
