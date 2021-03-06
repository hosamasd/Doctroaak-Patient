//
//  CustomMainServicesView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH

class CustomMainServicesView: CustomBaseView {
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: MOLHLanguage.isRTLLanguage() ? #imageLiteral(resourceName: "left-arrow") :  #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    
    lazy var titleLabel = UILabel(text: "Service".localized, font: .systemFont(ofSize: 30), textColor: .white,textAlignment: MOLHLanguage.isRTLLanguage() ? .right : .left)
    lazy var soonLabel = UILabel(text: "Get well soon!".localized, font: .systemFont(ofSize: 18), textColor: .white,textAlignment: MOLHLanguage.isRTLLanguage() ? .right : .left)
    
    lazy var main3View = createMainView(vv: Image3, vv2: label3)
    lazy var main2View = createMainView(vv: Image2, vv2: label2)
    lazy var main1View = createMainView(vv: Image1, vv2: label1)
    lazy var main4View = createMainView(vv: Image4, vv2: label4)
    lazy var main5View = createMainView(vv: Image5, vv2: label5)
    lazy var main6View = createMainView(vv: Image6, vv2: label6)
    lazy var main7View = createMainView(vv: Image7, vv2: label7)
    
    lazy var label1 =  createLabels(tx: "  Doctor".localized)
    lazy var label2 = createLabels(tx: "  Medical Center".localized)
    lazy var label3 = createLabels(tx: "  Pharmacy ".localized)
    lazy var label4 =  createLabels(tx: "  Lab".localized)
    lazy var label5 =  createLabels(tx: "  Radiology".localized)
    lazy var label6 =  createLabels(tx: "  Incubation".localized)
    lazy var label7 =  createLabels(tx: "  I.C.U".localized)
    
    
    
    lazy var Image1:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4150"))
        i.contentMode = .scaleAspectFill
        
        return i
    }()
    
    lazy var Image2:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4140"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    
    lazy var Image3:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4146"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    
    lazy var Image4:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4144"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var Image5:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "x-ray (1)"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    
    lazy var Image6:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4174-3"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    
    lazy var Image7:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4175-1"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    
    
    
    
    
    override func setupViews() {
        
        [Image1,Image2,Image3,Image4,Image5,Image6,Image7].forEach({$0.constrainWidth(constant: 80)})
        
        main3View.hstack(Image3,label3,spacing:16)
        main2View.hstack(Image2,label2,spacing:16)
        main1View.hstack(Image1,label1,spacing:16)
        main4View.hstack(Image4,label4,spacing:16)
        main5View.hstack(Image5,label5,spacing:16)
        main6View.hstack(Image6,label6,spacing:16)
        main7View.hstack(Image7,label7,spacing:16)
        
        let ss = getStack(views: main1View,main2View,main3View,main4View,main5View,main6View,main7View, spacing: 8, distribution: .fillEqually, axis: .vertical)
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,ss)
        
        if MOLHLanguage.isRTLLanguage() {
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
      }else {
            
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
       }
       backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        ss.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 46, bottom: 0, right: 32))
        
        
    }
    
    fileprivate func createMainView(vv:UIView,vv2:UIView) -> UIView {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.clipsToBounds = true
        v.addSubViews(views: vv,vv)
        v.constrainHeight(constant: 80)
        return v
    }
    
    func createLabels(tx:String) ->UILabel {
        return UILabel(text: tx, font: .systemFont(ofSize: 16), textColor: .black, textAlignment: MOLHLanguage.isRTLLanguage() ? .right : .left)
    }
}




