//
//  CustomMainHomeView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class CustomMainHomeView: CustomBaseView {
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var listImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_subject_24px"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var notifyImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_notifications_active_24px"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        return i
    }()
    
    lazy var titleLabel = UILabel(text: "Home", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Get well soon!", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.clipsToBounds = true
        v.addSubViews(views: Image1,label1)
        return v
    }()
    lazy var main2View:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.clipsToBounds = true
        v.constrainHeight(constant: 80)
        v.addSubViews(views: Image2,label2)
        return v
    }()
    lazy var main3View:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.clipsToBounds = true
        v.addSubViews(views: Image3,label3)
        return v
    }()
    
    lazy var label1 =  makeAttributedText(fir: " Find", sec: "Service")
    lazy var label2 =  makeAttributedText(fir: " Favorite", sec: "Doctor")
    lazy var label3 =  makeAttributedText(fir: " My", sec: "Orders")
    
    lazy var Image1:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142-4"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 80)
        
        return i
    }()
    
    lazy var Image2:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4143-2"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 80)
        return i
    }()
    
    lazy var Image3:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4144"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 80)
        return i
    }()
    
    lazy var Image4:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4145"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 80)
        return i
    }()
    
    lazy var baseAdsCell = BaseAdsCell()
    
    
    
    
    override func setupViews() {
        main3View.hstack(Image3,label3)
        main2View.hstack(Image2,label2)
        mainView.hstack(Image1,label1)
        let ss = getStack(views: mainView,main2View,main3View, spacing: 8, distribution: .fillEqually, axis: .vertical)
        
        addSubViews(views: LogoImage,listImage,notifyImage,titleLabel,soonLabel,ss,baseAdsCell)
        
        NSLayoutConstraint.activate([
            ss.centerXAnchor.constraint(equalTo: centerXAnchor),
            ss.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 60)
            ])
        //        ss.centerInSuperview()
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        listImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        ss.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 46, bottom: 0, right: 0))
        
        baseAdsCell.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 32, right: 32))
        
    }
    
    func makeAttributedText(fir:String,sec:String) -> UILabel {
        let l = UILabel()
        let attrString = NSMutableAttributedString()
            .appendWith(color: #colorLiteral(red: 0.246225208, green: 0.2462718487, blue: 0.2462153137, alpha: 1), weight: .regular, ofSize: 16, fir+"\n")
            .appendWith(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), weight: .bold, ofSize: 16, sec)
        l.attributedText = attrString
        l.numberOfLines = 2
        l.textAlignment = .center
        return l
    }
}


