//
//  BeforePaymentCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class BeforePaymentCell: BaseCollectionCell {
    
    
    var page:String?{
        didSet {
//            splashImageView.image = page.image
            guard let page = page else { return  }
            descriptionLabel.text = page
    }
    }
    
    
     lazy var splashImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.constrainHeight(constant: 150)
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let la = UILabel()
//        la.backgroundColor = .red
        la.numberOfLines = 4
        la.sizeToFit()
        return la
    }()
    
    override func setupViews() {
        backgroundColor = .white
        
//        addSubViews(views: splashImageView,descriptionLabel)
        
        stack(splashImageView,descriptionLabel,UIView(),spacing:16)
    }
}
