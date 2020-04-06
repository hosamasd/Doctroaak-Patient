//
//  LAPOrderVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LAPOrderVC: CustomBaseViewVC {
    
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customLAPOrderView:CustomLAPOrderView = {
        let v = CustomLAPOrderView()
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
    
    var isDataFound = false
    
    fileprivate let index:Int!
    init(index:Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        bubleViewHeightConstraint = mainView.heightAnchor.constraint(equalToConstant: 900)
        bubleViewHeightConstraint.isActive = true
        mainView.addSubViews(views: customLAPOrderView)
        customLAPOrderView.fillSuperview()
    }
    
    fileprivate  func setupViewModelObserver()  {
           
           customLAPOrderView.laPOrderViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
               guard let isValid = isValidForm else {return}
               //            self.customLoginView.loginButton.isEnabled = isValid
               
               self.changeButtonState(enable: isValid, vv: self.customLAPOrderView.nextButton)
           }
           
           customLAPOrderView.laPOrderViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isValid) in
               if isValid == true {
                   //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                   //                SVProgressHUD.show(withStatus: "Login...".localized)
                   
               }else {
                   //                SVProgressHUD.dismiss()
                   //                self.activeViewsIfNoData()
               }
           })
       }
    
    fileprivate func makeFirstOption() {
        self.bubleViewHeightConstraint.constant = 900
        self.customLAPOrderView.laPOrderViewModel.isSecondOpetion = false
        self.customLAPOrderView.laPOrderViewModel.isFirstOpetion = true
        self.customLAPOrderView.makeTheseChanges(  hide: true, height: 800)
        self.customLAPOrderView.updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116"),tr: 0,tops: 186,bottomt:80,log: -48 ,centerImg: 250)
        self.customLAPOrderView.addLapCollectionVC.view.isHide(true)
    }
    
    fileprivate func makeSecondOption() {
        self.bubleViewHeightConstraint.constant = 1000
        self.customLAPOrderView.laPOrderViewModel.isSecondOpetion = true
        self.customLAPOrderView.laPOrderViewModel.isFirstOpetion = false
        self.customLAPOrderView.addLapCollectionVC.medicineArray.count > 0 ?  self.customLAPOrderView.makeTheseChanges( hide: false, height: 1200) : self.customLAPOrderView.makeTheseChanges( hide: false, height: 800)
        self.customLAPOrderView.updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116"),tr: 0,tops: 186,bottomt:80,log: -48, centerImg: 100 )
    }
    
    fileprivate func makeLastOption() {
        self.bubleViewHeightConstraint.constant = 1000
        self.customLAPOrderView.laPOrderViewModel.isSecondOpetion = false
        self.customLAPOrderView.laPOrderViewModel.isFirstOpetion = false
        self.customLAPOrderView.addLapCollectionVC.medicineArray.count > 0 ?  self.customLAPOrderView.makeTheseChanges( hide: false, height: 1200,all: false) : self.customLAPOrderView.makeTheseChanges( hide: false, height: 1000,all: false)
        self.customLAPOrderView.updateOtherLabels(img: #imageLiteral(resourceName: "Group 4116-1"),tr: 60,tops: 80,bottomt:0,log: 0, centerImg: 100 )
    }
    
    func makeTheseChanges(hide:Bool,height:CGFloat,all:Bool? = true)  {
        DispatchQueue.main.async {
            
            if all ?? true {
                
                
                [self.customLAPOrderView.mainDropView,self.customLAPOrderView.addLapCollectionVC.view].forEach({$0.isHide(hide)})
                [self.customLAPOrderView.centerImage,self.customLAPOrderView.uploadView].forEach({$0.isHide(!hide)})
                self.customLAPOrderView.orLabel.isHide(true)
            }else {
                [self.customLAPOrderView.mainDropView,self.customLAPOrderView.addLapCollectionVC.view,self.customLAPOrderView.orLabel,self.customLAPOrderView.centerImage,self.customLAPOrderView.uploadView].forEach({$0.isHide(false)})
            }
            self.bubleViewHeightConstraint.constant = height
            self.view.layoutIfNeeded()
        }
    }
    
    func hideOtherData()  {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            [self.customLAPOrderView.uploadView,self.customLAPOrderView.centerImage].forEach({$0.isHide(true)})
            self.customLAPOrderView.rosetaImageView.isHide(false)
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
    
    //    @objc func handleOpenOther(sender:UISegmentedControl)  {
    //        switch sender.selectedSegmentIndex {
    //        case 0:
    //            makeTheseChanges(  hide: true, height: 800)
    //        case 1:
    //            self.customLAPOrderView.addLapCollectionVC.medicineArray.count > 0 ?  makeTheseChanges( hide: false, height: 1200) : makeTheseChanges( hide: false, height: 800)
    //        default:
    //            self.customLAPOrderView.addLapCollectionVC.medicineArray.count > 0 ?  makeTheseChanges( hide: false, height: 1200,all: false) : makeTheseChanges( hide: false, height: 1000,all: false)
    //        }
    //    }
}



//MARK:-Extension

extension LAPOrderVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            customLAPOrderView.laPOrderViewModel.image = img
            customLAPOrderView.rosetaImageView.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            customLAPOrderView.laPOrderViewModel.image = img
            customLAPOrderView.rosetaImageView.image = img
        }
        
        hideOtherData()
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        customLAPOrderView.laPOrderViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}
