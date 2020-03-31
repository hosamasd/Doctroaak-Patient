//
//  CustomPharmacyLocationView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/30/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class CustomPharmacyLocationView: CustomBaseView {
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var titleLabel = UILabel(text: "Pharmacy ", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Select Your Location", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var addressTextField:UITextField = {
        let s = createMainTextFields(place: "Address", type: .default,secre: true)
        let img = UIImageView(image: #imageLiteral(resourceName: "Group 4174"))
        img.isUserInteractionEnabled = true
//        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLocation)))
        img.frame = CGRect(x: CGFloat(s.frame.size.width - 60), y: CGFloat(5), width: CGFloat(60), height: CGFloat(60))
        s.rightView = img
        s.rightViewMode = .always
        return s
    }()
    lazy var delvierySwitch:UISwitch = {
        let s = UISwitch()
        s.onTintColor = #colorLiteral(red: 0.3896943331, green: 0, blue: 0.8117204905, alpha: 1)
        s.isOn = true
        return s
    }()
    lazy var deliveryView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        v.layer.borderColor = UIColor.gray.cgColor
        v.layer.borderWidth = 1
        v.addSubViews(views: delvierySwitch,deliveryLabel)
        v.constrainHeight(constant: 60)
        return v
    }()
    lazy var deliveryLabel = UILabel(text: "Delivery", font: .systemFont(ofSize: 20), textColor: .lightGray)
    lazy var insuracneView:UIView = {
       let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        v.layer.borderColor = UIColor.gray.cgColor
        v.layer.borderWidth = 1
        v.addSubViews(views: insuranceSwitch,insuranceLabel)
        return v
    }()
    lazy var insuranceLabel = UILabel(text: "Insurance company", font: .systemFont(ofSize: 20), textColor: .lightGray)
    lazy var insuranceSwitch:UISwitch = {
        let s = UISwitch()
        s.onTintColor = #colorLiteral(red: 0.3896943331, green: 0, blue: 0.8117204905, alpha: 1)
        s.isOn = true
        return s
    }()
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if nextButton.backgroundColor == nil {
            addGradientInSenderAndRemoveOther(sender: nextButton)
            nextButton.setTitleColor(.white, for: .normal)
        }
        
    }
    
    override func setupViews() {
        let textStack = getStack(views: addressTextField,insuracneView,deliveryView, spacing: 16, distribution: .fillEqually, axis: .vertical)

        insuracneView.hstack(insuranceLabel,insuranceSwitch).withMargins(.init(top: 16, left: 16, bottom: 8, right: 16))
        deliveryView.hstack(deliveryLabel,delvierySwitch).withMargins(.init(top: 16, left: 16, bottom: 8, right: 16))
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,textStack,nextButton)
        
        NSLayoutConstraint.activate([
            textStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            textStack.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        textStack.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 46, bottom: 0, right: 0))
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
    }
}
