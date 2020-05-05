//
//  BeforePaymentCell.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class BeforePaymentCell: BaseCollectionCell {
    
    
    var page:BeforPaymwentModel!{
        didSet {
            splashImageView.image = page.image
            descriptionLabel.text = page.name
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
        la.numberOfLines = 0
        return la
    }()
    
    override func setupViews() {
        backgroundColor = .white
        
//        addSubViews(views: splashImageView,descriptionLabel)
        
        stack(splashImageView,descriptionLabel,UIView(),spacing:16)
    }
}
