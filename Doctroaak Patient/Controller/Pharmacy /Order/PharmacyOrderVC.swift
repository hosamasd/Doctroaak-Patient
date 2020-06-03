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
        //        v.api_token=self.api_token
        //        v.patient_id=self.patient_id
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.uploadView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createAlertForChoposingImage)))
        v.nextButton.addTarget(self, action: #selector(handleBook), for: .touchUpInside)
        v.orderSegmentedView.didSelectItemWith = {[unowned self] (index, title) in
            self.hideOrUndie(index: index)
        }
        v.handleRemovePharamcay={[unowned self] pharamacy,index in
            
            self.removePharamacy(pharamacy,index)
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
    
    //    fileprivate let latt:Double!
    //    fileprivate let long:Double!
    //
    //    fileprivate let insurance:Int!
    var pharmacy_id:Int?{
        didSet{
            guard let pharmacy_id = pharmacy_id else { return  }
            
            customPharmacyOrderView.pharmacy_id=pharmacy_id
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        //        check()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let id=userDefaults.integer(forKey: UserDefaultsConstants.patientID)
        guard let api = userDefaults.string(forKey: UserDefaultsConstants.patientAPITOKEN) else { return  }
        patient_id=id
        api_token=api
        //        customPharmacyOrderView.orderSegmentedView.selectItemAt(index: 0)
        //        self.view.layoutSubviews()
    }
    
    
    
    //MARK:-User methods
    
    
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
    
    func handleOpenGallery(sourceType:UIImagePickerController.SourceType)  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    //TODO: -handle methods
    
    @objc func createAlertForChoposingImage()  {
        let alert = UIAlertController(title: "Choose Image", message: "Choose image fROM ", preferredStyle: .alert)
        let camera = UIAlertAction(title: "Camera", style: .default) {[unowned self] (_) in
            self.handleOpenGallery(sourceType: .camera)
            
        }
        let gallery = UIAlertAction(title: "Open From Gallery", style: .default) {[unowned self] (_) in
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
        if api_token == nil && patient_id == nil  {
            presentAlert()
        }else {
            guard let api = api_token,let patientId = patient_id else { return  }
            customPharmacyOrderView.pharamacyOrderViewModel.api_token=api
            customPharmacyOrderView.pharamacyOrderViewModel.patient_id=patientId
            
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
    
    func removePharamacy(_ ph:PharamcyOrderModel,_ index:Int) {
        customPharmacyOrderView.addMedicineCollectionVC.medicineArray.remove(at: index)
        customPharmacyOrderView.pharamacyOrderViewModel.orderDetails?.remove(at: index)
        let indexxx = IndexPath(item: index, section: 0)
        
        customPharmacyOrderView.addMedicineCollectionVC.collectionView.deleteItems(at: [indexxx])
        DispatchQueue.main.async {
            self.customPharmacyOrderView.addMedicineCollectionVC.collectionView.reloadData()
        }
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
        
        //        hideOtherData()
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        customPharmacyOrderView.pharamacyOrderViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}

extension PharmacyOrderVC:LoginVCPrototcol {
    
    func useApiAndPatienId(patient: PatienModel) {
        
    }
    //    func useApiAndPatienId(api: String, patient: Int) {
    //        api_token = api
    //        patient_id=patient
    //        handleBook()
    //    }
}
