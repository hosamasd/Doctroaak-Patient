//
//  CustomDoctorListsView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class CustomDoctorListsView: CustomBaseView {
 
    var index:Int! {
        didSet {
            titleLabel.text = index == 0 ? "Doctor" : "Medical Center"
            userSpecificationLabel.text = index == 0 ? "Find the best rated doctors" : "Find the best rated Medical Center"
        }
    }
    
 
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116").withRenderingMode(.alwaysOriginal))
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
    lazy var titleLabel = UILabel(text: "Doctor", font: .systemFont(ofSize: 35), textColor: .white)
    lazy var userSpecificationLabel = UILabel(text: "Find the best rated doctors", font: .systemFont(ofSize: 16), textColor: .white)
    
    lazy var doctorListCollectionVC:DoctorListCollectionVC = {
        let vc = DoctorListCollectionVC()
        vc.handleCheckedIndex = {[unowned self ] id in
            self.handleCheckedIndex?(id)
        }
//        vc.view.isHide(vc.specificationArray.count < 1 ? true : false)
        return vc
    }()
    
    
    var handleCheckedIndex:((Int)->Void)?
    
    override func setupViews() {
        
        addSubViews(views: LogoImage,backImage,titleLabel,userSpecificationLabel,doctorListCollectionVC.view)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        //        notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        userSpecificationLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        
        doctorListCollectionVC.view.anchor(top: userSpecificationLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 128, left: 46, bottom: 16, right: 32))
        
    }
}
