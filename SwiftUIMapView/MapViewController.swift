

import UIKit
import MapKit

// https://medium.com/@worthbak/clustering-with-mapkit-on-ios-11-part-2-2418a865543b

class MapViewController: UIViewController {
  private let mapView: MKMapView = MKMapView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.mapView.frame = self.view.bounds
    self.view.addSubview(self.mapView)
    
  let centerCoordinate = CLLocationCoordinate2D(latitude: -32.256943, longitude: 148.601105)
      let region = MKCoordinateRegion(
            center: centerCoordinate,
            latitudinalMeters: 50000,
            longitudinalMeters: 60000)
  mapView.setRegion(region, animated: true)
  
  
    mapView.setCameraBoundary(
      MKMapView.CameraBoundary(coordinateRegion: region),
      animated: true)
    
    let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
    mapView.setCameraZoomRange(zoomRange, animated: true)
    
    mapView.delegate = self
    
    mapView.register(
//      ArtworkView.self,
        MapItemAnnotationView.self,
      forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
      
      mapView.register(
          ClusterAnnotationView.self,
          forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)

    
      for randCoordinate in makeRandomCoordinates(in: region) {
          let annotation = MapItem(coordinate: randCoordinate)
          mapView.addAnnotation(annotation)
      }
  }
}

private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("calloutAccessoryControlTapped clicked")
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("didSelect")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MKAnnotationViewClicked"), object: nil, userInfo: nil)
    }
}
