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
    lazy var customAndLAPOrderView:CustomLAPOrderView = {
        let v = CustomLAPOrderView()
        v.index=index
        //        v.patientId = patientId ?? 0
        //        v.apiToken = apiToken ?? ""
        v.labId=self.labId
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        v.orderSegmentedView.didSelectItemWith = {[unowned self] (index, title) in
            self.hideOrUndie(index: index)
        }
        v.uploadView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createAlertForChoposingImage)))
        v.handleRemoveItem = {[unowned self] arr , index in
            self.deleteThis(arr,index)
        }
        return v
    }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    
    lazy var customMainAlertVC:CustomMainAlertVC = {
        let t = CustomMainAlertVC()
                t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    
    var bubleViewHeightConstraint:NSLayoutConstraint!
    
    
    fileprivate let labId:Int!
    //    fileprivate let radId:Int!
    
    
    fileprivate let index:Int!
    init(index:Int,lab:Int) {
        self.labId=lab
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        scrollView.delegate=self
    }
    
    //MARK:-User methods
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    
    
    override func setupViews() {
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        //        mainView.fillSuperview()
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        bubleViewHeightConstraint = mainView.heightAnchor.constraint(equalToConstant: 900)
        bubleViewHeightConstraint.isActive = true
        mainView.addSubViews(views: customAndLAPOrderView)
        customAndLAPOrderView.fillSuperview()
    }
    
    fileprivate  func deleteThis(_ ss:RadiologyOrderModel,_ index:IndexPath)  {
        customAndLAPOrderView.addLapCollectionVC.medicineArray.remove(at: index.item)
        customAndLAPOrderView.laPOrderViewModel.orderDetails = customAndLAPOrderView.addLapCollectionVC.medicineArray
        
        DispatchQueue.main.async {
            self.customAndLAPOrderView.addLapCollectionVC.collectionView.reloadData()
        }
    }
    
    fileprivate func hideOrUndie(index:Int)  {
        self.customAndLAPOrderView.laPOrderViewModel.isFirstOpetion = index == 0 ? true : false
        self.customAndLAPOrderView.laPOrderViewModel.isSecondOpetion = index == 1 ? true : false
        self.customAndLAPOrderView.laPOrderViewModel.isThirdOpetion = index == 2 ? true : false
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {[unowned self] in
            self.customAndLAPOrderView.secondStack.isHide(index == 0 ? true : false)
            self.customAndLAPOrderView.orLabel.isHide(index == 2 ? false :  true)
            self.customAndLAPOrderView.firstStack.isHide(index == 1 ? true : false)
            self.bubleViewHeightConstraint.constant = index == 0 ? 900 : index == 1 ? 900 : 1100
            
        })
    }
    
    fileprivate  func setupViewModelObserver()  {
        
        customAndLAPOrderView.laPOrderViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customAndLAPOrderView.nextButton)
        }
    }
    
    fileprivate func putData(_ img:UIImage? = nil,_ orders:[RadiologyOrderModel]? = nil)  {
        let book = LAPBookVC(index: index,labId: labId )
        if img != nil {
            book.img = img
        }
        if orders != nil {
            book.orders = orders
        }
        navigationController?.pushViewController(book, animated: true)
    }
    
    fileprivate  func handleOpenGallery(sourceType:UIImagePickerController.SourceType)  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    fileprivate func showMainAlertLooder()  {
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingView, height: 200)
        customAlertMainLoodingView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
    }
    
    //TODO: -handle methods
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    @objc func createAlertForChoposingImage()  {
        let alert = UIAlertController(title: "Choose Image".localized, message: "Choose image fROM ".localized, preferredStyle: .alert)
        let camera = UIAlertAction(title: "Camera".localized, style: .default) {[unowned self] (_) in
            self.handleOpenGallery(sourceType: .camera)
            
        }
        let gallery = UIAlertAction(title: "Open From Gallery".localized, style: .default) {[unowned self] (_) in
            self.handleOpenGallery(sourceType: .photoLibrary)
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) {[unowned self] (_) in
            alert.dismiss(animated: true)
        }
        
        alert.addAction(camera)
        alert.addAction(gallery)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc  func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleNext()  {
        customAndLAPOrderView.laPOrderViewModel.performOrdering {[unowned self] (img, order) in
            print(img,order)
            self.putData(img,order)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//MARK:-Extension

extension LAPOrderVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if var img = info[.originalImage]  as? UIImage   {
            let jpegData = img.jpegData(compressionQuality: 1.0)
            let jpegSize: Int = jpegData?.count ?? 0
            img = (jpegSize > 30000 ? img.resized(toWidth: 1300) : img) ?? img
            customAndLAPOrderView.laPOrderViewModel.image = img
            customAndLAPOrderView.rosetaImageView.image = img
        }
        if var img = info[.editedImage]  as? UIImage   {
            let jpegData = img.jpegData(compressionQuality: 1.0)
            let jpegSize: Int = jpegData?.count ?? 0
            img = (jpegSize > 30000 ? img.resized(toWidth: 1300) : img) ?? img
            customAndLAPOrderView.laPOrderViewModel.image = img
            customAndLAPOrderView.rosetaImageView.image = img
        }
        if let url = info[.imageURL] as? URL {
            let fileName = url.lastPathComponent
            customAndLAPOrderView.uploadLabel.text = fileName
        }
        //        hideOtherData()
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        customAndLAPOrderView.laPOrderViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}


extension LAPOrderVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        self.scrollView.isScrollEnabled = x < -60 ? false : true
        
    }
}
