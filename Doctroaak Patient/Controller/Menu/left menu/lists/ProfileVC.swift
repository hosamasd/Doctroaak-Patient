//
//  ProfileVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

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
        v.listImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenMenu)))
        
        v.phoneTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.emailTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.addressTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.doctorEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createAlertForChoposingImage)))
        return v
    }()
    
    let edirProfileViewModel = EdirProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        edirProfileViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customProfileView.nextButton)
        }
        
        edirProfileViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                
            }else {
                //                SVProgressHUD.dismiss()
                //                self.activeViewsIfNoData()
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
    
    @objc func textFieldDidChange(text: UITextField)  {
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == customProfileView.phoneTextField {
                if  !texts.isValidPhoneNumber    {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    edirProfileViewModel.phone = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    edirProfileViewModel.phone = texts
                }
                
            }else if text == customProfileView.emailTextField {
                if  !texts.isValidEmail    {
                    floatingLabelTextField.errorMessage = "Invalid   Email".localized
                    edirProfileViewModel.email = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    edirProfileViewModel.email = texts
                }
                
            }else   {
                if (texts.count < 3 ) {
                    floatingLabelTextField.errorMessage = "Invalid Address".localized
                    edirProfileViewModel.address = nil
                }
                else {
                    
                    edirProfileViewModel.address = texts
                    floatingLabelTextField.errorMessage = ""
                }
                
            }
            
        }
    }
    
    
    @objc func handleOpenMenu()  {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.openMenu()
        
    }
    
}


//MARK:-Extension

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            edirProfileViewModel.image = img
            customProfileView.doctorProfileImage.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            edirProfileViewModel.image = img
            customProfileView.doctorProfileImage.image = img
        }
        
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        edirProfileViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}
