//
//  MapItem.swift
//  SwiftUIMapView
//
//  Created by liang.wang on 21/11/2022.
//

import Foundation
import MapKit


final class MapItem: NSObject, MKAnnotation {
    enum ItemType: UInt32 {
        case green = 0
        case orange = 1
        
        var image: UIImage {
            switch self {
            case .green:
                return #imageLiteral(resourceName: "annotation")
            case .orange:
                return #imageLiteral(resourceName: "annotation_orange")
            }
        }
    }
    
    let coordinate: CLLocationCoordinate2D
    let itemType: ItemType
    var image: UIImage { return itemType.image }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.itemType = ItemType(rawValue: arc4random_uniform(2)) ?? .green
    }
}


final class MapItemAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        didSet {
            guard let mapItem = annotation as? MapItem else { return }
            
            clusteringIdentifier = "MapItem"
            image = mapItem.image
        }
    }
}


