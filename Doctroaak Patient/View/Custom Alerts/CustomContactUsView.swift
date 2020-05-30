//
//  CustomContactUsView.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class CustomContactUsView: CustomBaseView {
    
    lazy var titleLabel = UILabel(text: "Contacts Us", font: .systemFont(ofSize: 20), textColor: .black, textAlignment: .center)
    lazy var whatsappButton = createImageForContacts(img: #imageLiteral(resourceName: "whatsapp(1)"), tags: 3)
    lazy var phoneButton = createImageForContacts(img: #imageLiteral(resourceName: "telephone"), tags: 2)
    lazy var websiteButton = createImageForContacts(img: #imageLiteral(resourceName: "worldwide"), tags: 0)
    lazy var facebookButton = createImageForContacts(img: #imageLiteral(resourceName: "facebook"), tags: 1)

    var handleChoosedOption:((Int)->Void)?
    
    
    
    override func setupViews() {
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = .lightGray
        let ss = getStack(views: whatsappButton,phoneButton,websiteButton,facebookButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        stack(titleLabel,ss,spacing:16).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    func createImageForContacts(img:UIImage,tags:Int) -> UIButton {
        let im  = UIButton()
        im.setImage(img, for: .normal)
        im.imageView?.contentMode = .scaleAspectFit
        im.imageView?.clipsToBounds=true
        im.tag = tags
        im.constrainHeight(constant: 60)
        im.addTarget(self, action: #selector(handleOpens), for: .touchUpInside)
        return im
    }
    
   @objc func handleOpens(sender:UIButton)  {

    handleChoosedOption?(sender.tag)
    }
}
