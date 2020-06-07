//
//  CustomRequestMedicineView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import iOSDropDown
import MOLH

class CustomRequestMedicineView: CustomBaseView {
    
    lazy var mainDropView = makeMainSubViewWithAppendView(vv: [nameDrop])
    lazy var nameDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left
        i.arrowSize = 20
        i.placeholder = "Name".localized
        return i
    }()
    lazy var mainDrop2View = makeMainSubViewWithAppendView(vv: [typeDrop])
    lazy var typeDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left
        i.arrowSize = 20
        //        i.arrowColor = .white
        i.placeholder = "Type".localized
        return i
    }()
    lazy var quantityLabel = UILabel(text: "Quantity", font: .systemFont(ofSize: 20), textColor: .black)
    lazy var customAddMinusView = CustomAddMinusView()
    lazy var addMoreImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4178"))
        i.isUserInteractionEnabled = true
        i.constrainWidth(constant: 60)
        return i
    }()
  

    override func setupViews() {
//        let ss = getStack(views: minusImage,counterLabel,plusImage, spacing: 8, distribution: .fillEqually, axis: .horizontal)
        let s = getStack(views: quantityLabel,UIView(),customAddMinusView, spacing: 16, distribution: .fillProportionally, axis: .horizontal)
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
