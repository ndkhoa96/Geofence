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
    private let geofenceAreaUseCase: GeofenceAreaUseCase
    private var connectedGeoAreaEntity: GeoAreaEntity?
    
    init(geofenceAreaUseCase: GeofenceAreaUseCase) {
        self.geofenceAreaUseCase = geofenceAreaUseCase
        super.init(nibName: "GeotificationsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initHandling()
        loadAllGeotifications()
        title = titleString + "OFF"
        
        locationManager.onEnterGeoArea { [unowned self] entity in
            if entity.isInsideArea(mapView.userLocation.coordinate.toCoordinate()) {
                return
            }
            connectedGeoAreaEntity = entity
            entity.isWifiConnected = true
            title = titleString + entity.wifiName
            navigationItem.prompt = "Is inside location: \(entity.name)"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Disconnect", style: .plain, target: self, action: #selector(handleDisconnectWifi))
        }
    }
    
    @objc
    private func handleDisconnectWifi() {
        if let geoAreaEntity = connectedGeoAreaEntity {
            geoAreaEntity.isWifiConnected = false
            title = titleString + "OFF"
            navigationItem.prompt = ""
            connectedGeoAreaEntity = nil
        }
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
        geofenceAreaUseCase.loadAll { [unowned self] result in
            switch result {
            case .success(let geoEntities):
                geoEntities.forEach { entity in
                    let geoAreaUI = entity.toGeoAreaUI()
                    mapView.addAnnotation(geoAreaUI)
                    addRadiusOverlay(forGeotification: geoAreaUI)
                    self.locationManager.startMonitoring(geotification: entity)
                }
            case .failure(let err):
                self.showAlert(withTitle: "Error", message: err.localizedDescription)
            }
        }
    }
    
    private func addRadiusOverlay(forGeotification geotification: GeoAreaUI) {
        mapView.addOverlay(MKCircle(center: geotification.coordinate,
                                    radius: geotification.radius))
    }
    
    private func remove(_ geoAreaUI: GeoAreaUI) {
        mapView.removeAnnotation(geoAreaUI)
        removeRadiusOverlay(forGeotification: geoAreaUI)
    }
    
    private func removeRadiusOverlay(forGeotification geoAreaUI: GeoAreaUI) {
        // Find exactly one overlay which has the same coordinates & radius to remove
        guard let overlays = mapView?.overlays else { return }
        for overlay in overlays {
            guard let circleOverlay = overlay as? MKCircle else { continue }
            let coord = circleOverlay.coordinate
            if coord.latitude == geoAreaUI.coordinate.latitude &&
                coord.longitude == geoAreaUI.coordinate.longitude &&
                circleOverlay.radius == geoAreaUI.radius {
                mapView.removeOverlay(circleOverlay)
                break
            }
        }
    }
    
    // MARK: Other mapview functions
    @IBAction func zoomToCurrentLocation(sender: AnyObject) {
        mapView.zoomToLocation(mapView.userLocation.location)
    }
    
    @IBAction func addNewGeofication(_ sender: Any) {
        let useCase = GeofenceAreaUseCaseImp(repo: UserDefaultGeofenceRepositoryImp())
        let addGeoficationVC = AddGeotificationViewController(geoficationUseCase: useCase)
        addGeoficationVC.delegate = self
        present(UINavigationController(rootViewController: addGeoficationVC), animated: true, completion: nil)
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
        // Delete geo area
        guard let geoAreaUI = view.annotation as? GeoAreaUI else { return }
        locationManager.stopMonitoring(geotification: geoAreaUI.toGeoAreaEntity())
        remove(geoAreaUI)
    }
}
extension GeotificationsViewController: AddGeotificationsViewControllerDelegate {
    func addGeotificationViewController(_ controller: AddGeotificationViewController, _ geoAreaUI: GeoAreaUI) {
        mapView.addAnnotation(geoAreaUI)
        addRadiusOverlay(forGeotification: geoAreaUI)
        locationManager.startMonitoring(geotification: geoAreaUI.toGeoAreaEntity())
    }
    
}
