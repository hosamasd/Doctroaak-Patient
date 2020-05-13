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
        v.patient_id = patient_id
        v.api_token = api_token
        v.clinic_id = clinic_id
        v.bookButton.addTarget(self, action: #selector(handleBook), for: .touchUpInside)
        //        v.boyButton.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
        //        v.girlButton.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
        //        v.shift1Button.addTarget(self, action: #selector(handle1Shift), for: .touchUpInside)
        //        v.shift2Button.addTarget(self, action: #selector(handle2Shift), for: .touchUpInside)
        return v
    }()
    
    fileprivate let api_token:String!
    fileprivate let patient_id:Int!
    fileprivate let clinic_id:Int!
    
    init(clinic_id:Int,patient_id:Int,api_token:String) {
        self.api_token=api_token
        self.clinic_id=clinic_id
        self.patient_id=patient_id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        
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
    
    @objc func handleBook()  {
//        self.cusomDoctorBookView.doctorBookViewModel.notes = cusomDoctorBookView.doctorBookViewModel.isFirstOpetion! ? "" : getNotes()
        
        cusomDoctorBookView.doctorBookViewModel.performLogging(notessss: getNotes()) { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let message = base else {return }
//            guard let user = base?.data else { self.createAlert(title: "Information", message: MOLHLanguage.isRTLLanguage() ? message.message : message.messageEn , style: .alert); return}
            
            DispatchQueue.main.async {
                self.createAlert(title: "Information", message: MOLHLanguage.isRTLLanguage() ? message.message : message.messageEn , style: .alert)
//                self.dismiss(animated: true, completion: nil)
                //                       self.saveToken(user_id: user.id,user.phone)
            }
        }
    }
    
    
    func createAlert(title:String,message:String,style:UIAlertController.Style)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in
            alert.dismiss(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
