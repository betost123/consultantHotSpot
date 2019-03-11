//
//  MapViewController.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-12-20.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import CoreLocation
//import GooglePlaces

class MapViewController: UIViewController, CLLocationManagerDelegate {

    var mapView : GMSMapView?
    var events = [Event]()
    let manager = CLLocationManager()
    var lat = 57.706213
    var lng = 11.940451
    //var placesClient : GMSPlacesClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Get position
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        //Navigation bar
        self.navigationItem.title = "HotSpots"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        let listViewButton = UIBarButtonItem(title: "list view", style: .plain, target: self, action: #selector(listViewButtonHandler))
        let addEventButton = UIBarButtonItem(title: "add event", style: .plain, target: self, action: #selector(addEventButtonHandler))
        navigationItem.leftBarButtonItem = listViewButton
        navigationItem.rightBarButtonItem = addEventButton
        
       // placesClient = GMSPlacesClient.shared()
        
        observeEvents()
    }
    
    private func observeEvents() {
        //guard let uid = Auth.auth().currentUser?.uid else {return}
        let eventsRef = Database.database().reference().child("events")
        eventsRef.observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String : AnyObject] else {return}
            let event = Event()
            event.eventHost = dictionary["eventHost"] as? String
            event.eventName = dictionary["eventName"] as? String
            event.longitude = dictionary["latitude"] as? Double
            event.latitude = dictionary["longitude"] as? Double
  
            self.events.append(event)
            
            DispatchQueue.main.async {
                self.setupMap()
            }
        }, withCancel: nil)
    }
    
    //FIXME: If latitude and longitude are nil, the map should open and just be empty
    private func addEventsFromDatabase() {
        // Creates a marker in the center of the map.
        print("counted events for loop : \(events.count)")
        
        for event in events {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: event.latitude ?? 57.706213, longitude: event.longitude ?? 11.940451)
            marker.title = event.eventName
            marker.snippet = event.eventHost
            marker.icon = #imageLiteral(resourceName: "tree1")
            //marker.icon = GMSMarker.markerImage(with: #colorLiteral(red: 0.8801551461, green: 0.6339178681, blue: 0.6032804847, alpha: 1))
            marker.map = mapView
        }

    }
 
    func setupMap() {
        
        // Create a GMSCameraPosition to open the map at specific place
        //let camera = GMSCameraPosition.camera(withLatitude: 57.706213, longitude: 11.940451, zoom: 15.0)
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        //mapView?.settings.myLocationButton = true
        
        //map styling
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView?.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        view = mapView
        
        addEventsFromDatabase()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        lat = location.coordinate.latitude
        lng = location.coordinate.longitude
        
        let userLocationMarker = GMSMarker(position: location.coordinate)
        userLocationMarker.icon = #imageLiteral(resourceName: "emoji1")
        userLocationMarker.map = mapView
        
        print("Latitude: \(lat))")
        print("Longitude: \(lng)")
        
    }
    
    @objc func listViewButtonHandler() {
        print("display map event as a list view")
    }
    @objc func addEventButtonHandler() {
        print("lets add an event!")
        let addEventController = AddEventController()
        navigationController?.pushViewController(addEventController, animated: true)
    }
    
    // Set the status bar style to complement night-mode.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


}
