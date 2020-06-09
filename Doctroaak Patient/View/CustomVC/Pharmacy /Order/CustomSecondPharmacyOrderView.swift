//
//  CustomSecondPharmacyOrderView.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/16/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import iOSDropDown
import MOLH
import TTSegmentedControl

class CustomSecondPharmacyOrderView: CustomBaseView {
    
    var patient:PatienModel?{
        didSet{
            guard let patient = patient else { return  }
            pharamacyOrderViewModel.api_token=patient.apiToken
            pharamacyOrderViewModel.patient_id=patient.id
        }
    }
    
    var pharmacy_id:Int?{
        didSet{
            guard let pharmacy_id = pharmacy_id else { return  }
            pharamacyOrderViewModel.pharmacy_id=pharmacy_id
        }
    }
    
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: MOLHLanguage.isRTLLanguage() ? #imageLiteral(resourceName: "left-arrow") : #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var titleLabel = UILabel(text: "Order ".localized, font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Order your request".localized, font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var orderSegmentedView:TTSegmentedControl = {
        let view = TTSegmentedControl()
        view.itemTitles = ["prescription".localized,"Request a medicine".localized,"All".localized]
        //        view.selectItemAt(index: 2)
        view.allowChangeThumbWidth = true
        view.constrainHeight(constant: 50)
        view.thumbGradientColors = [#colorLiteral(red: 0.6887479424, green: 0.4929093719, blue: 0.9978651404, alpha: 1),#colorLiteral(red: 0.5526981354, green: 0.3201900423, blue: 1, alpha: 1)]
        view.useShadow = true
        //            view.didSelectItemWith = {[unowned self] (index, title) in
        //                self.hideOrUndie(index: index)
        //            }
        return view
    }()
    
    
    
    lazy var rosetaImageView:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "2454170"))
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.constrainHeight(constant: 200)
        
        //           i.isHide(true)
        return i
    }()
    lazy var uploadView:UIView = {
        let v = makeMainSubViewWithAppendView(vv: [uploadLabel,uploadImage])
        v.constrainHeight(constant: 60)
        v.hstack(uploadImage,uploadLabel)
        
        return v
    }()
    lazy var uploadLabel = UILabel(text: "Upload prescription".localized, font: .systemFont(ofSize: 20), textColor: .lightGray,textAlignment: .center)
    
    lazy var uploadImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4174"))
        i.constrainWidth(constant: 80)
        return i
    }()
    lazy var mainDropView = makeMainSubViewWithAppendView(vv: [nameDrop])
    lazy var main2DropView = makeMainSubViewWithAppendView(vv: [typeDrop])
    
    lazy var nameDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left
        i.textColor = .black
        i.rowBackgroundColor = .gray

        i.arrowSize = 20
        i.placeholder = "Name".localized
        i.didSelect { (txt, indexx, _) in
            self.choosedName=txt
            //                                   self.pharamacyOrderViewModel. = self.index
            self.medicineNameChosen = self.medicineNameIDSArray[indexx]
        }
        return i
    }()
    lazy var typeDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left
        i.textColor = .black
        i.rowBackgroundColor = .gray

        i.arrowSize = 20
        i.placeholder = "Type".localized
        i.didSelect {[unowned self] (txt, indexx, _) in
            self.choosedType=txt
            self.medicineTypeChosen = self.mdeicineTypeIDSArray[indexx]
        }
        return i
    }()
    lazy var quantityLabel = UILabel(text: "Quantity".localized, font: .systemFont(ofSize: 16), textColor: .black)
    lazy var customAddMinusView:CustomAddMinusView = {
        let v = CustomAddMinusView()
        v.handleAddClousre = {[unowned self] count in
            self.medicineCount += 1
            
        }
        v.handleMinusClousre = {[unowned self] count in
            self.medicineCount = max(1, self.medicineCount-1)
        }
        return v
    } ()
    lazy var addMedicineCollectionVC:AddMedicineCollectionVC = {
        let vc = AddMedicineCollectionVC()
        vc.handleRemovePharamcay = {[unowned self] isn , indexPath in
            self.handleRemovePharamcay?(isn,indexPath)
        }
        return vc
    }()
    lazy var orLabel:UILabel = {
        let l = UILabel(text: "OR".localized, font: .systemFont(ofSize: 18), textColor: .black,textAlignment: .center)
        l.isHide(true)
        return l
    }()
    
    lazy var addMoreImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4178"))
        i.isUserInteractionEnabled = true
        i.constrainWidth(constant: 60)
        i.constrainHeight(constant: 60)
        i.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddMore)))
        
        return i
    }()
    lazy var secondStack :UIStackView = {
        let dd = getStack(views: UIView(),addMoreImage, spacing: 16, distribution: .fill, axis: .horizontal)
        let ff = getStack(views: quantityLabel,customAddMinusView, spacing: 8, distribution: .fillProportionally, axis: .horizontal)
        
        let s = getStack(views: mainDropView,ff,main2DropView,dd,addMedicineCollectionVC.view, spacing: 16, distribution: .fill, axis: .vertical)
        s.isHide(true)
        return s
    }()
    lazy var firstStack :UIStackView = {
        let s = getStack(views: rosetaImageView,uploadView, spacing: 16, distribution: .fillProportionally, axis: .vertical)
        return s
    }()
    
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("Book".localized, for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    //    var handleRemovePharamcay:((PharamcyOrderModel,Int)->Void)?
    var handleRemovePharamcay:((PharamcyOrderModel,IndexPath)->Void)?

    let pharamacyOrderViewModel = PharamacyOrderViewModel()
    var medicineNameArray = [String]()
    var mdeicineTypeArray = [String]()
    var medicineNameChosen = 0
    var medicineTypeChosen = 0
    var medicineCount = 1
    var choosedName = ""
    var choosedType = ""

    lazy var textView:UITextView = {
        let tx = UITextView()
        tx.backgroundColor = #colorLiteral(red: 0.9180622697, green: 0.918194294, blue: 0.918033421, alpha: 1)
        tx.isScrollEnabled = false
        tx.font = UIFont.systemFont(ofSize: 16)
        tx.delegate = self
        tx.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left
        tx.isHide(true)
        tx.constrainHeight(constant: 150)
        return tx
    }()
    lazy var placeHolderLabel = UILabel(text: "Enter Notes (OPTIONAL)".localized, font: .systemFont(ofSize: 16), textColor: .lightGray,textAlignment: MOLHLanguage.isRTLLanguage() ? .right : .left)
    //    var  api_token:String?{didSet{pharamacyOrderViewModel.api_token=api_token} }
    //    var  patient_id:Int?{didSet{pharamacyOrderViewModel.patient_id=patient_id}}
    
    var medicineNameIDSArray = [Int]()
    var mdeicineTypeIDSArray = [Int]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        fetchData()
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChanged), name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textView.textContainerInset = .init(top: 16, left: 16, bottom: 0, right: 0)
    }
    
    func hideOrUndie(index:Int)  {
        self.pharamacyOrderViewModel.isFirstOpetion = index == 0 ? true : false
        self.pharamacyOrderViewModel.isSecondOpetion = index == 1 ? true : false
        self.pharamacyOrderViewModel.isThirdOpetion = index == 2 ? true : false
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {[unowned self] in
            self.secondStack.isHide(index == 0 ? true : false)
            self.orLabel.isHide(index == 2 ? false :  true)
            self.firstStack.isHide(index == 1 ? true : false)
            
        })
    }
    
    
    
    override var intrinsicContentSize: CGSize{
        return .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func fetchData()  {
        
        fetchEnglishData(isArabic: MOLHLanguage.isRTLLanguage())
    }
    
    fileprivate func fetchEnglishData(isArabic:Bool) {
        if isArabic {
            
            
            if  let cityArray = userDefaults.value(forKey: UserDefaultsConstants.medicineNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.medicineNameIDSArray) as? [Int],let arasNames = userDefaults.value(forKey: UserDefaultsConstants.medicineTypeArray) as? [String] , let areaIds =  userDefaults.value(forKey: UserDefaultsConstants.medicineTypeIDSArray) as? [Int]  {
                
                putDataInDrops(sr: cityArray, sid: cityIds, dr: arasNames, did:areaIds )
                
                
            }
        }else {
            if  let cityArray = userDefaults.value(forKey: UserDefaultsConstants.medicineNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.medicineNameIDSArray) as? [Int],let arasNames = userDefaults.value(forKey: UserDefaultsConstants.medicineTypeArray) as? [String] , let areaIds =  userDefaults.value(forKey: UserDefaultsConstants.medicineTypeIDSArray) as? [Int]  {
                
                putDataInDrops(sr: cityArray, sid: cityIds, dr: arasNames, did:areaIds )
                
                
            }
        }
        self.nameDrop.optionArray = medicineNameArray
        self.typeDrop.optionArray = mdeicineTypeArray
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
    
    func putDataInDrops(sr:[String],sid:[Int],dr:[String],did:[Int])  {
        self.medicineNameArray = sr
        self.mdeicineTypeArray = dr
        self.medicineNameIDSArray = sid
        mdeicineTypeIDSArray = did
    }
    
    override func setupViews() {
        [titleLabel,soonLabel,quantityLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})

        mainDropView.hstack(nameDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        main2DropView.hstack(typeDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        
        let mainStacxk = getStack(views: firstStack,orLabel,secondStack,textView, spacing: 16, distribution: .fill, axis: .vertical)
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,orderSegmentedView,mainStacxk,nextButton)
        
        textView.hstack(placeHolderLabel).withMargins(.init(top: 16, left: 16, bottom: 0, right: 0))
        
        if MOLHLanguage.isRTLLanguage() {
                 LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
             }else {
                 
                 LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
             }
//        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: backImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -80, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        orderSegmentedView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 108, left: 46, bottom: 0, right: 32))
        mainStacxk.anchor(top: orderSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nextButton.topAnchor, trailing: trailingAnchor,padding: .init(top: 24, left: 46, bottom: 32, right: 32))
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
    @objc  func handleAddMore()  {
        nameDrop.text = "Name".localized
        typeDrop.text = "Type".localized
               nameDrop.selectedIndex = -1
        typeDrop.selectedIndex = -1
        
        let text = self.choosedName
        let type = self.choosedType
        
//        let medicine = PharamcyWithNameOrderModel(medicineName: text, medicineType: type, amount: medicineCount)
        
               
//               addMedicineCollectionVC.medicineTextArray.append(medicine)
        let types = PharamcyOrderModel(medicineID: medicineNameChosen, medicineTypeID: medicineTypeChosen, amount: medicineCount)
        self.addMedicineCollectionVC.medicineArray.append(types)
        DispatchQueue.main.async {
            
            //            self.addMedicineCollectionVC.view.isHide(false)
            //            self.addMedicineCollectionVC.medicineArray.append(type)
            
            self.addMedicineCollectionVC.collectionView.reloadData()
            self.pharamacyOrderViewModel.orderDetails = self.addMedicineCollectionVC.medicineArray
            
        }
        
    }
    
    @objc  func handleTextChanged()  {
        placeHolderLabel.isHidden = textView.text.count != 0
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self) //for avoiding retain cycle
    }
}

extension CustomSecondPharmacyOrderView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let spacing = CharacterSet.whitespacesAndNewlines
        if !textView.text.trimmingCharacters(in: spacing).isEmpty {
            
            
        }else {
            pharamacyOrderViewModel.notes = textView.text
        }
    }
    
    
}
