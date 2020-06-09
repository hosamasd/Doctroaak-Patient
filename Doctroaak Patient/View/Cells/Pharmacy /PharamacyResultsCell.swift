//
//  PharamacyResultsCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 6/1/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SDWebImage
import MOLH

class PharamacyResultsCell: BaseCollectionCell {
    
 var pharamacy:PharamacySearchModel?{
        didSet{
            guard let pharamacy = pharamacy else { return  }
            let name = MOLHLanguage.isRTLLanguage() ?  pharamacy.nameAr ?? pharamacy.name : pharamacy.name
            let city = getCityFromIndex(pharamacy.city)
            let area = getAreaFromIndex(pharamacy.area)
            let avaible = pharamacy.active == 1 ? "Available".localized : "UnAvailable".localized
            
            putAttributedText(la: profileInfoLabel, ft: name+"\n", st: " \(area), \(city)")
            
            profileInfoDeliveryyLabel.text = "Delivery is".localized + " \(avaible)"
            let urlString = pharamacy.photo
            guard let url = URL(string: urlString) else { return  }
            profileImage.sd_setImage(with: url)
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
    lazy var profileInfoLabel:UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        return l
    }()
    lazy var profileInfoDeliveryyLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black)
    
    
    lazy var profileInfoAvailbilityButton = createImagess(image: #imageLiteral(resourceName: "available"))
    
    
    lazy var firstStack:UIStackView = {
        let b =  hstack(profileInfoAvailbilityButton,profileInfoDeliveryyLabel,spacing:8)
        return b
    }()
    
    
    
    
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
        [profileInfoLabel,profileInfoDeliveryyLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})

        
        let ss = stack(profileImage,UIView())
        let dd = stack(profileInfoLabel,firstStack).withMargins(.init(top: -16, left: 0, bottom: 0, right: 0))
        
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
    
    
}


