//
//  Helper.swift
//  SwiftUIMapView
//
//  Created by liang.wang on 21/11/2022.
//

import Foundation
import UIKit
import MapKit

extension UIViewController {
    func makeRandomCoordinates(_ number: Int = 50, in region: MKCoordinateRegion) -> [CLLocationCoordinate2D] {
        let minLat = region.center.latitude - (region.span.latitudeDelta * 2)
        let maxLat = region.center.latitude + (region.span.latitudeDelta * 2)
        
        let minLon = region.center.longitude - (region.span.longitudeDelta)
        let maxLon = region.center.longitude + (region.span.longitudeDelta)
        
        let adjusted: [Int] = [minLat, maxLat, minLon, maxLon].map { Int($0 * 10000) }
        let latDelta = adjusted[1] - adjusted[0]
        let lonDelta = abs(adjusted[3] - adjusted[2])
        
        var coordinates = [CLLocationCoordinate2D]()
        for _ in 0...number {
            let latRand = Int(arc4random_uniform(UInt32(latDelta)))
            let lonRand = Int(arc4random_uniform(UInt32(lonDelta))) * -1
            
            let lat: Double = minLat + (Double(latRand) / 10000.0)
            let lon: Double = minLon - (Double(lonRand) / 10000.0)
            
            coordinates.append(CLLocationCoordinate2D(latitude: lat, longitude: lon))
        }
        
        return coordinates
    }
}
