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
        imageView.constrainHeight(constant: 150)

        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        imageView.constrainHeight(constant: 150)
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let la = UILabel()
//        la.backgroundColor = .red
        la.numberOfLines = 6
        la.sizeToFit()
        return la
    }()
    
    override func setupViews() {
        backgroundColor = .white
        stack(splashImageView,descriptionLabel,UIView(),spacing:16).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
    }
}
