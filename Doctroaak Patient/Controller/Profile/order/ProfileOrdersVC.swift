//
//  ProfileOrdersVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

class ProfileOrdersVC: CustomBaseViewVC {
    
    lazy var customProfileOrdersView:CustomProfileOrdersView = {
        let v = CustomProfileOrdersView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.handleLABCheckedIndex = {[unowned self] lab,ind in
            print(ind.item)
            
            self.createAlert(indexx:ind,ind:2,order_id: lab.id, message: "LAB")
        }
        v.handlePharmacyCheckedIndex = {[unowned self] lab,ind in
            print(ind.item)
            
            self.createAlert(indexx:ind,ind:1,order_id: lab.id, message: "PHARMACY")
        }
        
        v.handleRadCheckedIndex = {[unowned self] lab,ind in
            print(ind.item)
            
            self.createAlert(indexx:ind,ind:3,order_id: lab.id, message: "RADIOLOGY")
        }
        
        v.handleDoctorCheckedIndex = {[unowned self] lab,ind in
            print(ind.item)
            self.createAlert(indexx:ind,ind:0,order_id: lab.id, message: "DOCTOR")
        }
        v.handleCheckedIndexForButtons = {[unowned self] index in
            self.goToSpecificButton(index)
        }
        v.handleCheckedIOpenImage = {[unowned self] img in
            let preview = ZoomUserImageVC(img: img)
            self.navigationController?.pushViewController(preview, animated: true)
        }
        v.handleRateIndex = {[unowned self] doctor in
            self.presentStarsView(doctor)
        }
        return v
    }()
    lazy var customStarView:CustomStarView = {
        let v = CustomStarView()
        v.closeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveStars)))
        v.doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        return v
    }()
    lazy var customMainAlertVC:CustomMainAlertVC = {
        let t = CustomMainAlertVC()
        t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    lazy var mainBottomView:UIView = {
        let v = UIView(backgroundColor: .red)
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDoctors)))
        
        return v
    }()
    lazy var customBottomOrdersView:CustomBottomOrdersView = {
        let v = CustomBottomOrdersView()
        v.firstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDoctors)))
        v.secondView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePharamcys)))
        v.thirdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLabs)))
        v.forthView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRadiologys)))
        
        return v
    } ()
    lazy var textView = UITextView(frame: CGRect.zero)
    
    
    
    var patient:PatienModel?{
        didSet{
            guard let patient = patient else { return  }
            //               customMainHomeView.patient=patient
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) {
                        patient = cacheObjectCodabe.storedValue
  }else {}
        fetchAllOrders()
    }
    
    
    
    
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        
        view.addSubViews(views: customProfileOrdersView,customBottomOrdersView)
        customProfileOrdersView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 50, right: 0))
        customBottomOrdersView.anchor(top: customProfileOrdersView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    func fetchAllOrders()  {
        patient=cacheObjectCodabe.storedValue
        guard let patient = patient else { return  }
        
        var groupR :[LABOrderPatientModel]?
        var groupMN :[RadiologyOrderPatientModel]?
        var groupMTY :[PharamacyOrderPatientModel]?
        var groupPY :[DoctorsOrderPatientModel]?
        
        
        
        SVProgressHUD.show(withStatus: "Looding...".localized)
        let semaphore = DispatchSemaphore(value: 0)
        
        let dispatchQueue = DispatchQueue.global(qos: .background)
        
        
        dispatchQueue.async {
            PatientProfileSservicea.shared.getDoctorsOrders(patient_id: patient.id, api_token: patient.apiToken, completion:  { (base, err) in
                groupPY = base?.data
                semaphore.signal()
            })
            semaphore.wait()
            
            PatientProfileSservicea.shared.getRadiologyOrders(patient_id: patient.id, api_token: patient.apiToken, completion: { (base, err) in
                groupMN = base?.data
                semaphore.signal()
            })
            semaphore.wait()
            
            PatientProfileSservicea.shared.getPharamacyOrders (patient_id: patient.id, api_token: patient.apiToken, completion: { (base, err) in
                groupMTY = base?.data
                semaphore.signal()
            })
            semaphore.wait()
            
            //get areas
            PatientProfileSservicea.shared.getLABOrders (patient_id: patient.id, api_token: patient.apiToken, completion: { (base, err) in
                groupR = base?.data
                semaphore.signal()
            })
            semaphore.wait()
            
            
            
            
            semaphore.signal()
            self.reloadMainData(groupR,groupMN,groupMTY,groupPY)
            semaphore.wait()
        }
        
    }
    
    func reloadMainData(_ lab:[LABOrderPatientModel]?,_ rad:[RadiologyOrderPatientModel]?,_ phara:[PharamacyOrderPatientModel]?,_ doctor:[DoctorsOrderPatientModel]? )  {
        SVProgressHUD.dismiss()
        
        if let lab = lab {
            self.customProfileOrdersView.mainOrdersCollectionVC.labArray=lab
        }
        if let rad = rad {
            self.customProfileOrdersView.mainOrdersCollectionVC.radArray=rad
        }
        if let pha = phara {
            self.customProfileOrdersView.mainOrdersCollectionVC.pharamacyArray=pha
        }
        if let doc = doctor {
            self.customProfileOrdersView.mainOrdersCollectionVC.doctorArray=doc
        }
        
        DispatchQueue.main.async {
            self.customProfileOrdersView.mainOrdersCollectionVC.collectionView.reloadData()
            
        }
    }
    
    func hideAndUnhide(FIRv:UIView,TTv:[UIView],v:UILabel,vv:[UILabel],img:UIImageView,otherImage:[UIImageView]){
        DispatchQueue.main.async {
            v.isHide(false)
            FIRv.backgroundColor = #colorLiteral(red: 0.9275586605, green: 0.8786675334, blue: 1, alpha: 1)
            TTv.forEach({$0.backgroundColor = UIColor.lightGray})
            img.image?.withRenderingMode(.alwaysTemplate)
            otherImage.forEach({$0.image?.withRenderingMode(.alwaysOriginal)})
            vv.forEach({$0.isHide(true)})
            
        }
        
    }
    
    
    func goToSpecificButton(_ index:Int)  {
        if index == 0 {
            handleDoctors()
        }else if index == 1{
            handlePharamcys()
        }else if index == 2 {
            handleLabs()
        }else {
            handleRadiologys()
        }
    }
    
    func presentStarsView(_ doctor:DoctorsOrderPatientModel)  {
        guard let type =  doctor.type.toInt() else { return  }
        customMainAlertVC.addCustomViewInCenter(views: customStarView, height: 200)
        customStarView.type = type
        customStarView.doctor_id = doctor.id
        present(customMainAlertVC, animated: true)
    }
    
    @objc  func handleBack()  {
        dismiss(animated: true)
//        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDoctors()  {
        hideAndUnhide(FIRv:customBottomOrdersView.firstView,TTv:[customBottomOrdersView.secondView,customBottomOrdersView.thirdView,customBottomOrdersView.forthView],v: customBottomOrdersView.doctorLabel, vv: [customBottomOrdersView.labLabel,customBottomOrdersView.radiologyLabel,customBottomOrdersView.pharamacyLabel], img: customBottomOrdersView.firstImage, otherImage: [customBottomOrdersView.secondImage,customBottomOrdersView.thirdImage,customBottomOrdersView.forthImage])
        secollToItem(indexNumber: 0)
        
    }
    
    func secollToItem(indexNumber:Int)  {
        let index = IndexPath(item: indexNumber, section: 0)
        
        customProfileOrdersView.mainOrdersCollectionVC.collectionView.scrollToItem(at: index, at: .right, animated: true)
    }
    
    func createAlert(indexx:IndexPath,ind:Int,order_id:Int,message:String)  {
        let alertController = UIAlertController(title: "Feedback \n\n\n\n\n", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (action) in
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        }
        alertController.addAction(cancelAction)
        
        let saveAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            let enteredText = self.textView.text
            self.makeActionForCancel(indexx:indexx,ind:ind,order_id:order_id,message:enteredText ?? "",type: message)
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        }
        alertController.addAction(saveAction)
        
        alertController.view.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)
        textView.backgroundColor = UIColor.white
        textView.textContainerInset = UIEdgeInsets.init(top: 8, left: 5, bottom: 8, right: 5)
        alertController.view.addSubview(self.textView)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func makeActionForCancel(indexx:IndexPath,ind:Int,order_id:Int,message:String,type:String)  {
        guard let patient = patient else { return  }
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        SVProgressHUD.show(withStatus: "looding...".localized)
        CanceOrdersServices.shared.cancelOrder(patient_id:patient.id,api_token: patient.apiToken, order_id: order_id, order_type: type, message: message) { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base else {return}
            let mess = MOLHLanguage.isRTLLanguage() ? user.message : user.messageEn
            
            
            DispatchQueue.main.async {
                self.removeItem(ind: ind, indexx: indexx)
                self.showToast(context: self, msg: mess)
            }        }
    }
    
    func removeItem(ind:Int,indexx:IndexPath)  {
        if ind == 0 {
            customProfileOrdersView.mainOrdersCollectionVC.doctorArray.remove(at: indexx.item)
        }else if ind == 1 {
            customProfileOrdersView.mainOrdersCollectionVC.pharamacyArray.remove(at: indexx.item)
        }else if ind == 2 {
            customProfileOrdersView.mainOrdersCollectionVC.labArray.remove(at: indexx.item)
        }else {
            customProfileOrdersView.mainOrdersCollectionVC.radArray.remove(at: indexx.item)
        }
        customProfileOrdersView.mainOrdersCollectionVC.collectionView.reloadData()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bounds"{
            if let rect = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.cgRectValue {
                let margin: CGFloat = 8
                let xPos = rect.origin.x + margin
                let yPos = rect.origin.y + 54
                let width = rect.width - 2 * margin
                let height: CGFloat = 90
                
                textView.frame = CGRect.init(x: xPos, y: yPos, width: width, height: height)
            }
        }
    }
    
    @objc func handlePharamcys()  {
        hideAndUnhide(FIRv:customBottomOrdersView.secondView,TTv:[customBottomOrdersView.firstView,customBottomOrdersView.thirdView,customBottomOrdersView.forthView],v: customBottomOrdersView.pharamacyLabel, vv: [customBottomOrdersView.labLabel,customBottomOrdersView.radiologyLabel,customBottomOrdersView.doctorLabel], img: customBottomOrdersView.secondImage, otherImage: [customBottomOrdersView.firstImage,customBottomOrdersView.thirdImage,customBottomOrdersView.forthImage])
        secollToItem(indexNumber: 1)
        
    }
    
    @objc func handleLabs()  {
        hideAndUnhide(FIRv:customBottomOrdersView.thirdView,TTv:[customBottomOrdersView.secondView,customBottomOrdersView.firstView,customBottomOrdersView.forthView],v: customBottomOrdersView.labLabel, vv: [customBottomOrdersView.doctorLabel,customBottomOrdersView.radiologyLabel,customBottomOrdersView.pharamacyLabel], img: customBottomOrdersView.thirdImage, otherImage: [customBottomOrdersView.secondImage,customBottomOrdersView.firstImage,customBottomOrdersView.forthImage])
        secollToItem(indexNumber: 2)
        
    }
    
    @objc func handleRadiologys()  {
        hideAndUnhide(FIRv:customBottomOrdersView.forthView,TTv:[customBottomOrdersView.secondView,customBottomOrdersView.thirdView,customBottomOrdersView.firstView],v: customBottomOrdersView.radiologyLabel, vv: [customBottomOrdersView.labLabel,customBottomOrdersView.doctorLabel,customBottomOrdersView.pharamacyLabel], img: customBottomOrdersView.forthImage, otherImage: [customBottomOrdersView.secondImage,customBottomOrdersView.thirdImage,customBottomOrdersView.firstImage])
        secollToItem(indexNumber: 3)
        
    }
    
    @objc   func handleDismissKeyboard()  {
        view.endEditing(true)
    }
    
    @objc  func handleDismiss()  {
        dismiss(animated: true)
    }
    @objc func handleRemoveStars()  {
        removeViewWithAnimation(vvv: customStarView)
        customMainAlertVC.dismiss(animated: true)
        
    }
    @objc  func handleDone()  {
        print(customStarView.rating)
        let rate = Int(customStarView.rating)
        guard let patient = patient else {handleRemoveStars(); return  }
        UIApplication.shared.beginIgnoringInteractionEvents()

        SVProgressHUD.show(withStatus: "Rating...")
        PatientProfileSservicea.shared.rateDoctors(patient_id: patient.id, doctor_id: customStarView.doctor_id, api_token: patient.apiToken, type: customStarView.type, rate: rate) { (base, err) in
            
        if let err = err {
                       SVProgressHUD.showError(withStatus: err.localizedDescription)
            self.activeViewsIfNoData();self.handleRemoveStars();return
                   }
                   SVProgressHUD.dismiss()
                   self.activeViewsIfNoData()
            guard let use = base else {self.handleRemoveStars();return}
            let me = MOLHLanguage.isRTLLanguage() ? use.message : use.messageEn
            
            DispatchQueue.main.async {
                self.showToast(context: self, msg: me)
                self.handleRemoveStars()
            }
    }
    }
    
}
