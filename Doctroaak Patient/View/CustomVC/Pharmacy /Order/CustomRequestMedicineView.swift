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
        let i = returnMainDropDown(bg: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1), plcae: "Name")

        return i
    }()
    lazy var mainDrop2View = makeMainSubViewWithAppendView(vv: [typeDrop])
    lazy var typeDrop:DropDown = {
                let i = returnMainDropDown(bg: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1), plcae: "Type")

        return i
    }()
    lazy var quantityLabel = UILabel(text: "Quantity".localized, font: .systemFont(ofSize: 20), textColor: .black)
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
    }
}
