//
//  DoctorBookVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import SVProgressHUD
import MOLH

class DoctorBookVC: CustomBaseViewVC {
    
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
    lazy var cusomDoctorBookView:CusomDoctorBookView = {
        let v = CusomDoctorBookView()
        v.patient_id = patient_id ?? 0
        v.api_token = api_token ?? ""
        v.clinic_id = clinic_id
        v.bookButton.addTarget(self, action: #selector(handleBook), for: .touchUpInside)
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
    //    fileprivate let api_token:String!
    //    fileprivate let patient_id:Int!
    fileprivate let clinic_id:Int!
    
    init(clinic_id:Int) {
        //        self.api_token=api_token
        self.clinic_id=clinic_id
        //        self.patient_id=patient_id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let id=userDefaults.integer(forKey: UserDefaultsConstants.patientID)
        guard let api = userDefaults.string(forKey: UserDefaultsConstants.patientAPITOKEN) else { return  }
    patient_id=id
        api_token=api
    }
    

    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        
        cusomDoctorBookView.doctorBookViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.cusomDoctorBookView.bookButton)
        }
        
        cusomDoctorBookView.doctorBookViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isValid) in
            if isValid == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                SVProgressHUD.show(withStatus: "Waitting...".localized)
                
            }else {
                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
            }
        })
    }
    
    override  func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        //        mainView.fillSuperview()
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: cusomDoctorBookView)
        cusomDoctorBookView.fillSuperview()
        
        
        
    }
    
    func getNotes() ->String {
        guard let name = cusomDoctorBookView.doctorBookViewModel.fullName,let  mobile = cusomDoctorBookView.mobileNumberTextField.text ,let isMale = cusomDoctorBookView.doctorBookViewModel.isMale,let age = cusomDoctorBookView.ageTextField.text  else { return "" }
        let ss = ","
        
        return name+ss+mobile+ss+age+ss+isMale
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
    
    @objc func handleDismiss()  {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleBook()  {
        if api_token == nil && patient_id==nil {
            presentAlert()
            
        }else {
            guard let api = api_token,let patientId = patient_id else { return  }
            cusomDoctorBookView.doctorBookViewModel.api_token=api
            cusomDoctorBookView.doctorBookViewModel.patient_id=patientId
            cusomDoctorBookView.doctorBookViewModel.performBooking(notessss: getNotes()) { (base, err) in
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
                    //                self.createAlert(title: "Information", message: (MOLHLanguage.isRTLLanguage() ? message.message : message.messageEn) ?? "" , style: .alert)
                    //                self.dismiss(animated: true, completion: nil)
                    //                       self.saveToken(user_id: user.id,user.phone)
                }
            }
        }
    }
    
    
    func handleremoveLoginAlert()  {
        removeViewWithAnimation(vvv: customAlertLoginView)
        customMainAlertVC.dismiss(animated: true)
        presentLogin()
        
    }
    
}

extension DoctorBookVC: LoginVCPrototcol {
    
    func useApiAndPatienId(api: String, patient: Int) {
        api_token = api
        patient_id=patient
        handleBook()
    }
}
