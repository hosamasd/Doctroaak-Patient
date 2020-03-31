//
//  CustomRequestMedicineView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import iOSDropDown

class CustomRequestMedicineView: CustomBaseView {
    
    lazy var mainDropView:UIView = {
        let l = UIView(backgroundColor: .white)
        l.layer.cornerRadius = 8
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
        l.addSubview(nameDrop)
        l.constrainHeight(constant: 60)
        return l
    }()
    lazy var nameDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.optionArray = ["one","two","three"]
        i.arrowSize = 20
        i.placeholder = "Name".localized
        return i
    }()
    lazy var mainDrop2View:UIView = {
        let l = UIView(backgroundColor: .white)
        l.layer.cornerRadius = 8
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
        l.addSubview(typeDrop)
        return l
    }()
    lazy var typeDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.optionArray = ["one","two","three"]
        i.arrowSize = 20
        //        i.arrowColor = .white
        i.placeholder = "Type".localized
        return i
    }()
    lazy var quantityLabel = UILabel(text: "Quantity", font: .systemFont(ofSize: 20), textColor: .black)
    lazy var plusImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4177"))
        i.contentMode = .scaleAspectFill
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var minusImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4176"))
        i.contentMode = .scaleAspectFill
        i.isUserInteractionEnabled = true
        i.constrainWidth(constant: 40)
        return i
    }()
    lazy var counterLabel = UILabel(text: "0", font: .systemFont(ofSize: 20), textColor: .black,textAlignment: .center)
    lazy var addMoreImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4178"))
//        i.contentMode = .scaleAspectFill
        i.isUserInteractionEnabled = true
        i.constrainWidth(constant: 60)
        return i
    }()
  

    override func setupViews() {
        let ss = getStack(views: minusImage,counterLabel,plusImage, spacing: 8, distribution: .fillEqually, axis: .horizontal)
        let s = getStack(views: quantityLabel,ss, spacing: 16, distribution: .fillProportionally, axis: .horizontal)
        let dd = getStack(views: UIView(),addMoreImage, spacing: 16, distribution: .fill, axis: .horizontal)
//
//        let mainStack = getStack(views: mainDropView,mainDrop2View,s,dd, spacing: 16, distribution: .fillProportionally, axis: .vertical)
        mainDropView.hstack(nameDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
        mainDrop2View.hstack(typeDrop).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))

//        addSubViews(views: .view)
        stack(mainDropView,mainDrop2View,s,dd, spacing: 16, distribution: .fillEqually)
//        mainStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
//        addMedicineCollectionVC.view.anchor(top: mainStack.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)

//        addMedicineCollectionVC.view.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
