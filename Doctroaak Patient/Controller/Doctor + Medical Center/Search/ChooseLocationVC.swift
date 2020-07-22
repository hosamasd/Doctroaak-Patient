//
//  ChooseLocationVC.swift
//  Doctroaak Patient
//
//  Created by hosam on 4/5/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import SVProgressHUD
import MapKit
import GoogleMaps

protocol ChooseLocationVCProtocol {
    func getLatAndLong(lat:Double,long:Double)
}
class ChooseLocationVC: CustomBaseViewVC {
    
    
    lazy var customChooseUserLocationView:CustomChooseUserLocationView = {
        let v = CustomChooseUserLocationView()
        
        v.mapView.delegate = self
        
        //        v.mapView.delegate = self
        v.infoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleInfo)))
        v.doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        //        i.
        return v
    }()
    private let locationManager = CLLocationManager()
    var delgate: ChooseLocationVCProtocol?
    var currentLat:Double?
    var currentLong:Double?
    var isGetLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLocation()
        setupViews()
    }
    
    
    
    //MARK:-User methods
    
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    fileprivate func getUserLocation()  {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    
    func setupAnnotaiotn(coordinate:CLLocationCoordinate2D)  {
        let annote = MKPointAnnotation()
        annote.title = "your location".localized
        annote.coordinate = coordinate
        isGetLocation=true
    }
    
    //TODO:-Handle methods
    
    override func setupViews()  {
        view.backgroundColor = .white
        view.addSubview(customChooseUserLocationView)
        customChooseUserLocationView.fillSuperview()
    }
    
    @objc fileprivate func handleInfo()  {
        SVProgressHUD.showInfo(withStatus: "Please press long to pick up location".localized)
    }
    
    @objc fileprivate func handleDismss()  {
        dismiss(animated: true) {[unowned self] in
            self.delgate?.getLatAndLong(lat: self.currentLat ?? 0.0, long: self.currentLong ?? 0.0)
        }
    }
    
    @objc func handleDone()  {
        self.delgate?.getLatAndLong(lat: self.currentLat ?? 0.0, long: self.currentLong ?? 0.0)
        
        navigationController?.popViewController(animated: true)
        
    }
    
}

//MARK:-Extensions
extension ChooseLocationVC : GMSMapViewDelegate {
    
    
    func mapView(mapView: GMSMapView!, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.title = "your location".localized
        marker.map = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        customChooseUserLocationView.mapView.clear()
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 13.0)
        currentLat = coordinate.latitude
        currentLong = coordinate.longitude
        customChooseUserLocationView.mapView.camera = camera
        
        let marker = GMSMarker()
        marker.title = "your location".localized
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.map = customChooseUserLocationView.mapView
    }
}

extension ChooseLocationVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            print("not active")
        }
    }
    
    fileprivate func getYourLocation(_ userLocation: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude,
                                              longitude: userLocation.coordinate.longitude, zoom: 13.0)
        customChooseUserLocationView.mapView.camera = camera
        let marker = GMSMarker()
        marker.title = "your location".localized
        
        marker.position = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        marker.map = customChooseUserLocationView.mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard  let userLocation = locations.last else {return}
        currentLat = userLocation.coordinate.latitude
        currentLong = userLocation.coordinate.longitude
        
        getYourLocation(userLocation)
        
        locationManager.stopUpdatingLocation()
    }
    
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        guard  let userLocation = locations.last else {return}
    //        currentLat = userLocation.coordinate.latitude
    //        currentLong = userLocation.coordinate.longitude
    //
    //        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
    //        customChooseUserLocationView.mapView.setRegion(region, animated: true)
    //        locationManager.stopUpdatingLocation()
    //    }
}



