//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 2
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  LocationsViewController.swift
//  Date: Apr 3, 2023
//  Version: 1.0
//

import UIKit
import MapKit
import CoreLocation

class LocationsViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!

    fileprivate var locationManager:CLLocationManager = CLLocationManager()
    var storeDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoreDetailViewController") as! StoreDetailViewController
    
    private var currentLocation : CLLocationCoordinate2D?
    private var storeRepository: StoreRepository? = nil
    
    private let BRAND_APPLE = "Apple"
    private let BRAND_GOOGLE = "Google"
    private let BRAND_SAMSUNG = "Samsung"
    
    var stores = [[String : String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        mapView.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()

        mapView.showsUserLocation = true

        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            currentLocation = userLocation
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 20000, longitudinalMeters: 20000)
            mapView.setRegion(viewRegion, animated: true)
        }
        
        storeRepository = StoreRepository(delegate: self)

        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.sendActions(for: UIControl.Event.valueChanged)

    }

    @objc func willEnterForeground() {
        (UIApplication.shared.delegate as? AppDelegate)?.overrideThemeStyle()
    }
    
    // Show the custom pins on the map and make the pins clickable
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationIdentifier") as? MKPinAnnotationView
        if !(annotation is MKUserLocation) {
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationIdentifier")
            } else {
                annotationView?.annotation = annotation
            }

            if let annotation = annotation as? MyPointAnnotation {
                annotationView?.canShowCallout = true
                let btn = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = btn
                annotationView?.pinTintColor = annotation.pinTintColor
            }
        }
        return annotationView
    }

    // Show the bottom sheet when the pin action button is clicked
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //guard let storesAnnotation = view.annotation as? MyPointAnnotation else { return }
        if let storeAnnotation = view.annotation as? MyPointAnnotation {
            storeDetailVC.store.copy(original: storeAnnotation)
            storeDetailVC.parentVC = self
            if let sheet = storeDetailVC.sheetPresentationController {
                if #available(iOS 16.0, *) {
                    sheet.detents = [.custom { context in
                        return context.maximumDetentValue * 0.45
                    },]
                } else {
                    // Fallback on earlier versions
                    sheet.detents = [.medium()]
                }
                sheet.prefersGrabberVisible = true
            }
            self.present(storeDetailVC, animated: true, completion: nil)
        }
    }

    // Handle the segmented button action. Change stores accrodingly
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            storeRepository?.getStoresByBrand(brand: BRAND_APPLE)
        case 1:
            storeRepository?.getStoresByBrand(brand: BRAND_GOOGLE)
        case 2:
            storeRepository?.getStoresByBrand(brand: BRAND_SAMSUNG)
        default:
        break;
        }
    }

    // Put the pins according to the json store coordinates with specific color
    func showStoresAnnotations(stores: [[String: String]], color: UIColor) {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)

        for store in stores {
            if let name = store["name"], let lat = store["lat"], let lng = store["lng"] {
                let pin = MyPointAnnotation(pinTintColor: color, name: name, address: store["address"]!, phone: store["phone"]!, hours: store["hours"]!, website: store["website"]!)
                pin.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lng)!)
                pin.title = name
                mapView.addAnnotation(pin)
            }
        }
    }

    func drawRoute(storeLocation: CLLocationCoordinate2D) {
        print("draw route on the LocationsVC")
        if let startLoc = currentLocation {
            print("start: \(startLoc.latitude) , \(startLoc.longitude)")
            print("end: \(storeLocation.latitude) , \(storeLocation.longitude)")
            let sourcePlacemark = MKPlacemark(coordinate: startLoc, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: storeLocation, addressDictionary: nil)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let directionRequest = MKDirections.Request()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .automobile
            
            // Calculate the direction
            let directions = MKDirections(request: directionRequest)
            directions.calculate {
                (response, error) -> Void in
                
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    return
                }
                let route = response.routes[0]
                self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
    }
    
    @IBAction func HelpButtonDidClicked(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let helpDocVC = storyboard.instantiateViewController(withIdentifier: "HelpDocVC") as! HelpDocViewController
        let htmlPath = Bundle.main.path(forResource: "LocationsHelp", ofType: "html")
        helpDocVC.openURL = URL(fileURLWithPath: htmlPath!)

        if let sheet = helpDocVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        self.present(helpDocVC, animated: true, completion: nil)
    }
    
}

class MyPointAnnotation : MKPointAnnotation {

    var pinTintColor: UIColor
    var name: String
    var address: String
    var phone: String
    var hours: String
    var website: String

    init(pinTintColor: UIColor = UIColor.black,
            name: String = "",
            address: String = "",
            phone: String = "",
            hours: String = "",
            website: String = ""
    ) {
        self.pinTintColor = pinTintColor
        self.name = name
        self.address = address
        self.phone = phone
        self.hours = hours
        self.website = website
    }

    func copy(original: MyPointAnnotation) {
        self.pinTintColor = original.pinTintColor
        self.name = original.name
        self.address = original.address
        self.phone = original.phone
        self.hours = original.hours
        self.website = original.website
    }
    
    
}

extension LocationsViewController: StoreRepositoryDelegate {
    func onStoreReceived(stores: [[String : String]]) {
        self.stores = stores
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            showStoresAnnotations(stores: self.stores, color: UIColor.red)
            break
        case 1:
            showStoresAnnotations(stores: self.stores, color: UIColor.purple)
            break
        case 2:
            showStoresAnnotations(stores: self.stores, color: UIColor.darkGray)
            break
        default:
            break
        }
    }
}
