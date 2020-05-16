//
//  DeatilsVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class DeatilsSelectedDoctorsVC: UIViewController {
    
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
    lazy var customDetailsView:CustomDetailsView = {
        let v = CustomDetailsView()
        v.patientApiToken=patientApiToken
        v.patient_id=patient_id
        v.selectedDoctor=selectedDoctor
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.bookButton.addTarget(self, action: #selector(handleBook), for: .touchUpInside)
        return v
    }()
    
    var patient_id:Int?
    var patientApiToken:String?
    fileprivate let selectedDoctor:PatientSearchDoctorsModel!
    init(doctors:PatientSearchDoctorsModel) {
        self.selectedDoctor=doctors
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
    }
    
    
    func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customDetailsView)
        customDetailsView.fillSuperview()
        
        
        
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleBook()  {
       
        
        guard let apiTpken = patientApiToken,let patientId=patient_id, let clinic_id = selectedDoctor.workingHours.first?.clinicID else { return  }
        let book = DoctorBookVC(clinic_id: clinic_id, patient_id: patientId, api_token: apiTpken)
        navigationController?.pushViewController(book, animated: true)
        
    }
}