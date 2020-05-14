//
//  PharmacyOrderVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH
import SVProgressHUD

class PharmacyOrderVC: CustomBaseViewVC {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    
    lazy var customPharmacyOrderView:CustomPharmacyOrderView = {
        let v = CustomPharmacyOrderView()
        self.addValues()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.uploadView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenGallery)))
        v.nextButton.addTarget(self, action: #selector(handleBook), for: .touchUpInside)
        v.orderSegmentedView.didSelectItemWith = {[unowned self] (index, title) in
            switch index {
            case 0:
                self.makeFirstOption()
            case 1:
                
                self.makeSecondOption()
            default:
                self.makeLastOption()
            }
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
    lazy var customAlertLoginView:CustomAlertLoginView = {
        let v = CustomAlertLoginView()
        v.setupAnimation(name: "4970-unapproved-cross")
        v.handleOkTap = {[unowned self] in
            self.handleremoveLoginAlert()
        }
        return v
    }()
    
    var  api_token:String?
    var  patient_id:Int?
    var bubleViewHeightConstraint:NSLayoutConstraint!
    fileprivate let latt:Double!
    fileprivate let long:Double!
    
    fileprivate let insurance:Int!
    fileprivate let delivery:Int!
    
    init(latt:Double,lon:Double,insurance:Int,delivery:Int) {
        self.delivery=delivery
        self.insurance=insurance
        self.latt=latt
        self.long=lon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        check()
    }
    
    //MARK:-User methods
    
    func check()  {
        let order:[PharamcyOrderModel] = [PharamcyOrderModel(medicineID: 1, medicineTypeID: 1, amount: 1),
                                          .init(medicineID: 1, medicineTypeID: 1, amount: 1)
        ]
        
        DoctorServices.shared.postBookPharamacyResults(photo: #imageLiteral(resourceName: "star-1"), patient_id: 50, insurance: 0, delivery: 0,latt: 29.970245729247,lang: 29.970245729247,orderDetails: order, notes: "", api_token: "BrieOhmeR8CqML2RqBQDtXZWETE") { (base, err) in
            print(err)
        }
    }
    
    fileprivate  func addValues()  {
        customPharmacyOrderView.api_token=api_token;    customPharmacyOrderView.pharamacyOrderViewModel.lang=long
        customPharmacyOrderView.patient_id=patient_id;  customPharmacyOrderView.pharamacyOrderViewModel.latt=latt
        customPharmacyOrderView.latt=latt;              customPharmacyOrderView.pharamacyOrderViewModel.insurance=insurance
        customPharmacyOrderView.long=long;              customPharmacyOrderView.pharamacyOrderViewModel.delivery=delivery
        customPharmacyOrderView.insurance=insurance;    customPharmacyOrderView.pharamacyOrderViewModel.patient_id=patient_id
        customPharmacyOrderView.delivery=delivery;      customPharmacyOrderView.pharamacyOrderViewModel.api_token=api_token
    }
    
    fileprivate func makeFirstOption() {
        
        
        self.bubleViewHeightConstraint.constant = 900
        self.customPharmacyOrderView.pharamacyOrderViewModel.isSecondOpetion = false
        self.customPharmacyOrderView.pharamacyOrderViewModel.isFirstOpetion = true
        self.customPharmacyOrderView.makeTheseChanges(  hide: true, height: 800)
        self.customPharmacyOrderView.updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116"),tr: 0,tops: 186,bottomt:80,log: -48 ,centerImg: 250)
        self.customPharmacyOrderView.addLapCollectionVC.view.isHide(true)
        self.customPharmacyOrderView.mainView.isHide(true)
        
    }
    
    fileprivate func makeSecondOption() {
        self.bubleViewHeightConstraint.constant = 1000
        self.customPharmacyOrderView.pharamacyOrderViewModel.isSecondOpetion = true
        self.customPharmacyOrderView.pharamacyOrderViewModel.isFirstOpetion = false
        self.customPharmacyOrderView.addLapCollectionVC.medicineArray.count > 0 ?  self.customPharmacyOrderView.makeTheseChanges( hide: false, height: 1200) : self.customPharmacyOrderView.makeTheseChanges( hide: false, height: 800)
        self.customPharmacyOrderView.updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116"),tr: 0,tops: 186,bottomt:80,log: -48, centerImg: 100 )
        self.customPharmacyOrderView.mainView.isHide(false)
    }
    
    fileprivate func makeLastOption() {
        self.bubleViewHeightConstraint.constant = 1200
        self.customPharmacyOrderView.pharamacyOrderViewModel.isSecondOpetion = false
        self.customPharmacyOrderView.pharamacyOrderViewModel.isFirstOpetion = false
        self.customPharmacyOrderView.addLapCollectionVC.medicineArray.count > 0 ?  self.customPharmacyOrderView.makeTheseChanges( hide: false, height: 1200,all: false) : self.customPharmacyOrderView.makeTheseChanges( hide: false, height: 1000,all: false)
        self.customPharmacyOrderView.updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116-1"),tr: 60,tops: 80,bottomt:0,log: 0, centerImg: 100 )
        self.customPharmacyOrderView.mainView.isHide(false)
        
    }
    
    fileprivate func setupViewModelObserver()  {
        
        customPharmacyOrderView.pharamacyOrderViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customPharmacyOrderView.nextButton)
        }
        
        customPharmacyOrderView.pharamacyOrderViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isValid) in
            if isValid == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                SVProgressHUD.show(withStatus: "Booking...".localized)
                
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
        bubleViewHeightConstraint = mainView.heightAnchor.constraint(equalToConstant: 900)
        bubleViewHeightConstraint.isActive = true
        mainView.addSubViews(views: customPharmacyOrderView)
        customPharmacyOrderView.fillSuperview()
    }
    
    func hideOtherData()  {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            [self.customPharmacyOrderView.uploadView,self.customPharmacyOrderView.centerImage].forEach({$0.isHide(true)})
            self.customPharmacyOrderView.rosetaImageView.isHide(false)
        })
    }
    
    func presentAlert()  {
        
        customMainAlertVC.addCustomViewInCenter(views: customAlertLoginView, height: 200)
        customAlertLoginView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
        
    }
    
    func presentLogin()  {
        let login = LoginVC()
        login.delgate=self
        let nav = UINavigationController(rootViewController: login)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    //TODO: -handle methods
    
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleOpenGallery()  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    
    @objc func handleBook()  {
        if api_token == nil  {
            presentAlert()
        }else {
            customPharmacyOrderView.pharamacyOrderViewModel.performBooking { (base, err) in
                
             if let err = err {
                            SVProgressHUD.showError(withStatus: err.localizedDescription)
                            self.activeViewsIfNoData();return
                        }
                        SVProgressHUD.dismiss()
                        self.activeViewsIfNoData()
                        guard let message = base else {return }
            //            guard let user = base?.data else { self.createAlert(title: "Information", message: MOLHLanguage.isRTLLanguage() ? message.message : message.messageEn , style: .alert); return}
                        
                        DispatchQueue.main.async {
                            self.showToast(context: self, msg: (MOLHLanguage.isRTLLanguage() ? message.message : message.messageEn) ?? "")

//                            self.createAlert(title: "Information", message: (MOLHLanguage.isRTLLanguage() ? message.message : message.messageEn) ?? "" , style: .alert)
            //                self.dismiss(animated: true, completion: nil)
                            //                       self.saveToken(user_id: user.id,user.phone)
                        }
                    }
        }
    }
    
    @objc func handleDismiss()  {
        dismiss(animated: true, completion: nil)
    }
    
    func handleremoveLoginAlert()  {
        removeViewWithAnimation(vvv: customAlertLoginView)
        customMainAlertVC.dismiss(animated: true)
        presentLogin()
        
    }
    
}



//MARK:-Extension

extension PharmacyOrderVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    fileprivate func putDefaultViewModel(_ img: UIImage) {
        customPharmacyOrderView.pharamacyOrderViewModel.lang = long
        customPharmacyOrderView.pharamacyOrderViewModel.image = img
        
    }
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            customPharmacyOrderView.pharamacyOrderViewModel.image = img
            customPharmacyOrderView.rosetaImageView.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            
            customPharmacyOrderView.rosetaImageView.image = img
            customPharmacyOrderView.pharamacyOrderViewModel.image = img
            
            //            putDefaultViewModel(img)
        }
        
        hideOtherData()
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        customPharmacyOrderView.pharamacyOrderViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}

extension PharmacyOrderVC:LoginVCPrototcol {
    
    func useApiAndPatienId(api: String, patient: Int) {
        api_token = api
        patient_id=patient
        handleBack()
    }
}
