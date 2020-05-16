//
//  LAPResultsCelllll.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import SDWebImage
import MOLH

class  LAPResultsCelllll: BaseCollectionCell {
    
    var lab:LapSearchModel!{
        didSet{
            
            
            let name = MOLHLanguage.isRTLLanguage() ?  lab.nameAr ?? lab.name : lab.name
            let city = getCityFromIndex(lab.city)
            let area = getAreaFromIndex(lab.area)
            
            
            let attributeText = NSMutableAttributedString(string: name+"\n", attributes:  [.font : UIFont.boldSystemFont(ofSize: 18)])
            attributeText.append(NSAttributedString(string: "\(area), \(city) \n\n", attributes: [.font : UIFont.systemFont(ofSize: 16),.foregroundColor: UIColor.gray]))
            profileInfoLabel.attributedText = attributeText
            profileInfoDeliveryyLabel.text = lab.delivery
            let urlString = lab.photo
            guard let url = URL(string: urlString), let lat = lab.latt.toDouble(),let lng = lab.lang.toDouble() else { return  }
            profileImage.sd_setImage(with: url)
            handleGetLocation?(lat,lng)
            
        }
    }
    
    var rad:RadiologySearchModel!{
        didSet{
            let name = MOLHLanguage.isRTLLanguage() ?  rad.nameAr ?? rad.name : rad.name
            let city = getCityFromIndex(rad.city)
            let area = getAreaFromIndex(rad.area)
            
            let attributeText = NSMutableAttributedString(string: name, attributes:  [.font : UIFont.boldSystemFont(ofSize: 18)])
            attributeText.append(NSAttributedString(string: "\(area), \(city) \n\n", attributes: [.font : UIFont.systemFont(ofSize: 16),.foregroundColor: UIColor.gray]))
            profileInfoLabel.attributedText = attributeText
            profileInfoDeliveryyLabel.text = rad.delivery
            let urlString = rad.photo
            guard let url = URL(string: urlString), let lat = rad.latt.toDouble(),let lng = rad.lang.toDouble() else { return  }
            profileImage.sd_setImage(with: url)
            handleGetLocation?(lat,lng)
        }
    }
    
    
    lazy var profileImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)
        i.constrainWidth(constant: 60)
        i.constrainHeight(constant: 60)
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        return i
    }()
    lazy var locationImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4174"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 60)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var profileInfoLabel:UILabel = {
        let l = UILabel()
        let attributeText = NSMutableAttributedString(string: "Dr. Hagar Mohamed \n", attributes:  [.font : UIFont.boldSystemFont(ofSize: 18)])
        attributeText.append(NSAttributedString(string: "Mokattam, Giza \n\n", attributes: [.font : UIFont.systemFont(ofSize: 16),.foregroundColor: UIColor.gray]))
        l.attributedText = attributeText
        l.numberOfLines = 2
        return l
    }()
    lazy var profileInfoDeliveryyLabel = UILabel(text: "Delivery available", font: .systemFont(ofSize: 16), textColor: .black)
    
    
    lazy var profileInfoAvailbilityButton = createImagess(image: #imageLiteral(resourceName: "available"))
    
    
    lazy var firstStack:UIStackView = {
        let b =  hstack(profileInfoAvailbilityButton,profileInfoDeliveryyLabel,spacing:8)
        return b
    }()
    
    var handleGetLocation:((Double,Double) ->Void)?
    
    
    
    fileprivate func setupShadowss() {
        layer.masksToBounds = false
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 20)
        layer.shadowRadius = 20
        layer.opacity = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadowss()
        setupViewss()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewss() {
        backgroundColor = .white
        let ddx = hstack(UIView(),locationImage, spacing: 16)
        
        let ss = stack(profileImage,UIView())
        let dd = stack(profileInfoLabel,firstStack,ddx).withMargins(.init(top: -16, left: 0, bottom: 0, right: 0))
        
        hstack(ss,dd,spacing:16).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
        //        stack(total,seperatorView,bottom,spacing:8).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
        
        
    }
    
    func createImagess(image:UIImage) -> UIImageView {
        let b = UIImageView(image: image)
        //        b.setImage(image, for: .normal)
        b.constrainWidth(constant: 20)
        b.constrainHeight(constant: 20)
        return b
    }
    
    func getCityFromIndex(_ index:Int) -> String {
        var citName = [String]()
        var cityId = [Int]()
        
        if let  cityArray = userDefaults.value(forKey: UserDefaultsConstants.cityNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.cityIdArray) as? [Int]{
            
            citName = cityArray
            cityId = cityIds
            
            
            
        }else {
            if let cityArray = userDefaults.value(forKey: UserDefaultsConstants.cityNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.cityIdArray) as? [Int] {
                citName = cityArray
                cityId = cityIds
            }
        }
        let ss = cityId.filter{$0 == index}
        let ff = ss.first ?? 1
        
        return citName[ff - 1 ]
    }
    
    func getAreaFromIndex(_ index:Int) -> String {
        var citName = [String]()
        var cityId = [Int]()
        if let  cityArray = userDefaults.value(forKey: UserDefaultsConstants.areaNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int]{
            
            citName = cityArray
            cityId = cityIds
            
            
            
        }else {
            if let cityArray = userDefaults.value(forKey: UserDefaultsConstants.areaNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int] {
                citName = cityArray
                cityId = cityIds
            }
        }
        let ss = cityId.filter{$0 == index}
        let ff = ss.first ?? 1
        return citName[ff-1]
    }
}

