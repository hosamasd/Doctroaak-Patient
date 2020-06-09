//
//  DoctorListsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH
import SVProgressHUD

class DoctorListsVC: CustomBaseViewVC {
    
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
    lazy var customDoctorListsView:CustomDoctorListsView = {
        let v = CustomDoctorListsView()
        v.index = self.index
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.handleCheckedIndex = {[unowned self] spy in
            let vc = DoctorSearchVC(spy: spy, index: self.index)
            vc.patient=self.patient
            //            vc.patientApiToken=self.patientApiToken
            //            vc.patient_id=self.patient_id
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return v
    }()
    
    fileprivate let index:Int!
    init(index:Int) {
        self.index=index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var patient:PatienModel?{
        didSet{
            guard let patient = patient else { return  }
        }
    }
    //    var patient_id:Int?
    //    var patientApiToken:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSpecification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !ConnectivityInternet.isConnectedToInternet {
            showToast(context: self, msg: "No interntetI Connection".localized)
        }
    }
    
    
    func getSpecification()  {
        if userDefaults.bool(forKey: UserDefaultsConstants.isSpecificationsCached) {
            getData()
        }
    }
    
    func getData()  {
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        SVProgressHUD.show(withStatus: "Looding...".localized)
        MainServices.shared.getSpecificationss { (base, err) in
            if let err=err{
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let specificationsArray = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            self.customDoctorListsView.doctorListCollectionVC.specificationArray = specificationsArray
            
            DispatchQueue.main.async {
                self.customDoctorListsView.doctorListCollectionVC.collectionView.reloadData()
                
                self.view.layoutIfNeeded()
            }
        }
        
        
    }
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customDoctorListsView)
        customDoctorListsView.fillSuperview()
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
}
