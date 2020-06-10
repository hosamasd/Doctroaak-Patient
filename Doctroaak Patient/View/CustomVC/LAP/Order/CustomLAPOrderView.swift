//
//  CustomLAPOrderView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import iOSDropDown
import TTSegmentedControl
import MOLH

class CustomLAPOrderView: CustomBaseView {
    
    var index:Int? {
        didSet{
            guard let index = index else { return  }
            orderSegmentedView.itemTitles = index == 0 ? ["prescription".localized,"Request an analysis".localized,"All".localized] : ["prescription".localized,"Request a ray".localized,"All".localized]
            addLapCollectionVC.index=index
            nameDrop.optionArray = index == 0 ? labNameArray : radiologyNameArray
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
        view.itemTitles = ["prescription".localized,"Request an analysis".localized,"All".localized]
        
        view.allowChangeThumbWidth = true
        view.constrainHeight(constant: 50)
        view.thumbGradientColors = [#colorLiteral(red: 0.6887479424, green: 0.4929093719, blue: 0.9978651404, alpha: 1),#colorLiteral(red: 0.5526981354, green: 0.3201900423, blue: 1, alpha: 1)]
        view.useShadow = true
        return view
    }()
    lazy var centerImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "2454170"))
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFit
        i.clipsToBounds = true
        return i
    }()
    lazy var rosetaImageView:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "2454170"))
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.constrainHeight(constant: 200)
        return i
    }()
    lazy var uploadView:UIView = {
        let v = makeMainSubViewWithAppendView(vv: [uploadLabel,uploadImage])
        v.constrainHeight(constant: 60)
        return v
    }()
    lazy var uploadLabel = UILabel(text: "Upload prescription".localized, font: .systemFont(ofSize: 20), textColor: .lightGray,textAlignment: .center)
    
    lazy var uploadImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4174"))
        i.constrainWidth(constant: 80)
        return i
    }()
    lazy var orLabel:UILabel = {
        let l = UILabel(text: "OR".localized, font: .systemFont(ofSize: 18), textColor: .black,textAlignment: .center)
        l.isHide(true)
        return l
    }()
    lazy var mainDropView = makeMainSubViewWithAppendView(vv: [nameDrop])
    lazy var nameDrop:DropDown = {
        let i = returnMainDropDown(bg: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1), plcae: "Name")

//        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
//        i.arrowSize = 20
//        i.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left
//        i.textColor = .black
//        i.rowBackgroundColor = .gray
//        i.attributedPlaceholder = NSAttributedString(string: "Name".localized,attributes: [.foregroundColor: UIColor.black])

        i.didSelect {[unowned self] (txt, indexx, _) in
            self.selectedName = txt
            self.laPOrderViewModel.index = self.index
            if self.index == 0 {
                self.laPOrderViewModel.name  = self.labNameIDSArray[indexx]
            }else{
                self.laPOrderViewModel.name = self.radiologyIDSArray[indexx]
                
            }        }
        return i
    }()
    lazy var firstStack:UIStackView = {
        let s = stack(rosetaImageView,uploadView,spacing:16)
        return s
    }()
    lazy var addLapCollectionVC:AddLapCollectionVC = {
        let vc = AddLapCollectionVC()
        vc.handleRemoveItem = {[unowned self] item,index in
            self.handleRemoveItem?(item,index)
        }
        return vc
    }()
    lazy var addMoreImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4178"))
        i.isUserInteractionEnabled = true
        i.constrainWidth(constant: 60)
        i.constrainHeight(constant: 60)
        i.clipsToBounds = true
        i.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddMore)))
        
        return i
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
    lazy var secondStack :UIStackView = {
        let dd = getStack(views: UIView(),addMoreImage, spacing: 16, distribution: .fill, axis: .horizontal)
        
        let s = getStack(views: mainDropView,dd,addLapCollectionVC.view, spacing: 16, distribution: .fill, axis: .vertical)
        s.isHide(true)
        return s
    }()
    var handleRemoveItem:((RadiologyOrderModel,IndexPath)->Void)?
    
    var constainedLogoAnchor:AnchoredConstraints!
    var bubleViewBottomTitleConstraint:NSLayoutConstraint!
    var bubleViewCenterImgHeightConstraint:NSLayoutConstraint!
    var bubleViewTopSegConstraint:NSLayoutConstraint!
    var selectedName = ""
    
    var labId:Int? {
        didSet{
            guard let labId = labId else { return  }
            if index == 0 {
                //                laPOrderViewModel.
            }
        }
    }
    
    
    
    var isDataFound = false
    var isSecondIndex = false
    var labNameArray = [String]()
    var radiologyNameArray = [String]()
    
    var labNameIDSArray = [Int]()
    var radiologyIDSArray = [Int]()
    let laPOrderViewModel = LAPOrderViewModel()
    var apiToken:String?
    var patientId:Int? 
    
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
            
            
            if  let cityArray = userDefaults.value(forKey: UserDefaultsConstants.labAnalysisNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.labAnalysisIdArray) as? [Int],let arasNames = userDefaults.value(forKey: UserDefaultsConstants.radAnalysisNameArray) as? [String] , let areaIds =  userDefaults.value(forKey: UserDefaultsConstants.radAnalysisIdArray) as? [Int] {
                
                putDataInDrops(sr: cityArray, sid: cityIds, dr: arasNames, did:areaIds )
                
                
                
            }
        }else {
            if  let cityArray = userDefaults.value(forKey: UserDefaultsConstants.labAnalysisNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.labAnalysisIdArray) as? [Int],let degreeNames = userDefaults.value(forKey: UserDefaultsConstants.radAnalysisNameArray) as? [String] , let degreeIds =  userDefaults.value(forKey: UserDefaultsConstants.radAnalysisIdArray) as? [Int]  {
                putDataInDrops(sr: cityArray, sid: cityIds, dr: degreeNames, did:degreeIds )
                
            }
        }
        
//        self.nameDrop.optionArray = index == 0 ?  labNameArray : radiologyNameArray
        
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
    
    
    
    override func setupViews() {
        [soonLabel,titleLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        let mainStacxk = getStack(views: firstStack,orLabel,secondStack, spacing: 16, distribution: .fill, axis: .vertical)
        
        mainDropView.hstack(nameDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        uploadView.hstack(uploadImage,uploadLabel)
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,orderSegmentedView,mainStacxk,nextButton)
        
        if MOLHLanguage.isRTLLanguage() {
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
        }else {
            
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        }
        //        constainedLogoAnchor = LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: backImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -80, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        orderSegmentedView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 108, left: 46, bottom: 0, right: 32))
        mainStacxk.anchor(top: orderSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nextButton.topAnchor, trailing: trailingAnchor,padding: .init(top: 24, left: 46, bottom: 32, right: 32))
        
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
    func makeTheseChanges(hide:Bool,height:CGFloat,all:Bool? = true)  {
        
        if all ?? true {
            
            
            [self.mainDropView,addMoreImage].forEach({$0.isHide(hide)})
            [self.centerImage,self.uploadView].forEach({$0.isHide(!hide)})
            self.orLabel.isHide(true)
        }else {
            [self.mainDropView,self.orLabel,self.centerImage,self.uploadView,addMoreImage].forEach({$0.isHide(false)})
        }
    }
    
    func updateOtherLabels(img:UIImage,tr:CGFloat,tops:CGFloat,bottomt:CGFloat,log:CGFloat,centerImg:CGFloat) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.LogoImage.image = img
            self.constainedLogoAnchor.trailing?.constant = tr
            self.constainedLogoAnchor.leading?.constant = log
            self.bubleViewBottomTitleConstraint.constant = bottomt
            self.bubleViewTopSegConstraint.constant = tops
            self.bubleViewCenterImgHeightConstraint.constant = centerImg
            
        })
    }
    
    
    func putDataInDrops(sr:[String],sid:[Int],dr:[String],did:[Int])  {
        self.labNameArray=sr
        self.labNameIDSArray=sid
        self.radiologyNameArray=dr
        self.radiologyIDSArray=did
    }
    
    @objc  func handleAddMore()  {
        guard let name = laPOrderViewModel.name else {print("all fields required"); return  }
        nameDrop.text = "Name".localized
        nameDrop.selectedIndex = -1
        
        let text = selectedName
        
//        addLapCollectionVC.medicineTextsArray.append(text)
        let order = RadiologyOrderModel(raysID: name)
        addLapCollectionVC.medicineArray.append(order)
        
        
        DispatchQueue.main.async {
            self.addLapCollectionVC.collectionView.reloadData()
            self.laPOrderViewModel.orderDetails = self.addLapCollectionVC.medicineArray
        }    }
    
}
