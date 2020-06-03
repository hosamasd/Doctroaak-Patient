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
        v.handleLABCheckedIndex = {[unowned self] lab in 
            
        }
        v.handlePharmacyCheckedIndex = {[unowned self] lab in
            
        }
        
        v.handleRadCheckedIndex = {[unowned self] lab in
            
        }
        
        v.handleDoctorCheckedIndex = {[unowned self] lab in
            
        }
        v.handleCheckedIndexForButtons = {[unowned self] index in
            self.goToSpecificButton(index)
        }
        return v
    }()
    lazy var mainBottomView:UIView = {
        let v = UIView(backgroundColor: .red)
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDoctors)))
        
        //        v.addSubview(customBottomOrdersView)
        //        v.stack(customBottomOrdersView)
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
    
    
    
    var patient:PatienModel?{
        didSet{
            guard let patient = patient else { return  }
            //               customMainHomeView.patient=patient
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        fetchAllOrders()
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
                       // uget citites
                    
    //                PatientProfileSservicea.shared.getDoctorsOrders(patient_id: patient.id, api_token: patient.apiToken, completion:  { (base, err) in
    //                    groupPY = base?.data
    //                       semaphore.signal()
    //                   })
    //                   semaphore.wait()
                       
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
                        self.customProfileOrdersView.labProfileOrderCollectionVC.pharamacyArray=lab
            }
            if let rad = rad {
                        self.customProfileOrdersView.radiologyProfileOrderCollectionVC.pharamacyArray=rad
            }
            if let pha = phara {
                        self.customProfileOrdersView.pharamacyProfileOrderCollectionVC.pharamacyArray=pha
            }
            if let doc = doctor {
                        self.customProfileOrdersView.doctorProfileOrderCollectionVC.pharamacyArray=doc
            }
            
            DispatchQueue.main.async {
                self.customProfileOrdersView.labProfileOrderCollectionVC.collectionView.reloadData()
                self.customProfileOrdersView.radiologyProfileOrderCollectionVC.collectionView.reloadData()
                self.customProfileOrdersView.pharamacyProfileOrderCollectionVC.collectionView.reloadData()
                self.customProfileOrdersView.doctorProfileOrderCollectionVC.collectionView.reloadData()

            }
        }
    
    func hideAndUnhide(FIRv:UIView,TTv:[UIView],v:UILabel,vv:[UILabel],img:UIImageView,otherImage:[UIImageView],vcss:[UIView],singleVC:UIView)  {
        
        DispatchQueue.main.async {
            v.isHide(false)
            FIRv.backgroundColor = #colorLiteral(red: 0.9275586605, green: 0.8786675334, blue: 1, alpha: 1)
            TTv.forEach({$0.backgroundColor = UIColor.lightGray})
            img.image?.withRenderingMode(.alwaysTemplate)
            otherImage.forEach({$0.image?.withRenderingMode(.alwaysOriginal)})
            vv.forEach({$0.isHide(true)})
            singleVC.isHide(false)
            vcss.forEach({$0.isHide(true)})
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
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDoctors()  {
        let sss = [customProfileOrdersView.radiologyProfileOrderCollectionVC.collectionView!,customProfileOrdersView.labProfileOrderCollectionVC.collectionView!,customProfileOrdersView.pharamacyProfileOrderCollectionVC.collectionView!]
        let zxc = customProfileOrdersView.doctorProfileOrderCollectionVC.collectionView!
        
        
        hideAndUnhide(FIRv:customBottomOrdersView.firstView,TTv:[customBottomOrdersView.secondView,customBottomOrdersView.thirdView,customBottomOrdersView.forthView],v: customBottomOrdersView.doctorLabel, vv: [customBottomOrdersView.labLabel,customBottomOrdersView.radiologyLabel,customBottomOrdersView.pharamacyLabel], img: customBottomOrdersView.firstImage, otherImage: [customBottomOrdersView.secondImage,customBottomOrdersView.thirdImage,customBottomOrdersView.forthImage],vcss: sss,singleVC: zxc)
    }
    
    @objc func handlePharamcys()  {
        let sss = [customProfileOrdersView.radiologyProfileOrderCollectionVC.collectionView!,customProfileOrdersView.labProfileOrderCollectionVC.collectionView!,customProfileOrdersView.doctorProfileOrderCollectionVC.collectionView!]
        let zxc = customProfileOrdersView.pharamacyProfileOrderCollectionVC.collectionView!
        
        hideAndUnhide(FIRv:customBottomOrdersView.secondView,TTv:[customBottomOrdersView.firstView,customBottomOrdersView.thirdView,customBottomOrdersView.forthView],v: customBottomOrdersView.pharamacyLabel, vv: [customBottomOrdersView.labLabel,customBottomOrdersView.radiologyLabel,customBottomOrdersView.doctorLabel], img: customBottomOrdersView.secondImage, otherImage: [customBottomOrdersView.firstImage,customBottomOrdersView.thirdImage,customBottomOrdersView.forthImage],vcss: sss,singleVC: zxc)
    }
    
    @objc func handleLabs()  {
        let sss = [customProfileOrdersView.radiologyProfileOrderCollectionVC.collectionView!,customProfileOrdersView.doctorProfileOrderCollectionVC.collectionView!,customProfileOrdersView.pharamacyProfileOrderCollectionVC.collectionView!]
        let zxc = customProfileOrdersView.labProfileOrderCollectionVC.collectionView!
        
        hideAndUnhide(FIRv:customBottomOrdersView.thirdView,TTv:[customBottomOrdersView.secondView,customBottomOrdersView.firstView,customBottomOrdersView.forthView],v: customBottomOrdersView.labLabel, vv: [customBottomOrdersView.doctorLabel,customBottomOrdersView.radiologyLabel,customBottomOrdersView.pharamacyLabel], img: customBottomOrdersView.thirdImage, otherImage: [customBottomOrdersView.secondImage,customBottomOrdersView.firstImage,customBottomOrdersView.forthImage],vcss: sss,singleVC: zxc)
    }
    
    @objc func handleRadiologys()  {
        let sss = [customProfileOrdersView.doctorProfileOrderCollectionVC.collectionView!,customProfileOrdersView.labProfileOrderCollectionVC.collectionView!,customProfileOrdersView.pharamacyProfileOrderCollectionVC.collectionView!]
        let zxc = customProfileOrdersView.radiologyProfileOrderCollectionVC.collectionView!
        
        hideAndUnhide(FIRv:customBottomOrdersView.forthView,TTv:[customBottomOrdersView.secondView,customBottomOrdersView.thirdView,customBottomOrdersView.firstView],v: customBottomOrdersView.radiologyLabel, vv: [customBottomOrdersView.labLabel,customBottomOrdersView.doctorLabel,customBottomOrdersView.pharamacyLabel], img: customBottomOrdersView.forthImage, otherImage: [customBottomOrdersView.secondImage,customBottomOrdersView.thirdImage,customBottomOrdersView.firstImage],vcss: sss,singleVC: zxc)
    }
    
    
    
}
