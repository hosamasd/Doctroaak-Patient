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
    lazy var doctorFirstTimeLabel = UILabel(text: "11:30 am    ", font: .systemFont(ofSize: 16), textColor: #colorLiteral(red: 0.5594891906, green: 0.8141058087, blue: 0.8912931085, alpha: 1))
    lazy var doctorDayLastTimeLabel = UILabel(text: "11:30 pm    ", font: .systemFont(ofSize: 16), textColor: #colorLiteral(red: 0.8214932084, green: 0.1086590812, blue: 0.01575340517, alpha: 1))
    lazy var doctorSecondTimeLabel = UILabel(text: "11:30 am    ", font: .systemFont(ofSize: 16), textColor: #colorLiteral(red: 0.5594891906, green: 0.8141058087, blue: 0.8912931085, alpha: 1))
    lazy var doctorDaySecondLastTimeLabel = UILabel(text: "11:30 pm    ", font: .systemFont(ofSize: 16), textColor: #colorLiteral(red: 0.8214932084, green: 0.1086590812, blue: 0.01575340517, alpha: 1))
    lazy var seperatorView:UIView = {
        let v = UIView(backgroundColor: .lightGray)
        v.constrainHeight(constant: 1)
        return v
    }()
    
    override func setupViews() {
        let s = hstack(doctorFirstTimeLabel,doctorDayLastTimeLabel,spacing:8)
        let ss = hstack(doctorSecondTimeLabel,doctorDaySecondLastTimeLabel,spacing:8)

        let dd = stack(s,ss)
        
        
        hstack(logoImage,doctorDayLabel,dd,spacing:16).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))

//        hstack(logoImage,doctorDayLabel,doctorFirstTimeLabel,doctorDayLastTimeLabel,spacing:16).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
        
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
