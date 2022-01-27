//
//  GeotificationsViewController.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 26/01/2022.
//

import UIKit
import MapKit

final class GeotificationsViewController: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!
    private lazy var locationManager: LocationManagerProtocol = LocationManager()
    private let notationIdentifier = "notationIdentifier"
    private let titleString = "Wifi connect: "

    override func viewDidLoad() {
        super.viewDidLoad()
        initHandling()
        loadAllGeotifications()
        title = titleString + "OFF"
    }

    private func initHandling() {
        mapView.delegate = self
        locationManager.requestAuthorization { [unowned self] status in
            print(status)
            if status == .always {
                self.mapView.showsUserLocation = true
                self.mapView.zoomToLocation(self.mapView.userLocation.location)
            }
        }
    }
    
    private func loadAllGeotifications() {
        let geoAreaUI = GeoAreaUI(wifiName: "Khoa Nguyen",
                                  radius: 1000,
                                  coordinate: CLLocationCoordinate2D(latitude: 10.762622, longitude: 106.660172),
                                  identifier: "1234567")
        mapView.addAnnotation(geoAreaUI)
        addRadiusOverlay(forGeotification: geoAreaUI)
        
    }

    private func addRadiusOverlay(forGeotification geotification: GeoAreaUI) {
      mapView.addOverlay(MKCircle(center: geotification.coordinate,
                                  radius: geotification.radius))
    }
    
    // MARK: Other mapview functions
    @IBAction func zoomToCurrentLocation(sender: AnyObject) {
        mapView.zoomToLocation(mapView.userLocation.location)
    }

}

// MARK: - MapView Delegate
extension GeotificationsViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if annotation is GeoAreaUI {
      var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: notationIdentifier) as? MKPinAnnotationView
      if annotationView == nil {
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: notationIdentifier)
        annotationView?.canShowCallout = true
        let removeButton = UIButton(type: .custom)
        removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
        removeButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        annotationView?.leftCalloutAccessoryView = removeButton
      } else {
        annotationView?.annotation = annotation
      }
      return annotationView
    }
    return nil
  }

  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    if overlay is MKCircle {
      let circleRenderer = MKCircleRenderer(overlay: overlay)
      circleRenderer.lineWidth = 1.0
      circleRenderer.strokeColor = .purple
      circleRenderer.fillColor = UIColor.purple.withAlphaComponent(0.4)
      return circleRenderer
    }
    return MKOverlayRenderer(overlay: overlay)
  }

  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    // Delete geotification
//    guard let geotification = view.annotation as? Geotification else { return }
//    stopMonitoring(geotification: geotification)
//    remove(geotification)
//    saveAllGeotifications()
  }
}
