//
//  LAPOrderVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

class LAPOrderVC: CustomBaseViewVC {
    
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.translatesAutoresizingMaskIntoConstraints = false
        //        v.constrainHeight(constant: 1000)
        
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customLAPOrderView:CustomAndLAPOrderView = {
        let v = CustomAndLAPOrderView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        v.orderSegmentedView.didSelectItemWith = {[unowned self] (index, title) in
            self.hideOrUndie(index: index)
        }
        return v
    }()
    
    var bubleViewHeightConstraint:NSLayoutConstraint!
    
    var isDataFound = false
    
    fileprivate let index:Int!
    init(index:Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        
    }
    
    //MARK:-User methods
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func setupViews() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        //        mainView.fillSuperview()
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        bubleViewHeightConstraint = mainView.heightAnchor.constraint(equalToConstant: 900)
        bubleViewHeightConstraint.isActive = true
        mainView.addSubViews(views: customLAPOrderView)
        customLAPOrderView.fillSuperview()
    }
    
    func hideOrUndie(index:Int)  {
        self.customLAPOrderView.laPOrderViewModel.isFirstOpetion = index == 0 ? true : false
        self.customLAPOrderView.laPOrderViewModel.isSecondOpetion = index == 1 ? true : false
        self.customLAPOrderView.laPOrderViewModel.isThirdOpetion = index == 2 ? true : false
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {[unowned self] in
            self.customLAPOrderView.secondStack.isHide(index == 0 ? true : false)
            self.customLAPOrderView.orLabel.isHide(index == 2 ? false :  true)
            self.customLAPOrderView.firstStack.isHide(index == 1 ? true : false)
            self.bubleViewHeightConstraint.constant = index == 0 ? 900 : index == 1 ? 900 : 1100
            
        })
    }
    
    fileprivate  func setupViewModelObserver()  {
        
        customLAPOrderView.laPOrderViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customLAPOrderView.nextButton)
        }
        
        customLAPOrderView.laPOrderViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isValid) in
            if isValid == true {
//                                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
//                                SVProgressHUD.show(withStatus: "Ordering...".localized)
                
            }else {
//                                SVProgressHUD.dismiss()
//                                self.activeViewsIfNoData()
            }
        })
    }
    
    //TODO:-Handle methods
    
    @objc func handleOpenGallery()  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleNext()  {
        customLAPOrderView.laPOrderViewModel.performOrdering { (img, order) in
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//MARK:-Extension

extension LAPOrderVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            customLAPOrderView.laPOrderViewModel.image = img
            //            customLAPOrderView.rosetaImageView.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            customLAPOrderView.laPOrderViewModel.image = img
            //            customLAPOrderView.rosetaImageView.image = img
        }
        
        //        hideOtherData()
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        customLAPOrderView.laPOrderViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}
