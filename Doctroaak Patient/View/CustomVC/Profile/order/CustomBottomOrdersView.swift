//
//  CustomBottomOrdersView.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class CustomBottomOrdersView: CustomBaseView {
    
    lazy var doctorLabel = createLabels(title: "Doctors\n")
    lazy var pharamacyLabel = createLabels(title: "Pharamacy\n")
    lazy var labLabel = createLabels(title: "Lab\n")
    lazy var radiologyLabel = createLabels(title: "Radiology\n")
    
    lazy var firstView = createViews(v: firstImage, x: doctorLabel)
    lazy var secondView = createViews(v: secondImage, x: pharamacyLabel)
    lazy var thirdView = createViews(v: thirdImage, x: labLabel)
    lazy var forthView = createViews(v: forthImage, x: radiologyLabel)
    
    lazy var firstImage = createImages(img: #imageLiteral(resourceName: "medicine (2)-1"))
    lazy var secondImage = createImages(img: #imageLiteral(resourceName: "medicine (2)-1"))
    lazy var thirdImage = createImages(img: UIImage(named: "Union 1-2") ?? UIImage())
    lazy var forthImage = createImages(img: #imageLiteral(resourceName: "Group 84-1"))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        firstImage.contentMode = .scaleAspectFit
        [labLabel,pharamacyLabel,radiologyLabel].forEach({$0.isHide(true)})
        firstView.backgroundColor = #colorLiteral(red: 0.9275586605, green: 0.8786675334, blue: 1, alpha: 1)
    }
    
    override func setupViews() {

        hstack(firstView,secondView,thirdView,forthView,spacing:0,distribution:.fillEqually)
    }
    
    func createImages(img:UIImage) -> UIImageView {
        let im = UIImageView(image: img)
        im.contentMode = .scaleAspectFit
        im.clipsToBounds = true
//        im.constrainHeight(constant: 10)
        return im
    }
    
    func createLabels(title:String) -> UILabel {
        let la = UILabel(text: title, font: .systemFont(ofSize: 12), textColor: #colorLiteral(red: 0.4747212529, green: 0.2048208416, blue: 1, alpha: 1), textAlignment: .center,numberOfLines: 2)
        
        return la
    }
    
    func createViews(v:UIView,x:UIView) -> UIView {
        let z = UIView(backgroundColor: .lightGray)//#colorLiteral(red: 0.9243445992, green: 0.8774182796, blue: 1, alpha: 1))
        z.isUserInteractionEnabled = true
        z.layer.cornerRadius = 16
        z.clipsToBounds = true
        z.addSubViews(views: v,x)
//        z.stack(v,x,UIView(),spacing:8,alignment:.center).padTop(8)//.padBottom(8)
        z.stack(v,x,spacing:0,alignment:.center)//.padTop(8)//.padBottom(8)

        return z
    }
}
