//
//  CustomPharmacyLocationView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import TTSegmentedControl
import iOSDropDown
import MOLH

class CustomPharmacyLocationView: CustomBaseView {
    
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
    lazy var titleLabel = UILabel(text: "Pharmacy ", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Select Your Location", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var searchSegmentedView:TTSegmentedControl = {
        let view = TTSegmentedControl()
        view.itemTitles = ["Search by city and area","Search by address"]
        view.allowChangeThumbWidth = false
        view.constrainHeight(constant: 50)
        view.thumbGradientColors = [#colorLiteral(red: 0.6887479424, green: 0.4929093719, blue: 0.9978651404, alpha: 1),#colorLiteral(red: 0.5526981354, green: 0.3201900423, blue: 1, alpha: 1)]
        view.useShadow = true
        view.didSelectItemWith = {[unowned self] (index, title) in
            index == 0 ?    self.openTheseViewsOrHide(isVale: false) : self.openTheseViewsOrHide(isVale: true)
            self.pharamacyLocationViewModel.isFirstOpetion = index == 0 ? true : false
        }
        return view
    }()
    
    lazy var addressMainView:UIView = {
        let v = makeMainSubViewWithAppendView(vv: [addressImage,addressLabel])
        v.isHide(true)
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenLocation)))
        
        v.hstack(addressLabel,addressImage).withMargins(.init(top: 4, left: 16, bottom: 4, right: 0))
        return v
    }()
    lazy var addressLabel = UILabel(text: "Address", font: .systemFont(ofSize: 14), textColor: .lightGray,numberOfLines: 3)
    lazy var addressImage:UIImageView = {
        let v = UIImageView(image: #imageLiteral(resourceName: "Group 4174"))
        v.isUserInteractionEnabled = true
        v.contentMode = .scaleAspectFill
        v.constrainWidth(constant: 60)
        v.isUserInteractionEnabled=true
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenLocation)))

        return v
    }()
    lazy var mainDropView = makeMainSubViewWithAppendView(vv: [nameDrop])
    lazy var nameDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.arrowSize = 20
        i.placeholder = "Name".localized
        i.didSelect {[unowned self] (txt, indexx, _) in
            self.pharamacyLocationViewModel.pharmacy_id = self.pharamacyNameIDSArray[indexx]
            //            self.lAPSearchViewModel.lab_id = index == 0 ? self.labNameIDSArray[index] : self.radiologyIDSArray[index]
        }
        
        return i
    }()
    lazy var orLabel = UILabel(text: "OR", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    lazy var mainDrop2View = makeMainSubViewWithAppendView(vv: [cityDrop])
    lazy var cityDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.optionArray = ["one","two","three"]
        i.arrowSize = 20
        i.placeholder = "City".localized
        i.didSelect { (txt, indexx, _) in
            self.getAreaAccordingToCityId(index: indexx)
            self.pharamacyLocationViewModel.city = self.cityIDSArray[indexx]//index+1
        }
        
        return i
    }()
    lazy var mainDrop3View = makeMainSubViewWithAppendView(vv: [areaDrop])
    lazy var areaDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.optionArray = ["one","two","three"]
        i.arrowSize = 20
        i.placeholder = "Area".localized
        i.didSelect {[unowned self] (txt, index, _) in
            self.pharamacyLocationViewModel.area = self.areaIDSArray[index]//index+1
            
        }
        return i
    }()
    
    lazy var insuranceView = makeMainSubViewWithAppendView(vv: [insuranceLabel,insuranceSwitch])
    
    lazy var insuranceLabel = UILabel(text: "Insurance company", font: .systemFont(ofSize: 20), textColor: .lightGray)
    
    lazy var insuranceSwitch:UISwitch = {
        let s = UISwitch()
        s.onTintColor = #colorLiteral(red: 0.3896943331, green: 0, blue: 0.8117204905, alpha: 1)
        s.isOn = true
        s.addTarget(self, action: #selector(handleInsuracneCheck), for: .valueChanged)
        return s
    }()
    lazy var delvieryView = makeMainSubViewWithAppendView(vv: [delvieryLabel,delvierySwitch])
    
    lazy var delvieryLabel = UILabel(text: "Delivery ?", font: .systemFont(ofSize: 20), textColor: .lightGray)
    lazy var delvierySwitch:UISwitch = {
        let s = UISwitch()
        s.onTintColor = #colorLiteral(red: 0.3896943331, green: 0, blue: 0.8117204905, alpha: 1)
        s.isOn = true
        s.addTarget(self, action: #selector(handleDelvieryCheck), for: .valueChanged)
        
        return s
    }()
    
    
    lazy var searchButton:UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    var handlerChooseLocation:(()->Void)?
    
    let pharamacyLocationViewModel = PharamacyLocationViewModel()
    var cityArray = [String]()
    var areaArray = [String]()
    var pharamacyNameArray = [String]()
    
    var pharamacyNameIDSArray = [Int]()
    var cityIDSArray = [Int]()
    var areaIDSArray = [Int]()
    
    
    
    override func setupViews() {
        let textStack = getStack(views: addressMainView,mainDropView,orLabel,mainDrop2View,mainDrop3View,insuranceView,delvieryView, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,searchSegmentedView,textStack,searchButton)
        mainDropView.hstack(nameDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        mainDrop2View.hstack(cityDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        mainDrop3View.hstack(areaDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        insuranceView.hstack(insuranceLabel,insuranceSwitch).withMargins(.init(top: 16, left: 16, bottom: 8, right: 16))
        delvieryView.hstack(delvieryLabel,delvierySwitch).withMargins(.init(top: 16, left: 16, bottom: 8, right: 16))
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        
        
        
        searchSegmentedView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 108, left: 46, bottom: 0, right: 32))
        textStack.anchor(top: searchSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 46, bottom: 0, right: 32))
        searchButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fetchData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func getAreaAccordingToCityId(index:Int)  {
        areaIDSArray.removeAll()
        areaArray.removeAll()
        
        if let areaIdArra = userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int],let areaIdArray = userDefaults.value(forKey: UserDefaultsConstants.areaCityIdsArrays) as? [Int],let areasStringArray =  MOLHLanguage.isRTLLanguage() ? userDefaults.value(forKey: UserDefaultsConstants.areaNameARArray) as? [String] : userDefaults.value(forKey: UserDefaultsConstants.areaNameArray) as? [String]  {
            
            let areas = self.cityIDSArray[index]
            
            let areasFilteredArray = areaIdArray.indexes(of: areas)
            areasFilteredArray.forEach { (s) in
                areaIDSArray.append(areaIdArra[s])
            }
            areasFilteredArray.forEach { (indexx) in
                
                
                areaArray.append( areasStringArray[indexx])
                
            }
            
            self.areaDrop.optionArray = areaArray
            
            DispatchQueue.main.async {
                self.layoutIfNeeded()
            }
        }
    }
    
    func fetchData()  {
        fetchEnglishData(isArabic: MOLHLanguage.isRTLLanguage())
        
        
    }
    
    fileprivate func fetchEnglishData(isArabic:Bool) {
        if isArabic {
            
            
            if  let cityArray = userDefaults.value(forKey: UserDefaultsConstants.cityNameARArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.cityIdArray) as? [Int],let arasNames = userDefaults.value(forKey: UserDefaultsConstants.areaNameARArray) as? [String] , let areaIds =  userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int],let nameArrays = userDefaults.value(forKey: UserDefaultsConstants.pharamacyNameARArray) as? [String],let nameIdss = userDefaults.value(forKey: UserDefaultsConstants.pharamacyIdrray) as? [Int] {
                
                putDataInDrops(sr: cityArray, sid: cityIds, dr: arasNames, did:areaIds,nn: nameArrays,ni: nameIdss )
                
                
            }
        }else {
            if  let cityArray = userDefaults.value(forKey: UserDefaultsConstants.cityNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.cityIdArray) as? [Int],let degreeNames = userDefaults.value(forKey: UserDefaultsConstants.areaNameArray) as? [String] , let degreeIds =  userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int],let nameArrays = userDefaults.value(forKey: UserDefaultsConstants.pharamacyNameArray) as? [String],let nameIdss = userDefaults.value(forKey: UserDefaultsConstants.pharamacyIdrray) as? [Int] {
                putDataInDrops(sr: cityArray, sid: cityIds, dr: degreeNames, did:degreeIds,nn: nameArrays,ni: nameIdss)
                
            }
        }
        self.cityDrop.optionArray = cityArray
        self.areaDrop.optionArray = areaArray
        self.nameDrop.optionArray=pharamacyNameArray
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
    
    func putDataInDrops(sr:[String],sid:[Int],dr:[String],did:[Int],nn:[String],ni:[Int])  {
        self.cityArray = sr
        self.areaArray = dr
        self.cityIDSArray = sid
        areaIDSArray = did
        pharamacyNameArray=nn
        pharamacyNameIDSArray=ni
    }
    
    func openTheseViewsOrHide(isVale:Bool)  {
        [mainDropView,mainDrop2View,mainDrop3View,orLabel].forEach({$0.isHide(isVale)})
        addressMainView.isHide(!isVale)
    }
    
    
    @objc  func handleDelvieryCheck(sender:UISwitch)  {
        pharamacyLocationViewModel.delivery = sender.isOn ? 0 : 1
    }
    
    @objc  func handleInsuracneCheck(sender:UISwitch)  {
        pharamacyLocationViewModel.insuranceCompany = sender.isOn ? 0 : 1
    }
    
    @objc  func handleOpenLocation()  {
        handlerChooseLocation?()
    }
    
}
