//
//  MainLeftMenuCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import MOLH

class MainLeftMenuCell: BaseCollectionCell {
    
    
    
    lazy var Image6:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_phone_24px"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        return i
    }()
    lazy var Label6 = UILabel(text: "Contact Us", font: .systemFont(ofSize: 24), textColor: .black,textAlignment: MOLHLanguage.isRTLLanguage() ? .right : .left)
    
    override var isSelected: Bool{
        didSet{
            backgroundColor = isSelected ? #colorLiteral(red: 0.7068013549, green: 0.5222674012, blue: 0.999304831, alpha: 1) : .white
        }
    }
    
    
    override  func setupViews() {
        MOLHLanguage.isRTLLanguage() ? hstack(Image6,Label6,UIView(),spacing:16,alignment: .center).withMargins(.init(top: 8, left: 0, bottom: 8, right: 0)) : hstack(Image6,Label6,spacing:16,alignment: .center).withMargins(.init(top: 8, left: 0, bottom: 8, right: 0))

    }
}
