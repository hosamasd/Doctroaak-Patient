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
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var titleLabel = UILabel(text: "Order ", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Order your request", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var orderSegmentedView:TTSegmentedControl = {
        let view = TTSegmentedControl()
        view.itemTitles = ["prescription","Request a medicine","All"]
        
        view.allowChangeThumbWidth = true
        view.constrainHeight(constant: 50)
        view.thumbGradientColors = [#colorLiteral(red: 0.6887479424, green: 0.4929093719, blue: 0.9978651404, alpha: 1),#colorLiteral(red: 0.5526981354, green: 0.3201900423, blue: 1, alpha: 1)]
        view.useShadow = true
        //            view.didSelectItemWith = {[unowned self] (index, title) in
        //                self.hideOrUndie(index: index)
        //            }
        return view
    }()
    
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
    lazy var uploadLabel = UILabel(text: "Upload prescription", font: .systemFont(ofSize: 20), textColor: .lightGray,textAlignment: .center)
    
    lazy var uploadImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4174"))
        i.constrainWidth(constant: 80)
        return i
    }()
    lazy var mainDropView = makeMainSubViewWithAppendView(vv: [nameDrop])
    lazy var main2DropView = makeMainSubViewWithAppendView(vv: [typeDrop])
    
    lazy var nameDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.arrowSize = 20
        i.placeholder = "Name".localized
        i.didSelect { (txt, indexx, _) in
            //                                   self.pharamacyOrderViewModel. = self.index
            self.medicineNameChosen = self.medicineNameIDSArray[indexx]
        }
        return i
    }()
    lazy var typeDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.optionArray = ["one","two","three"]
        i.arrowSize = 20
        i.placeholder = "Type".localized
        i.didSelect {[unowned self] (txt, indexx, _) in
            self.medicineTypeChosen = self.mdeicineTypeIDSArray[indexx]
        }
        return i
    }()
    lazy var quantityLabel = UILabel(text: "Quantity", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var customAddMinusView:CustomAddMinusView = {
        let v = CustomAddMinusView()
        v.handleAddClousre = {[unowned self] count in
            //            self.pharamacyOrderViewModel.quantity = "\(count)"
        }
        v.handleMinusClousre = {[unowned self] count in
            //            self.pharamacyOrderViewModel.quantity = "\(count)"
        }
        return v
    } ()
    lazy var addMedicineCollectionVC:AddMedicineCollectionVC = {
        let vc = AddMedicineCollectionVC()
        //        vc.view.constrainHeight(constant: 300)
        //        vc.view.isHide(true)
        return vc
    }()
    lazy var orLabel:UILabel = {
        let l = UILabel(text: "OR", font: .systemFont(ofSize: 18), textColor: .black,textAlignment: .center)
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
        button.setTitle("Next", for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    let pharamacyOrderViewModel = PharamacyOrderViewModel()
    var medicineNameArray = [String]()
    var mdeicineTypeArray = [String]()
    var medicineNameChosen = 0
    var medicineTypeChosen = 0
    var  api_token:String?{didSet{pharamacyOrderViewModel.api_token=api_token} }
    var  patient_id:Int?{didSet{pharamacyOrderViewModel.patient_id=patient_id}}
    
    var medicineNameIDSArray = [Int]()
    var mdeicineTypeIDSArray = [Int]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        fetchData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func fetchData()  {
        
        fetchEnglishData(isArabic: MOLHLanguage.isRTLLanguage())
    }
    
    fileprivate func fetchEnglishData(isArabic:Bool) {
        if isArabic {
            
            
            if  let cityArray = userDefaults.value(forKey: UserDefaultsConstants.medicineNameARArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.medicineNameIDSArray) as? [Int],let arasNames = userDefaults.value(forKey: UserDefaultsConstants.medicineTypeARArray) as? [String] , let areaIds =  userDefaults.value(forKey: UserDefaultsConstants.medicineTypeIDSArray) as? [Int]  {
                
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
        mainDropView.hstack(nameDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        main2DropView.hstack(typeDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        
        let mainStacxk = getStack(views: firstStack,orLabel,secondStack,UIView(), spacing: 16, distribution: .fillProportionally, axis: .vertical)
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,orderSegmentedView,mainStacxk,nextButton)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        
        
        
        orderSegmentedView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 108, left: 46, bottom: 0, right: 32))
        mainStacxk.anchor(top: orderSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 24, left: 46, bottom: 32, right: 32))
        
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
    @objc  func handleAddMore()  {
        let type = PharamcyOrderModel(medicineID: 1, medicineTypeID: 1, amount: 1)
        DispatchQueue.main.async {
            self.addMedicineCollectionVC.view.isHide(false)
            self.addMedicineCollectionVC.collectionView.reloadData()
        }
        //            guard let name = pharamacyOrderViewModel.name else {print("all fields required"); return  }
        //            //       let model = MedicineModel(name: name, type: type, count: count)
        //            addLapCollectionVC.medicineArray.append(name)
        //            DispatchQueue.main.async {
        //                self.addLapCollectionVC.collectionView.reloadData()
        //            }
        
        
    }
    
}
