//
//  AddMedicineCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class AddMedicineCell: BaseCollectionCell {
    
    var med:PharamcyOrderModel?{
        didSet{
            guard let med = med else { return  }
            nameLabel.text = getNameFromIndex(med.medicineID)
            typeLabel.text = getTypeFromIndex(med.medicineTypeID)
            countLabel.text = "\(med.amount)"
        }
    }
    
    var meds:PharamcyWithNameOrderModel?{
           didSet{
               guard let med = meds else { return  }
            nameLabel.text = med.medicineName
            typeLabel.text = med.medicineType
               countLabel.text = "\(med.amount)"
           }
       }
    
    
    lazy var nameLabel = UILabel(text: "Name", font: .systemFont(ofSize: 20), textColor: .black,textAlignment: .left)
    lazy var typeLabel = UILabel(text: "Type", font: .systemFont(ofSize: 20), textColor: #colorLiteral(red: 0.3168245852, green: 0.709082067, blue: 0.8302568793, alpha: 1),textAlignment: .left)
    lazy var countLabel = UILabel(text: "3", font: .systemFont(ofSize: 20), textColor: #colorLiteral(red: 0.3168245852, green: 0.709082067, blue: 0.8302568793, alpha: 1),textAlignment: .center)
    
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
    var handleRemovePharamcay:((PharamcyOrderModel)->Void)?
//    var handleRemovePharamcay:((PharamcyOrderModel,PharamcyWithNameOrderModel)->Void)?

    
    override func setupViews() {
        backgroundColor = .white
        countLabel.constrainWidth(constant: 80)
        hstack(leftImage,nameLabel,typeLabel,countLabel,closeImage,spacing:8,alignment:.center).withMargins(.init(top: 0, left: 8, bottom: 0, right: 8))
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 8, bottom: 0, right: 0))
    }
    
    func getNameFromIndex(_ index:Int) -> String {
           var citName = [String]()
           var cityId = [Int]()
           
           if let  cityArray = userDefaults.value(forKey: UserDefaultsConstants.medicineNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.medicineNameIDSArray) as? [Int]{
               
               citName = cityArray
               cityId = cityIds
               
               
               
           }else {
               if let cityArray = userDefaults.value(forKey: UserDefaultsConstants.medicineNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.medicineNameIDSArray) as? [Int] {
                   citName = cityArray
                   cityId = cityIds
               }
           }
           let ss = cityId.filter{$0 == index}
           let ff = ss.first ?? 1
           
           return citName[ff - 1 ]
       }
    
    func getTypeFromIndex(_ index:Int) -> String {
        var citName = [String]()
        var cityId = [Int]()
        
        if let  cityArray = userDefaults.value(forKey: UserDefaultsConstants.medicineTypeArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.medicineTypeIDSArray) as? [Int]{
            
            citName = cityArray
            cityId = cityIds
            
            
            
        }else {
            if let cityArray = userDefaults.value(forKey: UserDefaultsConstants.medicineTypeArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.medicineTypeIDSArray) as? [Int] {
                citName = cityArray
                cityId = cityIds
            }
        }
        let ss = cityId.filter{$0 == index}
        let ff = ss.first ?? 1
        
        return citName[ff - 1 ]
    }
    
    @objc func handleRemove()  {
        guard let med = med else { return  }
             handleRemovePharamcay?(med)
         }
}
