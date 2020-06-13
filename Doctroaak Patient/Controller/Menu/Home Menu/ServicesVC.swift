//
//  ServicesVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ServicesVC: CustomBaseViewVC {
    
    lazy var customMainServicesView:CustomMainServicesView = {
        let v = CustomMainServicesView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.main1View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenVC)))
        v.main2View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenMedicalVC)))
        v.main3View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpen2VC)))
        v.main4View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpen3VC)))
        v.main5View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpen4VC)))
        v.main6View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpen5VC)))
        v.main7View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpen6VC)))
        
        
        return v
    }()
    lazy var views = [
        customMainServicesView.main1View,customMainServicesView.main2View,customMainServicesView.main3View,customMainServicesView.main4View,
        customMainServicesView.main5View,customMainServicesView.main6View,customMainServicesView.main7View
    ]
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1000)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    //    var patient_id:Int?
    //    var patientApiToken:String?
    var patient:PatienModel?{
        didSet{
            guard let patient = patient else { return  }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAnimation()
        
        if userDefaults.bool(forKey: UserDefaultsConstants.isPatientLogin) {
            patient=cacheObjectCodabe.storedValue
        }else{}
    }
    
    //MARK: -user methods
    
    
    
    fileprivate func setupAnimation()  {
        views.forEach({$0.alpha = 1})
        
        let translateTransform = CGAffineTransform.init(translationX: 1000, y: 0)
        let translateButtons = CGAffineTransform.init(translationX: -1000, y: 0)
        
        [ customMainServicesView.main1View, customMainServicesView.main3View,customMainServicesView.main5View,customMainServicesView.main7View].forEach({$0.transform = translateButtons})
        [ customMainServicesView.main2View, customMainServicesView.main4View,customMainServicesView.main6View].forEach({$0.transform = translateTransform})
        UIView.animate(withDuration: 0.7, delay: 0.6, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            [self.customMainServicesView.main1View, self.customMainServicesView.main3View,self.customMainServicesView.main5View,self.customMainServicesView.main7View,self.customMainServicesView.main2View, self.customMainServicesView.main4View,self.customMainServicesView.main6View].forEach({$0.transform = .identity})
        })
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubview(customMainServicesView)
        customMainServicesView.fillSuperview()
        
    }
    
   fileprivate func goToNextVC(vc:CustomBaseViewVC,indexx:Int)  {
        //        vc.index = indexx
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //TODO:-Hnadle methods
    
    @objc  func handleOpenVC()  {
        let doc = DoctorListsVC(index: 0)
        navigationController?.pushViewController(doc, animated: true)
        
    }
    
    @objc  func handleOpenMedicalVC()  {
        let doc = DoctorListsVC(index: 1)
        navigationController?.pushViewController(doc, animated: true)
        
    }
    
    
    @objc  func handleOpen2VC()  {
        let phar = PharmacyLocationVC()
        navigationController?.pushViewController(phar, animated: true)
        
    }
    
    @objc  func handleOpen3VC()  {
        let lab = LapSearchVC(index: 0)
        navigationController?.pushViewController(lab, animated: true)
        
    }
    
    @objc  func handleOpen4VC()  {
        let lab = LapSearchVC(index: 1) //for Rediology
        navigationController?.pushViewController(lab, animated: true)
        
    }
    
    @objc  func handleOpen5VC()  {
        //        let doc = IncubationSearchVC()
        //        navigationController?.pushViewController(doc, animated: true)
        let doc = ICUSearchVC(index: 0)
        navigationController?.pushViewController(doc, animated: true)
    }
    
    
    @objc  func handleOpen6VC()  {
        let doc = ICUSearchVC(index: 1)
        navigationController?.pushViewController(doc, animated: true)
        
    }
    
    @objc func handleBack()  {
        dismiss(animated: true)
        //        navigationController?.popViewController(animated: true)
    }
    
}
