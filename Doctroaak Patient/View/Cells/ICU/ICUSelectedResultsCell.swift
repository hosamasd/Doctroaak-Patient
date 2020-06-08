//
//  ICUSelectedResultsCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH
import SDWebImage

class ICUSelectedResultsCell: BaseCollectionCell {
    
    var icu:ICUFilterModel? {
        didSet{
            guard let ic = icu else { return  }
            
            profileInfoNameLabel.text = MOLHLanguage.isRTLLanguage() ? ic.nameAr : ic.name
            profileInfoDescriptionLabel.text = MOLHLanguage.isRTLLanguage() ?  ic.descriptionAr : ic.datumDescription
            profileInfoAvilabiltyLabel.text = "Avilabilty seats".localized + " :  \(ic.bedNumber)"
            profileInfoCityLabel.text = "City ".localized + " : \(getCityFromIndex(ic.city))"
            profileInfoAreaLabel.text = "Area ".localized + " : \(getAreaFromIndex(ic.area))"
            
            for(index,view) in starsStackView.arrangedSubviews.enumerated(){
                guard let img = view as? UIImageView else {return}
                
                let ratingInt = Int(ic.rate  )
                img.image = index >= ratingInt ?? 0 ? #imageLiteral(resourceName: "star-1") : #imageLiteral(resourceName: "star")
             }
        }
    }
    
    var icubation:IncubtionSearchModel? {
        didSet{
            guard let ic = icubation else { return  }
            
            profileInfoNameLabel.text = MOLHLanguage.isRTLLanguage() ? ic.nameAr : ic.name
            profileInfoDescriptionLabel.text = MOLHLanguage.isRTLLanguage() ?  ic.descriptionAr : ic.datumDescription
            profileInfoAvilabiltyLabel.text = "Avilabilty seats".localized + " :  \(ic.bedNumber)"
            profileInfoCityLabel.text = "City ".localized + " : \(getCityFromIndex(ic.city))"
            profileInfoAreaLabel.text = "Area ".localized + " : \(getAreaFromIndex(ic.area))"
            
            for(index,view) in starsStackView.arrangedSubviews.enumerated(){
                guard let img = view as? UIImageView else {return}
                
                let ratingInt = Int(ic.rate  )
                img.image = index >= ratingInt ?? 0 ? #imageLiteral(resourceName: "star-1") : #imageLiteral(resourceName: "star")
             }
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
    lazy var profileInfoNameLabel = UILabel(text: "Dr. Hagar Mohamed", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var profileInfoDescriptionLabel = UILabel(text: "Description", font: .systemFont(ofSize: 16), textColor: .gray,textAlignment: .left,numberOfLines: 0)

      
    lazy var starsStackView:UIStackView = {
           var arrangedViews = [ UIView]()
           (0..<5).forEach({ (_) in
               let im = UIImageView(image: #imageLiteral(resourceName: "star"))
               im.constrainWidth(constant: 16)
               im.constrainHeight(constant: 24)
               arrangedViews.append(im)
           })
           arrangedViews.append(UIView())
           let stack = UIStackView(arrangedSubviews: arrangedViews)
           return stack
       }()
    lazy var profileInfoAvilabiltyLabel = UILabel(text: "Avilabilty seats".localized + " :  12", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var profileInfoCityLabel = UILabel(text: "City ".localized + " : Cairo", font: .systemFont(ofSize: 16), textColor: .black)
        lazy var profileInfoAreaLabel = UILabel(text: "Area : Eltahrer", font: .systemFont(ofSize: 16), textColor: .black)

        lazy var profileInfoAddressButton = createImagess(image: #imageLiteral(resourceName: "ic_room_24px"))
        lazy var profileInfoReservationButton = createImagess(image: #imageLiteral(resourceName: "ic_date_range_24px"))
        lazy var profileInfoConsultaionButton = createImagess(image: #imageLiteral(resourceName: "avatar"))
        
        lazy var firstStack:UIStackView = {
            let b = MOLHLanguage.isRTLLanguage() ? hstack(profileInfoAvilabiltyLabel,profileInfoAddressButton,spacing:8) : hstack(profileInfoAvilabiltyLabel,profileInfoAddressButton,spacing:8)
            return b
        }()
        lazy var secondStack:UIStackView = {
            let b = MOLHLanguage.isRTLLanguage()  ? hstack(profileInfoCityLabel,profileInfoReservationButton,spacing:8) : hstack(profileInfoReservationButton,profileInfoCityLabel,spacing:8)
            return b
        }()
        lazy var thirdStack:UIStackView = {
            let b = MOLHLanguage.isRTLLanguage() ? hstack(profileInfoAreaLabel,profileInfoConsultaionButton,spacing:8) : hstack(profileInfoConsultaionButton,profileInfoAreaLabel,spacing:8)
            return b
        }()
      
        lazy var totalStackFinished:UIStackView = {
            let b = stack(firstStack,secondStack,thirdStack,spacing:8)
            return b
        }()
        

    override func layoutSubviews() {
        super.layoutSubviews()
//        setupShadow(opacity: 1, radius: 20, offset: CGSize(width: 0, height: 20), color:  UIColor.red)
        self.layer.cornerRadius = 10
           self.layer.borderWidth = 1.0
           self.layer.borderColor = UIColor.lightGray.cgColor

           self.layer.backgroundColor = UIColor.white.cgColor
           self.layer.shadowColor = UIColor.gray.cgColor
           self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
           self.layer.shadowRadius = 2.0
           self.layer.shadowOpacity = 1.0
           self.layer.masksToBounds = false
    }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViewss()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupViewss() {
//            [profileInfoAreaLabel,profileInfoDescriptionLabel,profileInfoAvilabiltyLabel,profileInfoCityLabel,profileInfoAreaLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left })
            backgroundColor = .white
            layer.cornerRadius = 8
            clipsToBounds = true
            let dddd = hstack(profileInfoNameLabel,starsStackView,spacing:8).padTop(16)
            
            let ss = stack(profileImage,UIView())
            let dd = stack(dddd,profileInfoDescriptionLabel,totalStackFinished,spacing:16).withMargins(.init(top: -16, left: 0, bottom: 0, right: 0))
            
            hstack(ss,dd,spacing:16).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
            
            
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
