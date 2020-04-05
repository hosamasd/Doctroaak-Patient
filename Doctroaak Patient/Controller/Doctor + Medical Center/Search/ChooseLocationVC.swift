//
//  ChooseLocationVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MapKit

protocol ChooseLocationVCProtocol {
    func getLatAndLong(lat:Double,long:Double)
}
class ChooseLocationVC: CustomBaseViewVC {
    
    
 lazy var customChooseUserLocationView:CustomChooseUserLocationView = {
        let v = CustomChooseUserLocationView()
    
        v.mapView.delegate = self
        v.infoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleInfo)))
        v.doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        //        i.
        return v
    }()
    private let locationManager = CLLocationManager()
    var delgate: ChooseLocationVCProtocol?
    var currentLat:Double?
    var currentLong:Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        let lpgr = UILongPressGestureRecognizer(target: self,
                             action:#selector(self.handleLongPress))
        lpgr.minimumPressDuration = 1
        lpgr.delaysTouchesBegan = true
//        lpgr.delegate = self
        customChooseUserLocationView.mapView.addGestureRecognizer(lpgr)
        getUserLocation()
        setupViews()
    }

    //MARK:-User methods



    fileprivate func getUserLocation()  {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

    }

    //TODO:-Handle methods

      override func setupViews()  {
        view.backgroundColor = .white
        view.addSubview(customChooseUserLocationView)
        customChooseUserLocationView.fillSuperview()
    }

    @objc fileprivate func handleInfo()  {
//        SVProgressHUD.showInfo(withStatus: "Please press long to pick up location".localized)
    }

    @objc fileprivate func handleDismss()  {
        dismiss(animated: true) {[unowned self] in
            self.delgate?.getLatAndLong(lat: self.currentLat ?? 0.0, long: self.currentLong ?? 0.0)
        }
    }

    @objc func handleDone()  {

            self.delgate?.getLatAndLong(lat: self.currentLat ?? 0.0, long: self.currentLong ?? 0.0)

    }

}

//MARK:-Extensions

extension ChooseLocationVC:MKMapViewDelegate  {

    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
//
//        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 13.0)
//               currentLat = coordinate.latitude
//               currentLong = coordinate.longitude
//               customChooseUserLocationView.mapView.camera = camera
//
//               let marker = GMSMarker()
//               marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
//               marker.map = customChooseUserLocationView.mapView
        
    }
    
}

extension ChooseLocationVC: CLLocationManagerDelegate{



    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        currentLat = userLocation?.coordinate.latitude
        currentLong = userLocation?.coordinate.longitude

//        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
//                                              longitude: userLocation!.coordinate.longitude, zoom: 13.0)
//        customChooseUserLocationView.mapView.camera = camera
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
//        marker.map = customChooseUserLocationView.mapView

        locationManager.stopUpdatingLocation()
    }
}

