//
//  ICUResultsCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH

class ICUResultsCell: BaseCollectionCell {
    
    var icu:ICUFilterModel? {
        didSet{
            guard let inc = icu else { return  }
                       let name = MOLHLanguage.isRTLLanguage() ? inc.nameAr : inc.name
                       let des = MOLHLanguage.isRTLLanguage() ? inc.descriptionAr : inc.datumDescription
                       
                       putAttributedText(la: profileInfoLabel, ft: name+"\n", st: des)
                       profileInfoAvalibalityLabel.text = "Avilabilty seats".localized + " : \(inc.bedNumber)"
        }
    }
    
    var incubation:IncubtionSearchModel? {
           didSet{
               guard let inc = incubation else { return  }
                          let name = MOLHLanguage.isRTLLanguage() ? inc.nameAr : inc.name
                          let des = MOLHLanguage.isRTLLanguage() ? inc.descriptionAr : inc.datumDescription
                          
                          putAttributedText(la: profileInfoLabel, ft: name+"\n", st: des)
                          profileInfoAvalibalityLabel.text = "Avilabilty seats".localized + " : \(inc.bedNumber)"
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
        l.numberOfLines = 2
        l.textAlignment =  MOLHLanguage.isRTLLanguage() ? .right : .left
        return l
    }()
    lazy var profileInfoAvalibalityLabel = UILabel(text: "Avilabilty seats :  12", font: .systemFont(ofSize: 16), textColor: .black,textAlignment: MOLHLanguage.isRTLLanguage() ? .right : .left)
    
    
    lazy var profileInfoAvailbilityButton = createImagess(image: #imageLiteral(resourceName: "available"))
    
    
    lazy var firstStack:UIStackView = {
        let b =  hstack(profileInfoAvailbilityButton,profileInfoAvalibalityLabel,spacing:8)
        return b
    }()
    
    
    
    
    fileprivate func setupShadowss() {
        layer.masksToBounds = false
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 20)
        layer.shadowRadius = 20
        layer.opacity = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadowss()
        //        setupShadow(opacity: 1, radius: 20, offset: .init(width: 0, height: 20), color: .red)
        setupViewss()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewss() {
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
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
