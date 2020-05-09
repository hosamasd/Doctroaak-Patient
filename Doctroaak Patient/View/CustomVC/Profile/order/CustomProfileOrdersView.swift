//
//  CustomProfileOrdersView.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class CustomProfileOrdersView: CustomBaseView {
    
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var titleLabel = UILabel(text: "Cardiology", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Get well soon!", font: .systemFont(ofSize: 18), textColor: .white)
    lazy var mainSecondView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
//    lazy var mainBottomView:UIView = {
//        let v = UIView(backgroundColor: .green)
//        v.backgroundColor = .red
//        v.layer.cornerRadius = 8
//        v.clipsToBounds = true
//        v.addSubview(customBottomOrdersView)
//        return v
//    }()
//    lazy var customBottomOrdersView = CustomBottomOrdersView()
    var handleCheckedIndex:((IndexPath)->Void)?
    
    lazy var profileCollectionVC:ProfileOrderCollectionVC = {
        let vc = ProfileOrderCollectionVC()
        vc.handleCheckedIndex = {[unowned self] indexPath in
            self.handleCheckedIndex?(indexPath)
        }
        return vc
    }()
    override func setupViews() {
        backgroundColor = .white
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,profileCollectionVC.view)
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        profileCollectionVC.view.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 64, left: 32, bottom: 0, right: 32))
//        customBottomOrdersView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 32, bottom: 60, right: 32))
    }
}

