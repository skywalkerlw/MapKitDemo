//
//  ViewController.swift
//  HonoluluArt
//
//  Created by Yao Li on 12/6/15.
//  Copyright © 2015 clouds. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // set initial location in honolulu
        let initLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initLocation)

        // show artwork on map
        let artwork = Artwork(title: "King David Kalakaua",
                locationName: "Waikiki Gateway Park",
                discipline: "Sculpture",
                coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))

        mapView.addAnnotation(artwork)
        mapView.delegate = self
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

