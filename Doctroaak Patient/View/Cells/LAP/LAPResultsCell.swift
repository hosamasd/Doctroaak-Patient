//
//  LAPResultsCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LAPResultsCell: BaseCollectionCell {
    
    
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
    
    
    
    
    fileprivate func etupShadowss() {
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
                etupShadowss()
//        setupShadow(opacity: 1, radius: 20, offset: .init(width: 0, height: 60), color: .red)
        setupViewss()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewss() {
       
       
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

