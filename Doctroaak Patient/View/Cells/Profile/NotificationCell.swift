//
//  NotificationCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MOLH
import SDWebImage


class NotificationCell: BaseCollectionCell {
    
    var notify:PatientNotificationModel? {
        didSet{
            guard let notu = notify else { return  }
            let title = MOLHLanguage.isRTLLanguage() ? notu.titleAr :  notu.titleEn
            let order = MOLHLanguage.isRTLLanguage() ? notu.messageAr :  notu.messageEn
            
            notifyDetailsLabel.text = "\(title) \n \(order)"
            
            let urlString = notu.icon
            
            
            guard let url = URL(string: urlString),let dd = notu.createdAt.toDates() else { return  }
            notifyProfileImage.sd_setImage(with: url)
            let dateString = notu.createdAt.timeAgoSinceDate( dd, currentDate: Date(), numericDates: true)
            notifyDateLabel.text = dateString
        }
    }
    
    
    lazy var notifyProfileImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)
        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 80)
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        return i
    }()
    lazy var notifyDateLabel = UILabel(text: "12:30 pm", font: .systemFont(ofSize: 16), textColor: .lightGray)
    
    lazy var notifyDetailsLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black,textAlignment: .left,numberOfLines: 0)
    
   
    
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
    
   
    
  override  func setupViews() {
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 16
        clipsToBounds = true
        notifyDateLabel.constrainHeight(constant: 20)
        let s = hstack(UIView(),notifyDateLabel)
        let ff = stack(notifyDetailsLabel,s,spacing:16)
        
        let d = stack(notifyProfileImage,UIView()).padTop(16)
        
        hstack(d,ff,spacing:16).withMargins(.init(top: 0, left: 16, bottom: 8, right: 8))
        
    }
}
