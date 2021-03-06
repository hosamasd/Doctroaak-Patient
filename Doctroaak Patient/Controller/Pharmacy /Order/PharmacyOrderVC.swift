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
        //                v.constrainHeight(constant: 1200)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    
    lazy var customPharmacyOrderView:CustomSecondPharmacyOrderView = {
        let v = CustomSecondPharmacyOrderView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.uploadView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createAlertForChoposingImage)))
        v.nextButton.addTarget(self, action: #selector(handleBook), for: .touchUpInside)
        v.orderSegmentedView.didSelectItemWith = {[unowned self] (index, title) in
            self.hideOrUndie(index: index)
        }
        v.handleRemovePharamcay = {[unowned self] arr , index in
            self.deleteThis(arr,index)
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
    lazy var customAlertSuccessView:CustomAlertSuccessView = {
        let v = CustomAlertSuccessView()
        v.setupAnimation(name: "4970-unapproved-cross")
        v.handleOkTap = {[unowned self] in
            self.handleOkSuccess()
        }
        return v
    }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    
    var patient:PatienModel?{
        didSet{
            guard let patient = patient else { return  }
            customPharmacyOrderView.patient=patient
        }
    }
    var  api_token:String?
    var  patient_id:Int?
    var bubleViewHeightConstraint:NSLayoutConstraint!
    
    var latt:Double!
    var long:Double!
    
    var insurance:Int!
    var delivery:Int!
    
    var pharmacy_id:Int?{
        didSet{
            guard let pharmacy_id = pharmacy_id else { return  }
            
            customPharmacyOrderView.pharmacy_id=pharmacy_id
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        scrollView.delegate=self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) {
            patient=cacheObjectCodabe.storedValue
            
        }else {}
    }
    
    
    //MARK:-User methods
    
    func deleteThis(_ ss:PharamcyOrderModel,_ index:IndexPath)  {
        customPharmacyOrderView.addMedicineCollectionVC.medicineArray.remove(at: index.item)
        customPharmacyOrderView.pharamacyOrderViewModel.orderDetails = customPharmacyOrderView.addMedicineCollectionVC.medicineArray
        DispatchQueue.main.async {
            self.customPharmacyOrderView.addMedicineCollectionVC.collectionView.reloadData()
        }
    }
    
    func hideOrUndie(index:Int)  {
        self.customPharmacyOrderView.pharamacyOrderViewModel.isFirstOpetion = index == 0 ? true : false
        self.customPharmacyOrderView.pharamacyOrderViewModel.isSecondOpetion = index == 1 ? true : false
        self.customPharmacyOrderView.pharamacyOrderViewModel.isThirdOpetion = index == 2 ? true : false
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {[unowned self] in
            self.customPharmacyOrderView.secondStack.isHide(index == 0 ? true : false)
            self.customPharmacyOrderView.orLabel.isHide(index == 2 ? false :  true)
            self.customPharmacyOrderView.firstStack.isHide(index == 1 ? true : false)
            self.bubleViewHeightConstraint.constant = index == 0 ? 900 : index == 1 ? 900 : 1500
            self.customPharmacyOrderView.textView.isHide(index == 2 ? false : true)
            
        })
    }
    
    fileprivate func setupViewModelObserver()  {
        
        customPharmacyOrderView.pharamacyOrderViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customPharmacyOrderView.nextButton)
        }
        
        customPharmacyOrderView.pharamacyOrderViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isValid) in
            if isValid == true {
//                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Booking...".localized)
                self.showMainAlertLooder()
            }else {
                //                SVProgressHUD.dismiss()
                //                self.handleDismiss()
                
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
    
    fileprivate func presentAlert()  {
        
        customMainAlertVC.addCustomViewInCenter(views: customAlertLoginView, height: 200)
        customAlertLoginView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
        
    }
    
    fileprivate func presentLogin()  {
        let login = LoginVC()
        login.delgate=self
        let nav = UINavigationController(rootViewController: login)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    fileprivate func handleOpenGallery(sourceType:UIImagePickerController.SourceType)  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    fileprivate func handleremoveLoginAlert()  {
        //        self.handleDismiss()
        removeViewWithAnimation(vvv: customAlertLoginView)
        customMainAlertVC.dismiss(animated: true)
        presentLogin()
        
    }
    
    fileprivate func presentSuccessAlert(txt:String)  {
        
        customMainAlertVC.addCustomViewInCenter(views: customAlertSuccessView, height: 200)
        customAlertSuccessView.problemsView.loopMode = .loop
        
        customAlertSuccessView.discriptionInfoLabel.text = txt
        present(customMainAlertVC, animated: true)
        
    }
    
    fileprivate  func showMainAlertLooder()  {
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingView, height: 200)
        customAlertMainLoodingView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        //        removeViewWithAnimation(vvv: customAlertSuccessView)
        removeViewWithAnimation(vvv: customAlertLoginView)
        
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //TODO: -handle methods
    
    @objc func createAlertForChoposingImage()  {
        let alert = UIAlertController(title: "Choose Image".localized, message: "Choose image fROM ".localized, preferredStyle: .alert)
        let camera = UIAlertAction(title: "Camera".localized, style: .default) {[unowned self] (_) in
            self.handleOpenGallery(sourceType: .camera)
            
        }
        let gallery = UIAlertAction(title: "Open From Gallery".localized, style: .default) {[unowned self] (_) in
            self.handleOpenGallery(sourceType: .photoLibrary)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) {[unowned self] (_) in
            alert.dismiss(animated: true)
        }
        
        alert.addAction(camera)
        alert.addAction(gallery)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    @objc func handleBook()  {
        if patient == nil  {
            presentAlert()
            //        if api_token == nil && patient_id == nil  {
            //            presentAlert()
        }else {
            //            guard let api = api_token,let patientId = patient_id else { return  }
            guard let patient = patient else { return  }
            
            customPharmacyOrderView.pharamacyOrderViewModel.api_token=patient.apiToken
            customPharmacyOrderView.pharamacyOrderViewModel.patient_id=patient.id
            
            customPharmacyOrderView.pharamacyOrderViewModel.performBooking { (base, err) in
                
                if let err = err {
                    //                    SVProgressHUD.showError(withStatus: err.localizedDescription)
                    self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                    
                    self.activeViewsIfNoData();return
                }
                //                SVProgressHUD.dismiss()
                self.handleDismiss()
                self.activeViewsIfNoData()
                guard let message = base else {return }
                let ar = message.message ?? message.messageEn ?? ""
                
                
                DispatchQueue.main.async {
                    self.presentSuccessAlert(txt: ar )
                }
            }
        }
    }
    
    
    @objc func handleOkSuccess()  {
        //        removeViewWithAnimation(vvv: customAlertLoginView)
        removeViewWithAnimation(vvv: customAlertSuccessView)
        //
        customMainAlertVC.dismiss(animated: true)
        //        handleDismiss()
        let orders = ProfileOrdersVC(isFromOrder: true)
        navigationController?.pushViewController(orders, animated: true)
        
    }
    
}



//MARK:-Extension

extension PharmacyOrderVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    fileprivate func putDefaultViewModel(_ img: UIImage) {
        customPharmacyOrderView.pharamacyOrderViewModel.lang = long
        customPharmacyOrderView.pharamacyOrderViewModel.image = img
        
    }
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if var img = info[.originalImage]  as? UIImage   {
            let jpegData = img.jpegData(compressionQuality: 1.0)
            let jpegSize: Int = jpegData?.count ?? 0
            img = (jpegSize > 30000 ? img.resized(toWidth: 1300) : img) ?? img
            
            customPharmacyOrderView.pharamacyOrderViewModel.image = img
            customPharmacyOrderView.rosetaImageView.image = img
        }
        if var img = info[.editedImage]  as? UIImage   {
            let jpegData = img.jpegData(compressionQuality: 1.0)
            let jpegSize: Int = jpegData?.count ?? 0
            img = (jpegSize > 30000 ? img.resized(toWidth: 1300) : img) ?? img
            
            customPharmacyOrderView.rosetaImageView.image = img
            customPharmacyOrderView.pharamacyOrderViewModel.image = img
            
            //            putDefaultViewModel(img)
        }
        if let url = info[.imageURL] as? URL {
            let fileName = url.lastPathComponent
            customPharmacyOrderView.uploadLabel.text = fileName
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        customPharmacyOrderView.pharamacyOrderViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}

extension PharmacyOrderVC:LoginVCPrototcol {
    
    func useApiAndPatienId(patient: PatienModel) {
        self.patient=patient
    }
}


extension PharmacyOrderVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        self.scrollView.isScrollEnabled = x < -60 ? false : true
        
    }
}
