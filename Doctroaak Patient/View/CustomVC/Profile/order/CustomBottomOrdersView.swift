//
//  CustomBottomOrdersView.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class CustomBottomOrdersView: CustomBaseView {
    
    lazy var doctorLabel = UILabel(text: "doctor", font: .systemFont(ofSize: 16), textColor: .black)
    lazy var doctorImage = createImages(img: UIImage(named: "doctor (2)-1" ) ?? UIImage())
    lazy var firstView = createViews(v: firstImage)
    lazy var secondView = createViews(v: secondImage)
    lazy var thirdView = createViews(v: thirdImage)
    lazy var forthView = createViews(v: forthImage)

    lazy var firstImage = createImages(img: #imageLiteral(resourceName: "medicine (2)-1"))
    lazy var secondImage = createImages(img: #imageLiteral(resourceName: "medicine (2)-1"))
    lazy var thirdImage = createImages(img: UIImage(named: "Union 1-1") ?? UIImage())
    lazy var forthImage = createImages(img: #imageLiteral(resourceName: "Group 84-1"))

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func setupViews() {
        let first = hstack(doctorImage,doctorLabel, spacing: 8)
        
        hstack(first,secondView,thirdView,forthView,spacing:8,distribution:.fillEqually)
        [firstImage,secondImage,thirdImage,forthImage].forEach({$0.centerInSuperview()})
    }
    
    func createImages(img:UIImage) -> UIImageView {
        let im = UIImageView(image: img)
        im.contentMode = .scaleAspectFill
//        im.constrainWidth(constant: 20)
        im.isUserInteractionEnabled = true
        return im
    }
    
    func createViews(v:UIView) -> UIView {
        let z = UIView(backgroundColor: #colorLiteral(red: 0.9243445992, green: 0.8774182796, blue: 1, alpha: 1))
        
        z.layer.cornerRadius = 24
        z.clipsToBounds = true
        z.addSubview(v)
        return z
    }
}
