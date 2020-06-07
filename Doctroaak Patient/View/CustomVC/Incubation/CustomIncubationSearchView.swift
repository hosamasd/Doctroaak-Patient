//
//  CustomIncubationSearchView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import iOSDropDown
import TTSegmentedControl
import MOLH

class CustomIncubationSearchView: CustomBaseView {
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116").withRenderingMode(.alwaysOriginal))
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
    lazy var titleLabel = UILabel(text: "Incubation".localized, font: .systemFont(ofSize: 35), textColor: .white)
    lazy var userSpecificationLabel = UILabel(text: "Select Your Location".localized, font: .systemFont(ofSize: 16), textColor: .white)
    
    
    
    lazy var mainDropView = makeMainSubViewWithAppendView(vv: [cityDrop])
    lazy var cityDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left

        i.arrowSize = 20
        i.placeholder = "City".localized
        i.didSelect { (txt, index, _) in
            self.getAreaAccordingToCityId(index: index)
            
            self.incubationSearchViewModel.city = self.cityIDSArray[index]//index+1
        }
        return i
    }()
    lazy var mainDrop2View = makeMainSubViewWithAppendView(vv: [areaDrop])
    lazy var areaDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left

        i.arrowSize = 20
        i.placeholder = "Area".localized
        i.didSelect {[unowned self] (txt, index, _) in
            self.incubationSearchViewModel.area = self.areaIDSArray[index]//index+1
            
        }
        return i
    }()
    
    lazy var searchSegmentedView:TTSegmentedControl = {
        let view = TTSegmentedControl()
        view.itemTitles = ["Search by city and area".localized,"Search by address".localized]
        view.allowChangeThumbWidth = false
        view.constrainHeight(constant: 50)
        view.thumbGradientColors = [#colorLiteral(red: 0.6887479424, green: 0.4929093719, blue: 0.9978651404, alpha: 1),#colorLiteral(red: 0.5526981354, green: 0.3201900423, blue: 1, alpha: 1)]
        view.useShadow = true
        view.didSelectItemWith = {[unowned self] (index, title) in
            index == 0 ?      self.openTheseViewsOrHide(hide: true, vv: self.mainDrop2View,self.mainDropView,ss:self.addressMainView) : self.openTheseViewsOrHide(hide: false, vv: self.mainDrop2View,self.mainDropView,ss:self.addressMainView)
            self.incubationSearchViewModel.isFirstOpetion = index == 0 ? true : false
        }
        return view
    }()
    
    
    
    lazy var addressMainView:UIView = {
        let v = makeMainSubViewWithAppendView(vv: [addressImage,addressLabel])
        v.isHide(true)
        v.hstack(addressLabel,addressImage).withMargins(.init(top: 4, left: 16, bottom: 4, right: 0))
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenLocation)))
        
        return v
    }()
    lazy var addressLabel = UILabel(text: "Address".localized, font: .systemFont(ofSize: 14), textColor: .lightGray,numberOfLines: 3)
    lazy var addressImage:UIImageView = {
        let v = UIImageView(image: #imageLiteral(resourceName: "Group 4174"))
        v.isUserInteractionEnabled = true
        v.contentMode = .scaleAspectFill
        v.constrainWidth(constant: 60)
        
        return v
    }()
    lazy var searchButton:UIButton = {
        let button = UIButton()
        button.setTitle("Search".localized, for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    let incubationSearchViewModel = IncubationSearchViewModel()
    var handlerChooseLocation:(()->Void)?
    var cityArray = [String]() //["one","two","three","sdfdsfsd"]
    var areaArray = [String]()
    
    var cityIDSArray = [Int]() //["one","two","three","sdfdsfsd"]
    var areaIDSArray = [Int]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if searchButton.backgroundColor == nil {
            
            addGradientInSenderAndRemoveOther(sender: searchButton)
            searchButton.setTitleColor(.white, for: .normal)
        }
        
    }
    
    
    override func setupViews() {
        
        //        [mainDropView,mainDrop2View].forEach({$0.isHide(true)})
        let textStack = getStack(views: mainDropView,mainDrop2View,addressMainView, spacing: 16, distribution: .fillEqually, axis: .vertical)
        //        let text2Stack = getStack(views: addressTextField,insuranceTextField, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
        
        [cityDrop,areaDrop].forEach({$0.fillSuperview(padding: .init(top: 8, left: 16, bottom: 8, right: 16))})
        addSubViews(views: LogoImage,backImage,titleLabel,userSpecificationLabel,textStack,searchButton,searchSegmentedView)
        
        NSLayoutConstraint.activate([
            textStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            textStack.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 120),
            
        ])
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        //        notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        userSpecificationLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        searchSegmentedView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 46, bottom: 0, right: 32))
        
        textStack.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 46, bottom: 0, right: 0))
        //        text2Stack.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 46, bottom: 0, right: 0))
        
        searchButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
        
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
            //            self.areaNumberArray = cityIdArra
            
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
    
    fileprivate func fetchData()  {
        
        fetchEnglishData(isArabic: MOLHLanguage.isRTLLanguage())
    }
    
    fileprivate func fetchEnglishData(isArabic:Bool) {
        if isArabic {
            
            
            if  let cityArray = userDefaults.value(forKey: UserDefaultsConstants.cityNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.cityIdArray) as? [Int],let arasNames = userDefaults.value(forKey: UserDefaultsConstants.areaNameArray) as? [String] , let areaIds =  userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int]  {
                
                putDataInDrops(sr: cityArray, sid: cityIds, dr: arasNames, did:areaIds )
                
                
            }
        }else {
            if  let cityArray = userDefaults.value(forKey: UserDefaultsConstants.cityNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.cityIdArray) as? [Int],let degreeNames = userDefaults.value(forKey: UserDefaultsConstants.areaNameArray) as? [String] , let degreeIds =  userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int]  {
                putDataInDrops(sr: cityArray, sid: cityIds, dr: degreeNames, did:degreeIds )
                
            }
        }
        self.cityDrop.optionArray = cityArray
        self.areaDrop.optionArray = areaArray
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
    
    func putDataInDrops(sr:[String],sid:[Int],dr:[String],did:[Int])  {
        self.cityArray = sr
        self.areaArray = dr
        self.cityIDSArray = sid
        areaIDSArray = did
    }
    
    func openTheseViewsOrHide(hide:Bool,vv:UIView...,ss:UIView)  {
        vv.forEach({$0.isHide(!hide)})
        ss.isHide(hide)
    }
    
    
    
    @objc  func handleOpenLocation()  {
        handlerChooseLocation?()
    }
    
}
