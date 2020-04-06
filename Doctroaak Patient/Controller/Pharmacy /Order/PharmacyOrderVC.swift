//
//  PharmacyOrderVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit



class PharmacyOrderVC: CustomBaseViewVC {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        //        v.constrainHeight(constant:  1200 )
        v.translatesAutoresizingMaskIntoConstraints = false
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    
    lazy var customPharmacyOrderView:CustomPharmacyOrderView = {
        let v = CustomPharmacyOrderView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.uploadView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenGallery)))
        v.orderSegmentedView.didSelectItemWith = {[unowned self] (index, title) in
            switch index {
            case 0:
                self.makeFirstOption()
            case 1:
                
                self.makeSecondOption()
            default:
                self.makeLastOption()
            }
        }
        return v
    }()
    
    var bubleViewHeightConstraint:NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        
    }
    
    //MARK:-User methods
    
    fileprivate func makeFirstOption() {
        self.bubleViewHeightConstraint.constant = 900
        self.customPharmacyOrderView.pharamacyOrderViewModel.isSecondOpetion = false
        self.customPharmacyOrderView.pharamacyOrderViewModel.isFirstOpetion = true
        self.customPharmacyOrderView.makeTheseChanges(  hide: true, height: 800)
        self.customPharmacyOrderView.updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116"),tr: 0,tops: 186,bottomt:80,log: -48 ,centerImg: 250)
        self.customPharmacyOrderView.addLapCollectionVC.view.isHide(true)
    }
    
    fileprivate func makeSecondOption() {
        self.bubleViewHeightConstraint.constant = 1000
        self.customPharmacyOrderView.pharamacyOrderViewModel.isSecondOpetion = true
        self.customPharmacyOrderView.pharamacyOrderViewModel.isFirstOpetion = false
        self.customPharmacyOrderView.addLapCollectionVC.medicineArray.count > 0 ?  self.customPharmacyOrderView.makeTheseChanges( hide: false, height: 1200) : self.customPharmacyOrderView.makeTheseChanges( hide: false, height: 800)
        self.customPharmacyOrderView.updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116"),tr: 0,tops: 186,bottomt:80,log: -48, centerImg: 100 )
    }
    
    fileprivate func makeLastOption() {
        self.bubleViewHeightConstraint.constant = 1000
        self.customPharmacyOrderView.pharamacyOrderViewModel.isSecondOpetion = false
        self.customPharmacyOrderView.pharamacyOrderViewModel.isFirstOpetion = false
        self.customPharmacyOrderView.addLapCollectionVC.medicineArray.count > 0 ?  self.customPharmacyOrderView.makeTheseChanges( hide: false, height: 1200,all: false) : self.customPharmacyOrderView.makeTheseChanges( hide: false, height: 1000,all: false)
        self.customPharmacyOrderView.updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116-1"),tr: 60,tops: 80,bottomt:0,log: 0, centerImg: 100 )
    }
    
   fileprivate func setupViewModelObserver()  {
        
        customPharmacyOrderView.pharamacyOrderViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customPharmacyOrderView.nextButton)
        }
        
        customPharmacyOrderView.pharamacyOrderViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isValid) in
            if isValid == true {
                //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                
            }else {
                //                SVProgressHUD.dismiss()
                //                self.activeViewsIfNoData()
            }
        })
    }
    
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        bubleViewHeightConstraint = mainView.heightAnchor.constraint(equalToConstant: 900)
        bubleViewHeightConstraint.isActive = true
        mainView.addSubViews(views: customPharmacyOrderView)
        customPharmacyOrderView.fillSuperview()
    }
    
    func hideOtherData()  {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            [self.customPharmacyOrderView.uploadView,self.customPharmacyOrderView.centerImage].forEach({$0.isHide(true)})
            self.customPharmacyOrderView.rosetaImageView.isHide(false)
        })
    }
    
   
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleOpenGallery()  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
}



//MARK:-Extension

extension PharmacyOrderVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            customPharmacyOrderView.pharamacyOrderViewModel.image = img
            customPharmacyOrderView.rosetaImageView.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            customPharmacyOrderView.pharamacyOrderViewModel.image = img
            customPharmacyOrderView.rosetaImageView.image = img
        }
        
        hideOtherData()
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        customPharmacyOrderView.pharamacyOrderViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}
