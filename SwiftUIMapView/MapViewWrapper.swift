//
//  MapViewWrapper.swift
//  SwiftUIMapView
//
//  Created by liang.wang on 21/11/2022.
//

import SwiftUI
import UIKit

struct MapViewWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> MapViewController {
        let vc = MapViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        
    }
    
}

struct MapViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        MapViewWrapper()
    }
}
