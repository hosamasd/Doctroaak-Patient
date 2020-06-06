//
//  CustomAddMinusView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class CustomAddMinusView: CustomBaseView {
    
    
    var count:Int = 1
    
    
    lazy var plusImageView:UIImageView = {
        let im = UIImageView(image: #imageLiteral(resourceName: "Group 4174-2"))
        im.isUserInteractionEnabled = true
        im.contentMode = .scaleAspectFill
        im.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddOne)))
        im.clipsToBounds = true
         im.constrainWidth(constant: 40)
        return im
    }()
    lazy var numberOfItemsLabel = UILabel(text: "\(count)", font: .systemFont(ofSize: 16), textColor: .black,textAlignment: .center)
    lazy var minusImageView:UIImageView = {
        let im = UIImageView(image: #imageLiteral(resourceName: "Group 4175"))
        im.isUserInteractionEnabled = true
        im.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMinusOne)))
        im.clipsToBounds = true
        return im
    }()
    
    var handleAddClousre:((Int)->Void)?
    var handleMinusClousre:((Int)->Void)?
    
  

    
    func hideViewWithAnimation(view:UIView)  {
        
        numberOfItemsLabel.text = "\(count)"
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            view.isHide(true)
        })
    }
    
    
    
    override func setupViews()  {
        
        hstack(minusImageView,numberOfItemsLabel,plusImageView,distribution:.fillEqually).withMargins( .init(top: 0, left: 16, bottom: 0, right: 0))
//        numberOfItemsLabel.centerInSuperview()
    }
    
    @objc func handleAddOne()  {
        count += 1
        numberOfItemsLabel.text = "\(count)"
        handleAddClousre?(count)
    }
    
    @objc func handleMinusOne()  {
        count = max( 0,count-1)
        numberOfItemsLabel.text = "\(count)"
        handleMinusClousre?(count)
    }
}

