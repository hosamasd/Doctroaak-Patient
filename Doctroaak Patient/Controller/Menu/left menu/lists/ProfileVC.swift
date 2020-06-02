//
//  ProfileVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import CodableCache
import SVProgressHUD
import MOLH

//let personManager = PersonManager(cacheKey: "myPatient")

class ProfileVC: CustomBaseViewVC {
    
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
    
    lazy var customProfileView:CustomProfileView = {
        let v = CustomProfileView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.doctorEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createAlertForChoposingImage)))
        v.nextButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return v
    }()
    
    var patient:PatienModel?{
        didSet{
            guard let patient = patient else { return  }
            customProfileView.patient=patient
        }
    }
    
    
    //    let edirProfileViewModel = EdirProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pat =    cacheObjectCodabe.storedValue else { return  }
        self.patient=pat
        //        if let person = personManager.getPerson(){
        //            patient = person
        //        }
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        //        edirProfileViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
        //            guard let isValid = isValidForm else {return}
        //            //            self.customLoginView.loginButton.isEnabled = isValid
        //
        //            self.changeButtonState(enable: isValid, vv: self.customProfileView.nextButton)
        //        }
        
        customProfileView.edirProfileViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                SVProgressHUD.show(withStatus: "Updating...".localized)
                
            }else {
                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
            }
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
        
        mainView.addSubViews(views: customProfileView)
        customProfileView.fillSuperview()
        
        
        
    }
    
    func handleOpenGallery(sourceType:UIImagePickerController.SourceType)  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    func cachedATA(_ patient:PatienModel)  {
        cacheObjectCodabe.save(patient)
        
        //       try? personManager.set(person: patient)
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
    
    
    @objc func handleSave()  {
        customProfileView.edirProfileViewModel.performUpdateProfile { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            self.cachedATA(user)
            DispatchQueue.main.async {
                self.showToast(context: self, msg: "your information updated...")
            }
        }
    }
    
    @objc func handleBack()  {
        dismiss(animated: true)
        //        navigationController?.popViewController(animated: true)
    }
    
}


//MARK:-Extension

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if var img = info[.originalImage]  as? UIImage   {
            let jpegData = img.jpegData(compressionQuality: 1.0)
            let jpegSize: Int = jpegData?.count ?? 0
            img = (jpegSize > 30000 ? img.resized(toWidth: 1300) : img) ?? img
            customProfileView.edirProfileViewModel.image = img
            customProfileView.doctorProfileImage.image = img
            customProfileView.edirProfileViewModel.isPhotoEdit=true
        }
        if var img = info[.editedImage]  as? UIImage   {
            let jpegData = img.jpegData(compressionQuality: 1.0)
            let jpegSize: Int = jpegData?.count ?? 0
            img = (jpegSize > 30000 ? img.resized(toWidth: 1300) : img) ?? img
            customProfileView.edirProfileViewModel.image = img
            customProfileView.doctorProfileImage.image = img
            customProfileView.edirProfileViewModel.isPhotoEdit=true
            
        }
        
       
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        customProfileView.edirProfileViewModel.image = nil
        customProfileView.edirProfileViewModel.isPhotoEdit=false
        
        dismiss(animated: true)
    }
    
    
}
