//
//  OpenLocationUsingLatAndLongView.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/16/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import GoogleMaps

class OpenLocationUsingLatAndLongView: CustomBaseView {
    
    lazy var icuSelectedResultsCell = ICUSelectedResultsCell()
    lazy var mapView:GMSMapView  = {
        let i = GMSMapView()
        i.padding = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        return i
    }()
    
    fileprivate let lat:Double!
    fileprivate let long:Double!
    init(lat:Double,lng:Double) {
        self.lat=lat
        self.long=lng
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        getLocation()
        
    }
    
    override func setupViews() {
        layer.cornerRadius = 8
        clipsToBounds = true
        stack(mapView)
    }
    
    func getLocation()  {
        guard let lat = lat,let lng=long else { return  }
        let coordinate:CLLocationCoordinate2D = .init(latitude: lat, longitude: lng)
        
        let marker = GMSMarker()
        marker.title = "Your Location"
        marker.position = coordinate
        marker.map = mapView
        //        let annotation = MKPointAnnotation()
        //        annotation.coordinate = coordinate
        //        mapView.addAnnotation(annotation)
    }
}
