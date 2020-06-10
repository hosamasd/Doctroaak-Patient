//
//  CustomAndLAPOrderView.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/16/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import iOSDropDown
import TTSegmentedControl
import MOLH

class CustomAndLAPOrderView: CustomBaseView {
    
    var index:Int!{
        didSet{
            self.nameDrop.optionArray = index == 0 ?  labNameArray : radiologyNameArray
            
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
    lazy var titleLabel = UILabel(text: "Order ", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Order your request", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var orderSegmentedView:TTSegmentedControl = {
        let view = TTSegmentedControl()
        view.itemTitles = ["prescription","Request a medicine","All"]
        
        view.allowChangeThumbWidth = true
        view.constrainHeight(constant: 50)
        view.thumbGradientColors = [#colorLiteral(red: 0.6887479424, green: 0.4929093719, blue: 0.9978651404, alpha: 1),#colorLiteral(red: 0.5526981354, green: 0.3201900423, blue: 1, alpha: 1)]
        view.useShadow = true
        //        view.selectItemAt(index: 2)
        return view
    }()
    
    //    func hideOrUndie(index:Int)  {
    //        self.laPOrderViewModel.isFirstOpetion = index == 0 ? true : false
    //        self.laPOrderViewModel.isSecondOpetion = index == 1 ? true : false
    //        self.laPOrderViewModel.isThirdOpetion = index == 2 ? true : false
    //        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {[unowned self] in
    //            self.secondStack.isHide(index == 0 ? true : false)
    //            self.orLabel.isHide(index == 2 ? false :  true)
    //            self.firstStack.isHide(index == 1 ? true : false)
    //
    //        })
    //    }
    
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
        v.hstack(uploadImage,uploadLabel).padLeft(-80)
        
        return v
    }()
    lazy var uploadLabel = UILabel(text: "Upload prescription", font: .systemFont(ofSize: 20), textColor: .lightGray,textAlignment: .center)
    
    lazy var uploadImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4174-1"))
        i.contentMode = .scaleAspectFit
        //        i.constrainWidth(constant: 60)
        return i
    }()
    lazy var mainDropView = makeMainSubViewWithAppendView(vv: [nameDrop])
    lazy var nameDrop:DropDown = {
        let i = returnMainDropDown(bg: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1), plcae: "Name")

//        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
//        i.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left
//        i.textColor = .black
//        i.rowBackgroundColor = .gray
//        i.attributedPlaceholder = NSAttributedString(string: "Name".localized,attributes: [.foregroundColor: UIColor.black])
//
//        i.arrowSize = 20
        i.didSelect {[unowned self] (txt, indexx, _) in
            self.laPOrderViewModel.index = self.index
            if self.index == 0 {
                self.laPOrderViewModel.name  = self.labNameIDSArray[indexx]
            }else{
                self.laPOrderViewModel.name = self.radiologyIDSArray[indexx]
            }
        }
        
        return i
    }()
    
    
    lazy var addssLapCollectionVC:AddLapCollectionVC = {
        let vc = AddLapCollectionVC()
        vc.view.backgroundColor = .red
        vc.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handles)))
//        vc.collectionView.backgroundColor = .red
//        vc.collectionView.isHide(false)
//                vc.collectionView.constrainHeight(constant: 150)
//        vc.collectionView.reloadData()
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
        //        let s = getStack(views: mainDropView,addLapCollectionVC.view, spacing: 16, distribution: .fillProportionally, axis: .vertical)
        
        let s = getStack(views: mainDropView,dd,addssLapCollectionVC.view,UIView(backgroundColor: .yellow), spacing: 16, distribution: .fill, axis: .vertical)
        //        s.isHide(true)
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
    
    let laPOrderViewModel = LAPOrderViewModel()
    
    var labNameArray = [String]()
    var radiologyNameArray = [String]()
    
    var labNameIDSArray = [Int]()
    var radiologyIDSArray = [Int]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addssLapCollectionVC.collectionView.constrainHeight(constant: 100)
        //        orderSegmentedView.selectItemAt(index: 0)
        
    }
    
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
            
            
            if  let cityArray = userDefaults.value(forKey: UserDefaultsConstants.labNameARArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.labIdArray) as? [Int],let arasNames = userDefaults.value(forKey: UserDefaultsConstants.radiologyNameARArray) as? [String] , let areaIds =  userDefaults.value(forKey: UserDefaultsConstants.radiologyIdArray) as? [Int] {
                
                putDataInDrops(sr: cityArray, sid: cityIds, dr: arasNames, did:areaIds )
                
                
            }
        }else {
            if  let cityArray = userDefaults.value(forKey: UserDefaultsConstants.labNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.labIdArray) as? [Int],let degreeNames = userDefaults.value(forKey: UserDefaultsConstants.radiologyNameArray) as? [String] , let degreeIds =  userDefaults.value(forKey: UserDefaultsConstants.radiologyIdArray) as? [Int]  {
                putDataInDrops(sr: cityArray, sid: cityIds, dr: degreeNames, did:degreeIds )
                
            }
        }
        self.nameDrop.optionArray = index == 0 ?  labNameArray : radiologyNameArray
        
        //        self.nameDrop.optionArray = index == 0 ?  labNameArray : radiologyNameArray
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
    
    override func setupViews() {
        [soonLabel,titleLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})

        mainDropView.hstack(nameDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))

        let mainStacxk = getStack(views: firstStack,orLabel,secondStack, spacing: 16, distribution: .fill, axis: .vertical)
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,orderSegmentedView,mainStacxk,nextButton)
//        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,orderSegmentedView,addssLapCollectionVC.view,nextButton)

        

        if MOLHLanguage.isRTLLanguage() {
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
        }else {
            
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        }
//        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))




        orderSegmentedView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 108, left: 46, bottom: 0, right: 32))
        mainStacxk.anchor(top: orderSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nextButton.topAnchor, trailing: trailingAnchor,padding: .init(top: 24, left: 46, bottom: 32, right: 32))
//        orLabel.anchor(top: firstStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 46, bottom: 32, right: 32))
//        addssLapCollectionVC.view.anchor(top: firstStack.bottomAnchor, leading: leadingAnchor, bottom: nextButton.topAnchor, trailing: trailingAnchor,padding: .init(top: 8, left: 46, bottom: 32, right: 32))

//        mainDropView.anchor(top: addssLapCollectionVC.view.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 46, bottom: 32, right: 32))
//        addssLapCollectionVC.view.anchor(top: mainDropView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 46, bottom: 32, right: 32))


        //        addssLapCollectionVC.view.anchor(top: orderSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 24, left: 46, bottom: 32, right: 32),size: .init(width: 0, height: 200))
        
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
    func putDataInDrops(sr:[String],sid:[Int],dr:[String],did:[Int])  {
        self.labNameArray=sr
        self.labNameIDSArray=sid
        self.radiologyNameArray=dr
        self.radiologyIDSArray=did
    }
    
    @objc  func handleAddMore()  {
        guard let name = laPOrderViewModel.name else {print("all fields required"); return  }
        let order = RadiologyOrderModel(raysID: name)
        addssLapCollectionVC.medicineArray.append(order)
        
        
        DispatchQueue.main.async {
            self.addssLapCollectionVC.collectionView.reloadData()
            self.laPOrderViewModel.orderDetails = self.addssLapCollectionVC.medicineArray
        }
        
        
        print(name)
    }
    
   @objc func handles()  {
        print(96545)
    }
}
