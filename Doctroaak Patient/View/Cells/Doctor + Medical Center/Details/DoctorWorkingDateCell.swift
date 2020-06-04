//
//  DoctorWorkingDateCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit
import SDWebImage
import MOLH

class DoctorWorkingDateCell: BaseCollectionCell {
    
    var day:WorkingHourModel! {
        didSet{
            guard let day = day else { return  }
            if  day.active == 1 {
                doctorDayLabel.text = getDayFromIndex(day.day)
                doctorFirstTimeLabel.text = changeTimeForButtonTitle(values: day.part1From)
                doctorDayLastTimeLabel.text = changeTimeForButtonTitle(values: day.part1To)
                
                doctorSecondTimeLabel.text = changeTimeForButtonTitle(values: day.part2From)
                doctorDaySecondLastTimeLabel.text = changeTimeForButtonTitle(values: day.part2To)
            }else {}
        }
    }
    
    var lab:LabWorkingHourModel! {
        didSet{
            guard let lab = lab else { return  }

            if  lab.active == 1 {
                doctorDayLabel.text = getDayFromIndex(lab.day)
                doctorFirstTimeLabel.text = changeTimeForButtonTitle(values: lab.partFrom)
                doctorDayLastTimeLabel.text = changeTimeForButtonTitle(values: lab.partTo)
                
//                doctorSecondTimeLabel.text = changeTimeForButtonTitle(values: lab.part2From)
//                doctorDaySecondLastTimeLabel.text = changeTimeForButtonTitle(values: lab.part2To)
            }else {}
        }
    }
    
    var rad:RadiologyWorkingHourModel! {
        didSet{
            guard let rad = rad else { return  }

            if  rad.active == 1 {
                doctorDayLabel.text = getDayFromIndex(rad.day)
                doctorFirstTimeLabel.text = changeTimeForButtonTitle(values: rad.partFrom)
                doctorDayLastTimeLabel.text = changeTimeForButtonTitle(values: rad.partTo)
                
//                doctorSecondTimeLabel.text = changeTimeForButtonTitle(values: rad.part2From)
//                doctorDaySecondLastTimeLabel.text = changeTimeForButtonTitle(values: rad.part2To)
            }else {}
        }
    }
    
    lazy var logoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Rectangle 1751"))
        i.constrainWidth(constant: 6)
        return i
    }()
    lazy var doctorDayLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var doctorFirstTimeLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: #colorLiteral(red: 0.5594891906, green: 0.8141058087, blue: 0.8912931085, alpha: 1))
    lazy var doctorDayLastTimeLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: #colorLiteral(red: 0.8214932084, green: 0.1086590812, blue: 0.01575340517, alpha: 1))
    lazy var doctorSecondTimeLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: #colorLiteral(red: 0.5594891906, green: 0.8141058087, blue: 0.8912931085, alpha: 1))
    lazy var doctorDaySecondLastTimeLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: #colorLiteral(red: 0.8214932084, green: 0.1086590812, blue: 0.01575340517, alpha: 1))
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
    
    func getDayFromIndex (_ index:Int) ->String {
        return index == 1 ? "Saturday".localized : index == 2 ? "Sunday".localized : index == 3 ? "Monday".localized  : index == 4 ? "Tuesday".localized : index == 5 ? "Wednsday".localized : index == 6 ? "Thursday".localized : "Friday".localized
    }
    
    func changeTimeForButtonTitle(values:String)->String  {
        var ppp = "am"
        guard var hours = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
        ppp = hours > 12 ? "pm" : "am"
        hours =   hours > 12 ? hours - 12 : hours
        guard let hou = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: false) else {return "\(hours): 00 \(ppp)"}
        
        guard let minute = hou.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
        
        return "\(hours):\(minute) \(ppp)"
        
    }
}
