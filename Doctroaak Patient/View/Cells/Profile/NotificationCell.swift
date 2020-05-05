//
//  NotificationCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit




class NotificationCell: BaseCollectionCell {
    
    lazy var notifyProfileImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)
        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 80)
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        return i
    }()
    lazy var notifyDateLabel = UILabel(text: "12:30 pm", font: .systemFont(ofSize: 16), textColor: .lightGray)
    
    lazy var notifyDetailsLabel = UILabel(text: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.", font: .systemFont(ofSize: 16), textColor: .black,textAlignment: .left,numberOfLines: 0)
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5
        self.contentView.layer.cornerRadius = 5
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowPath = shadowPath.cgPath
    }
    
  
    
    override func setupViews() {
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 16
        clipsToBounds = true
        notifyDateLabel.constrainHeight(constant: 20)
        let s = hstack(UIView(),notifyDateLabel)
        let ff = stack(notifyDetailsLabel,s,spacing:16)
        
        let d = stack(notifyProfileImage,UIView())
        
     hstack(d,ff,spacing:16).withMargins(.init(top: 8, left: 16, bottom: 8, right: 8))
        
    }
}
