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
    var artworks = [Artwork]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // set initial location in honolulu
        let initLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initLocation)

        loadInitialData()
        mapView.addAnnotations(artworks)

        // show artwork on map
//        let artwork = Artwork(title: "King David Kalakaua",
//                locationName: "Waikiki Gateway Park",
//                discipline: "Sculpture",
//                coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
//
//        mapView.addAnnotation(artwork)
        mapView.delegate = self
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func loadInitialData() {
        // 1
        let fileName = NSBundle.mainBundle().pathForResource("PublicArt", ofType: "json");
        var data : NSData
        do {
            data = try NSData(contentsOfFile: fileName!, options: NSDataReadingOptions(rawValue: 0))
            
            
            // 2
            do {
                let jsonObject: AnyObject! = try NSJSONSerialization.JSONObjectWithData(data,
                    options: NSJSONReadingOptions(rawValue: 0))
                
                // 3
                if let jsonObject = jsonObject as? [String: AnyObject],
                    // 4
                    let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
                        for artworkJSON in jsonData {
                            if let artworkJSON = artworkJSON.array,
                                // 5
                                artwork = Artwork.fromJSON(artworkJSON) {
                                    artworks.append(artwork)
                            }
                        }
                }
            } catch {
                print("json error")
            }
        } catch {
            // report error
            print("read data error")
        }
    }
}

