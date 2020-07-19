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
        v.constrainHeight(constant: 1000)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var cusomDoctorBookView:CusomDoctorBookView = {
        let v = CusomDoctorBookView()
        v.clinic_id = clinic_id
        v.index=index
        v.bookButton.addTarget(self, action: #selector(handleBook), for: .touchUpInside)
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
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
            guard let patient = cacheObjectCodabe.storedValue else { return  }
            cusomDoctorBookView.patient=patient
        }
    }
    
    fileprivate let index:Int!

    fileprivate let clinic_id:Int!
    
    init(clinic_id:Int,index:Int) {
        self.index=index
        self.clinic_id=clinic_id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func setupViewModelObserver()  {
        
        cusomDoctorBookView.doctorBookViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.cusomDoctorBookView.bookButton)
        }
        
        cusomDoctorBookView.doctorBookViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isValid) in
            if isValid == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
//                SVProgressHUD.show(withStatus: "Booking...".localized)
                self.showMainAlertLooder()
            }else {
//                SVProgressHUD.dismiss()
                self.handleDismiss()

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
    
    func presentAlert(vvv:UIView)  {
        
        customMainAlertVC.addCustomViewInCenter(views: vvv, height: 200)
        customAlertLoginView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
        
    }
    
    func presentSuccessAlert(txt:String)  {
          
          customMainAlertVC.addCustomViewInCenter(views: customAlertSuccessView, height: 200)
        customAlertSuccessView.discriptionInfoLabel.text = txt
          customAlertSuccessView.problemsView.loopMode = .loop
          present(customMainAlertVC, animated: true)
          
      }
    
    func presentLogin()  {
        let login = LoginVC()
        login.delgate=self
        let nav = UINavigationController(rootViewController: login)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func handleremoveLoginAlert()  {
        removeViewWithAnimation(vvv: customAlertLoginView)
        customMainAlertVC.dismiss(animated: true)
        presentLogin()
        
    }
    
    func showMainAlertLooder()  {
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingView, height: 200)
        customAlertMainLoodingView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
    }
    
    //TODO:-Handle methods
    
    @objc func handleDismiss()  {
              removeViewWithAnimation(vvv: customAlertMainLoodingView)
        removeViewWithAnimation(vvv: customAlertLoginView)

              DispatchQueue.main.async {
                  self.dismiss(animated: true, completion: nil)
              }
          }
    
    @objc func handleBook()  {
        if patient == nil {
            presentAlert(vvv: customAlertLoginView)
            
        }else {
            guard let api = patient?.apiToken,let patientId = patient?.id else { return  }
            cusomDoctorBookView.doctorBookViewModel.api_token=api
            cusomDoctorBookView.doctorBookViewModel.patient_id=patientId
            cusomDoctorBookView.doctorBookViewModel.performBooking(notessss: getNotes()) { (base, err) in
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
        self.handleDismiss()
//        removeViewWithAnimation(vvv: customAlertLoginView)
//        customMainAlertVC.dismiss(animated: true)
        let orders = ProfileOrdersVC(isFromOrder: true)
        navigationController?.pushViewController(orders, animated: true)
        
    }
    
  @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}

extension DoctorBookVC: LoginVCPrototcol {
    
    func useApiAndPatienId(patient: PatienModel) {
        self.patient=patient
        handleBook()
    }
}


extension DoctorBookVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        self.scrollView.isScrollEnabled = x < -60 ? false : true
        
    }
}
