//
//  DoctorHomeListCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class DoctorHomeListCell: BaseCollectionCell {
    
    lazy var mainView:UIView = {
       let v = UIView(backgroundColor: #colorLiteral(red: 0.7638213038, green: 0.6642241478, blue: 0.9906757474, alpha: 1))
        v.constrainHeight(constant: 100)
        v.addSubview(docImage)
        return v
    }()
    lazy var docImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "chest"))
        i.constrainWidth(constant: 60)
        i.constrainHeight(constant: 60)
        return i
    }()
    lazy var docLabel = UILabel(text: "Cardiology", font: .systemFont(ofSize: 24), textColor: .black,textAlignment: .center)
    
    
    
    fileprivate func setupBorder() {
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setupViews() {
        setupBorder()
    
    stack(mainView,docLabel)
    docImage.centerInSuperview()
    }
    
}
