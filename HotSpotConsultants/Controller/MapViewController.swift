//
//  MapViewController.swift
//  HotSpotConsultants
//
//  Created by Betina Andersson on 2018-12-20.
//  Copyright © 2018 Betina Andersson. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    var mapView : GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation bar
        self.navigationItem.title = "HotSpots"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1086953059, green: 0.2194250822, blue: 0.3138863146, alpha: 1)
        let listViewButton = UIBarButtonItem(title: "list view", style: .plain, target: self, action: #selector(listViewButtonHandler))
        let addEventButton = UIBarButtonItem(title: "add event", style: .plain, target: self, action: #selector(addEventButtonHandler))
        navigationItem.leftBarButtonItem = listViewButton
        navigationItem.rightBarButtonItem = addEventButton
        
        setupMap()
    }
 
    func setupMap() {
        // Create a GMSCameraPosition that tells the map to display the
        //57.706213, 11.940451
        let camera = GMSCameraPosition.camera(withLatitude: 57.706213, longitude: 11.940451, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
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
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 57.706213, longitude: 11.940451)
        marker.title = "FredagsHackaton!"
        marker.snippet = "Sigma Technologies"
        marker.icon = GMSMarker.markerImage(with: .black)
        //marker.tracksInfoWindowChanges = true //set to true for info window to update automatically
        marker.map = mapView
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
