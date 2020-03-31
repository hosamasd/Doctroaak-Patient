//
//  CustomPharmacyOrderView.swift
//  Doctroaak Patient
//
//  Created by hosam on 3/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class CustomPharmacyOrderView: CustomBaseView {
    
    
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
    lazy var titleLabel = UILabel(text: "Order ", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Order your request", font: .systemFont(ofSize: 18), textColor: .white)

    lazy var orderSegmentedView:UISegmentedControl = {
        let view = UISegmentedControl(items: ["prescription","Request a medicine","All"])
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.apportionsSegmentWidthsByContent = true
        view.layer.borderWidth = 1
        view.layer.backgroundColor = UIColor.lightGray.cgColor
        view.constrainHeight(constant: 50)
        view.selectedSegmentIndex = 0
        view.tintColor = .black
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 20)
        /// Gradient
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(x: 0, y: 0, width:  UIScreen.main.bounds.width - 40, height: 20)
        let leftColor = #colorLiteral(red: 0.6002450585, green: 0.3833707869, blue: 0.9996971488, alpha: 1)
        let rightColor = #colorLiteral(red: 0.4903785586, green: 0.2679489255, blue: 0.9277817607, alpha: 1)
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        /// Create gradient image
        UIGraphicsBeginImageContext(gradient.frame.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let segmentedControlImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Normal Image
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size);
        let context:CGContext = UIGraphicsGetCurrentContext()!;
        context.setFillColor(#colorLiteral(red: 0.9352307916, green: 0.9353840947, blue: 0.9351981282, alpha: 1).cgColor)
        context.fill(rect)
        let normalImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        /// Set segmentedControl image
        view.setBackgroundImage(normalImage, for: .normal, barMetrics: .default)
        view.setBackgroundImage(segmentedControlImage, for: .selected, barMetrics: .default)
//        view.addTarget(self, action: #selector(handleOpenOther), for: .valueChanged)
        return view
    }()
        lazy var centerImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "2454170"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var rosetaImageView:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "G4-G5 Sample Rx"))
         i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var uploadView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        v.layer.borderColor = UIColor.gray.cgColor
        v.layer.borderWidth = 1
        v.addSubViews(views: uploadLabel,uploadImage)
        v.constrainHeight(constant: 60)
        return v
    }()
    lazy var uploadLabel = UILabel(text: "Upload prescription", font: .systemFont(ofSize: 20), textColor: .lightGray,textAlignment: .center)

    lazy var uploadImage:UIImageView = {
       let i = UIImageView(image: #imageLiteral(resourceName: "Group 4174"))
        i.constrainWidth(constant: 80)
        return i
    }()
    
    lazy var customRequestMedicineView:CustomRequestMedicineView = {
       let v = CustomRequestMedicineView()
        
        return v
    }()
    lazy var addMedicineCollectionVC:AddMedicineCollectionVC = {
        let vc = AddMedicineCollectionVC()
        return vc
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
        
//        if nextButton.backgroundColor == nil {
//            addGradientInSenderAndRemoveOther(sender: nextButton)
//            nextButton.setTitleColor(.white, for: .normal)
//        }
    }
    
    
    override func setupViews() {

//        let textStack = getStack(views: addressTextField,uploadView,deliveryView, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
//        uploadView.hstack(uploadImage,uploadLabel).withMargins(.init(top: 0, left: 0, bottom: 0, right: 0))
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,orderSegmentedView,customRequestMedicineView,addMedicineCollectionVC.view,nextButton)//,rosetaImageView,centerImage,uploadView,nextButton)
        
        NSLayoutConstraint.activate([
//            centerImage.centerXAnchor.constraint(equalTo: centerXAnchor),
//            centerImage.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        
    
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        orderSegmentedView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 86, left: 46, bottom: 0, right: 32))

        customRequestMedicineView.anchor(top: orderSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
        addMedicineCollectionVC.view.anchor(top: customRequestMedicineView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
//        centerImage.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 46, bottom: 0, right: 0))
//        uploadView.anchor(top: centerImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 64, left: 46, bottom: 0, right: 32))
//
//        rosetaImageView.anchor(top: orderSegmentedView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
        nextButton.anchor(top: addMedicineCollectionVC.view.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
    }
}

