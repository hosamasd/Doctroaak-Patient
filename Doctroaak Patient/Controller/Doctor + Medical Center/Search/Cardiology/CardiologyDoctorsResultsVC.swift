//
//  CardiologyVC.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CardiologyDoctorsResultsVC: UIViewController {
    
    lazy var customCardiologyDoctorsResultsView:CustomCardiologyDoctorsResultsView = {
        let v = CustomCardiologyDoctorsResultsView()
        v.doctorsArray=doctorsArray
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        
        v.handleCheckedIndex = {[unowned self] doctor in
            let cDetails = DeatilsSelectedDoctorsVC(doctors: doctor)
            cDetails.patientApiToken=self.patientApiToken
            cDetails.patient_id=self.patient_id
            self.navigationController?.pushViewController(cDetails, animated: true)
        }
        v.handleBookmarkDoctor = {[unowned self] doctor in
            print(999)
        }
        return v
    }()
    
    var patient_id:Int?
    var patientApiToken:String?
    fileprivate let doctorsArray:[PatientSearchDoctorsModel]!
    init(doctors:[PatientSearchDoctorsModel]) {
        self.doctorsArray=doctors
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
        view.addSubview(customCardiologyDoctorsResultsView)
        customCardiologyDoctorsResultsView.fillSuperview()
    }
    
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
}
