//
//  DoctorWorkingDateCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
class DoctorWorkingDateCell: BaseCollectionCell {
    
    lazy var logoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Rectangle 1751"))
        i.constrainWidth(constant: 6)
        return i
    }()
    lazy var doctorDayLabel = UILabel(text: "Sunday", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var doctorFirstTimeLabel = UILabel(text: "11:30 am    ", font: .systemFont(ofSize: 16), textColor: .blue)
    lazy var doctorDayLastTimeLabel = UILabel(text: "11:30 pm    ", font: .systemFont(ofSize: 16), textColor: .blue)
    lazy var seperatorView:UIView = {
        let v = UIView(backgroundColor: .lightGray)
        v.constrainHeight(constant: 1)
        return v
    }()
    
    override func setupViews() {
        hstack(logoImage,doctorDayLabel,doctorFirstTimeLabel,doctorDayLastTimeLabel,spacing:16).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
        
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
