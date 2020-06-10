//
//  AddLAPCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH

class AddLAPCell: BaseCollectionCell {
    
    var med:RadiologyOrderModel?{
        didSet{
            guard let med = med else { return  }
            
            DispatchQueue.main.async {
                self.nameLabel.text = self.getNameFromIndex(med.raysID)
                
            }
        }
    }
    
    var index = 0
    
    lazy var nameLabel = UILabel(text: "Name", font: .systemFont(ofSize: 20), textColor: .black,textAlignment: .left)
    
    lazy var leftImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Rectangle 1758"))
        //        i.constrainWidth(constant: 80)
        i.constrainWidth(constant: 8)
        i.contentMode = .scaleAspectFit
        return i
    }()
    lazy var closeImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_clear_24px"))
        i.contentMode = .scaleAspectFill
        //        i.constrainWidth(constant: 80)
        i.constrainWidth(constant: 30)
        i.isUserInteractionEnabled = true
        i.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemove)))
        return i
    }()
    lazy var seperatorView:UIView = {
        let v = UIView(backgroundColor: .lightGray)
        v.constrainHeight(constant: 1)
        return v
    }()
    var handleRemoveItem:((RadiologyOrderModel)->Void)?
    
    
    override func setupViews() {
        backgroundColor = .white
        hstack(leftImage,nameLabel,closeImage,spacing:8,alignment:.center).withMargins(.init(top: 0, left: 8, bottom: 0, right: 8))
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 8, bottom: 0, right: 0))
    }
    
    func getNameFromIndex(_ indezx:Int) -> String {
        var citName = [String]()
        var cityId = [Int]()
        
        if self.index == 0 {
            let f = MOLHLanguage.isRTLLanguage() ? UserDefaultsConstants.labAnalysisNameARArray :  UserDefaultsConstants.labAnalysisNameArray
            let ff = UserDefaultsConstants.labAnalysisIdArray
            
            checkLanguage(citName: &citName, cityId: &cityId, nameEn: f, nameId: ff)
            
        }else {
            let f = MOLHLanguage.isRTLLanguage() ? UserDefaultsConstants.radAnalysisNameARArray :  UserDefaultsConstants.radAnalysisNameArray
            let ff = UserDefaultsConstants.radAnalysisIdArray
            
            checkLanguage(citName: &citName, cityId: &cityId, nameEn: f, nameId: ff)
        }
        let ss = cityId.filter{$0 == indezx}
        let ff = ss.first ?? 1
        
        return citName[ff - 1 ]
    }
    
    func checkLanguage(citName: inout [String], cityId:inout [Int],nameEn:String,nameId:String)  {
        if let  cityArray = userDefaults.value(forKey: nameEn) as? [String],let cityIds = userDefaults.value(forKey: nameId) as? [Int]{
            
            citName = cityArray
            cityId = cityIds
        }
        
        
        
        
        
    }
    
    @objc func handleRemove()  {
        guard let med = med else { return  }
        
        handleRemoveItem?(med)
    }
}
