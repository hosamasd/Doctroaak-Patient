//
//  CustomMainHomeLeftView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit


class CustomMainHomeLeftView: CustomBaseView {
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142-5"))
        i.contentMode = .scaleAspectFill
        i.constrainHeight(constant: 120)
        return i
    }()
    lazy var userImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "humberto-chavez-FVh_yqLR9eA-unsplash"))
        //         i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 60)
        i.constrainHeight(constant: 60)
        return i
    }()
    lazy var userNameLabel = UILabel(text: "Bian Mohamed", font: .systemFont(ofSize: 30), textColor: .white)
//    lazy var userSpecificationLabel = UILabel(text: "Cardiologist", font: .systemFont(ofSize: 16), textColor: .lightGray)
    
    lazy var homeLeftMenuCollectionVC:HomeLeftMenuCollcetionVC  =  {
        let vc = HomeLeftMenuCollcetionVC()
        vc.handleCheckedIndex = {[unowned self ] index in
            self.handleCheckedIndex?(index)
        }
        return vc
    }()
    lazy var Image8:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "icon2"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        return i
    }()
    lazy var Label8 = UILabel(text: "Log Out", font: .systemFont(ofSize: 24), textColor: #colorLiteral(red: 0.6841606498, green: 0.6842750907, blue: 0.6841363311, alpha: 1))
    lazy var first8Stack:UIStackView = {
        let s = getStack(views: Image8,Label8, spacing: 16, alignment: .center, distribution: .fill, axis: .horizontal)
        s.constrainHeight(constant: 60)
        return s
    }()
    
    var handleCheckedIndex:((IndexPath)->Void)?
    
    
    override func setupViews() {
         addSubViews(views: LogoImage,userImage,userNameLabel,homeLeftMenuCollectionVC.view,first8Stack)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        userImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 40, left: 24, bottom: 0, right: 0))
        userNameLabel.anchor(top: userImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 46, bottom: 0, right: 0))
        
        homeLeftMenuCollectionVC.view.anchor(top: userNameLabel.bottomAnchor, leading: leadingAnchor, bottom: first8Stack.topAnchor, trailing: trailingAnchor,padding: .init(top: 60, left: 46, bottom: 16, right: 0))
        first8Stack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: 8, right: 0))
        
    }
}
