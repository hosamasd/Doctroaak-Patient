//
//  CustomChooseUserLocationView.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CustomChooseUserLocationView: CustomBaseView {
    
    
 lazy var infoImageView:UIImageView = {
    let i = UIImageView(image: #imageLiteral(resourceName: "Group 3928-1").withRenderingMode(.alwaysOriginal))
    i.constrainWidth(constant: 40)
    i.constrainHeight(constant: 40)
    i.contentMode = .scaleToFill
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var mapView:MKMapView  = {
        let i = MKMapView()
        i.showsUserLocation = true
//        i.padding = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        return i
    }()
    lazy var doneButton:UIButton = {
        let b = UIButton()
        b.setTitle("Done".localized, for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .black
        b.backgroundColor = ColorConstants.disabledButtonsGray
        b.constrainHeight(constant: 50)
        b.layer.cornerRadius = 16
        b.clipsToBounds = true
        return b
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if doneButton.backgroundColor != nil {
            addGradientInSenderAndRemoveOther(sender: doneButton)
            doneButton.setTitleColor(.white, for: .normal)
        }
    }
    
    override func setupViews() {
        backgroundColor = .white
        
        addSubViews(views: mapView,infoImageView,doneButton)
        mapView.fillSuperview()
        
        infoImageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        doneButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 16, bottom: 32, right: 16))
    }
}

