//
//  CustomICUResultsView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH

class CustomICUResultsView: CustomBaseView {
    
    var index:Int!{
           didSet{
               titleLabel.text = index == 1 ? "I.C.U".localized : "Incubation".localized
               icuResultsCollectionVC.index = index
               
//               if index == 0 {
//                   icuResultsCollectionVC.icuArray=icuArray
//                   
//               }else {
//                   icuResultsCollectionVC.icubationArray = icubationArray
//               }
//               icuResultsCollectionVC.collectionView.reloadData()
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
    lazy var titleLabel = UILabel(text: "I.C.U".localized, font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Get well soon!".localized, font: .systemFont(ofSize: 18), textColor: .white)
    lazy var mainSecondView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var icuResultsCollectionVC:ICUResultsCollectionVC = {
        let vc = ICUResultsCollectionVC()
        vc.handleSelectedItem = {[unowned self] i in
            self.handleSelectedItem?(i)
        }
        vc.handleSecondSelectedItem = {[unowned self] i in
            self.handleSecondSelectedItem?(i)
        }
        return vc
    }()
    var handleSelectedItem:((ICUFilterModel)->Void)?
    var handleSecondSelectedItem:((IncubtionSearchModel)->Void)?
    var icuArray =  [ICUFilterModel]()
    var icubationArray =  [IncubtionSearchModel]()
    
    override func setupViews() {
        [titleLabel,soonLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,icuResultsCollectionVC.view)
        if MOLHLanguage.isRTLLanguage() {
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
        }else {
            
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        }
        //        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        icuResultsCollectionVC.view.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 64, left: 32, bottom: 16, right: 32))
    }
}
