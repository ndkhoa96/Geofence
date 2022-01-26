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
    private let locationManager: LocationManagerProtocol = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    private func initHandling() {
        locationManager.requestAuthorization { status in
            print(status)
            self.mapView.showsUserLocation = (status == .always)
            DispatchQueue.main.async {
                self.mapView.zoomToLocation(self.mapView.userLocation.location)
            }
        }
    }
    
    // MARK: Other mapview functions
    @IBAction func zoomToCurrentLocation(sender: AnyObject) {
      mapView.zoomToLocation(mapView.userLocation.location)
    }

}
extension MKMapView {
  func zoomToLocation(_ location: CLLocation?) {
    guard let coordinate = location?.coordinate else { return }
    let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10_000, longitudinalMeters: 10_000)
    setRegion(region, animated: true)
  }
}
