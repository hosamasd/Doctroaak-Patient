//
//  CustomMainHomeView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import MOLH
import SDWebImage

class CustomMainHomeView: CustomBaseView {
    
    var patient:PatienModel?{
        didSet{
            guard let patient = patient,let urlString = patient.insurance?.photo else { return  }
            drInsuranceImage.isHide(false)
            guard let url = URL(string:urlString) else { return  }
            drInsuranceImage.sd_setImage(with: url)
        }
    }
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        
        return i
    }()
    lazy var listImage:UIImageView = {
        let i = UIImageView(image:  #imageLiteral(resourceName: "ic_subject_24px"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        i.translatesAutoresizingMaskIntoConstraints = false
        
        return i
    }()
    lazy var notifyImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_notifications_active_24px")   )// #imageLiteral(resourceName: "ic_notifications_active_24px"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled=true
        return i
    }()
    lazy var drImage:UIImageView = {
           let i = UIImageView(image: #imageLiteral(resourceName: "Group 3795"))
           i.contentMode = .scaleToFill
           i.clipsToBounds = true
           i.constrainWidth(constant: 80)
           //           i.constrainHeight(constant: 400)
           return i
       }()
       lazy var drInsuranceImage:UIImageView = {
           let i = UIImageView(image: #imageLiteral(resourceName: "Group 3795"))
           i.contentMode = .scaleToFill
           i.clipsToBounds = true
           i.constrainWidth(constant: 80)
        i.isHide(true)

           return i
       }()
       lazy var docotrLabel = UILabel(text: "Doctoraak ".localized, font: .systemFont(ofSize: 20), textColor: .white)
    lazy var titleLabel = UILabel(text: "Home".localized, font: .systemFont(ofSize: 30), textColor: .white,textAlignment: MOLHLanguage.isRTLLanguage() ? .right : .left)
    lazy var soonLabel = UILabel(text: "Get well soon!".localized, font: .systemFont(ofSize: 18), textColor: .white,textAlignment: MOLHLanguage.isRTLLanguage() ? .right : .left)
    
    lazy var mainView:UIView = makeMainSubViewWithAppendView(vv: [Image1,label1])
    lazy var main2View:UIView =  {
        let v = makeMainSubViewWithAppendView(vv: [Image2,label2])
        //        v.constrainHeight(constant: 70)
        //        v.constrainHeight(constant: 100)
        return v
    }()
    lazy var main3View:UIView = makeMainSubViewWithAppendView(vv: [Image3,label3])
    lazy var label1 =  makeAttributedText(fir: " Find".localized.localized, sec: "Service".localized)
    lazy var label2 =  makeAttributedText(fir: " Favorite".localized, sec: "Doctors".localized)
    lazy var label3 =  makeAttributedText(fir: " My".localized, sec: "Orders".localized)
    
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
    
    lazy var baseAdsCell:BaseAdsCell = {
        let b = BaseAdsCell()
        b.handleDetails = {[unowned self] in
            self.handleDetails?()
        }
        b.handlePayments = {[unowned self] in
            self.handlePayments?()
        }
        return b
    }()
    
    var handlePayments:(()->Void)?
    var handleDetails:(()->Void)?
    
    var constainedAnchor:AnchoredConstraints!
    var listImageconstainedDateAnchor:AnchoredConstraints!
    var LogoImageconstainedAnchor:AnchoredConstraints!
    var notifyImageconstainedDateAnchor:AnchoredConstraints!
    
    override func setupViews() {
        [titleLabel,docotrLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})

        let sss = getStack(views: drImage,docotrLabel,drInsuranceImage, spacing: 8, distribution: .fill, axis: .horizontal)
        
        let ss = getStack(views: mainView,main2View,main3View, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
        addSubViews(views: LogoImage,listImage,notifyImage,ss,titleLabel,soonLabel,ss,baseAdsCell)
        
        NSLayoutConstraint.activate([
            ss.centerXAnchor.constraint(equalTo: centerXAnchor),
            ss.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 60)
        ])
        if MOLHLanguage.isRTLLanguage() {
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
            main3View.hstack(label3,Image3)
            main2View.hstack(label2,Image2)
            mainView.hstack(label1,Image1)
        }else {
            
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
            main3View.hstack(Image3,label3)
            main2View.hstack(Image2,label2)
            mainView.hstack(Image1,label1)
            
        }
        
        listImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        sss.anchor(top: topAnchor, leading: listImage.trailingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 24, bottom: 0, right: 60))

        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        ss.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 46, bottom: 0, right: 0))
        
        baseAdsCell.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
    }
    
    func makeAttributedText(fir:String,sec:String) -> UILabel {
        let l = UILabel()
        let attrString = NSMutableAttributedString()
        if MOLHLanguage.isRTLLanguage() {
            attrString.appendWith(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), weight: .bold, ofSize: 16, sec+"\n")
            attrString.appendWith(color: #colorLiteral(red: 0.246225208, green: 0.2462718487, blue: 0.2462153137, alpha: 1), weight: .regular, ofSize: 16, fir)
        }else {
            attrString.appendWith(color: #colorLiteral(red: 0.246225208, green: 0.2462718487, blue: 0.2462153137, alpha: 1), weight: .regular, ofSize: 16, fir+"\n")
            attrString.appendWith(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), weight: .bold, ofSize: 16, sec)
        }
        l.attributedText = attrString
        l.numberOfLines = 2
        l.textAlignment = .center
        return l
    }
}


