//
//  AddGeotificationViewController.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 27/01/2022.
//

import UIKit
import MapKit

protocol AddGeotificationsViewControllerDelegate: AnyObject {
  func addGeotificationViewController(_ controller: AddGeotificationViewController)
}
class AddGeotificationViewController: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var txfLocationName: UITextField!
    @IBOutlet private weak var txfWifi: UITextField!
    @IBOutlet private weak var btnSave: UIButton!
    @IBOutlet private weak var txfRadius: UITextField!
    
    private let geoficationUseCase: GeofenceAreaUseCase
    weak var delegate: AddGeotificationsViewControllerDelegate?
    
    init(geoficationUseCase: GeofenceAreaUseCase) {
        self.geoficationUseCase = geoficationUseCase
        super.init(nibName: "AddGeotificationViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Geotification"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        mapView.showsUserLocation = true
        mapView.zoomToLocation(mapView.userLocation.location)
    }
    
    @objc
    private func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSaveAction(_ sender: Any) {
        let coordinate = Coordinate(late: mapView.centerCoordinate.latitude,
                                    long: mapView.centerCoordinate.longitude)
        let radius = Double(txfRadius.text ?? "") ?? 0
        geoficationUseCase.add(radius: radius,
                               name: txfLocationName.text!,
                               wifiName: txfWifi.text!,
                               coordinate: coordinate) { [unowned self] result in
            switch result {
            case .success(_):
                delegate?.addGeotificationViewController(self)
                dismiss(animated: true, completion: nil)
            case .failure(let err):
                self.showAlert(withTitle: "Error", message: err.localizedDescription)
            }
        }
    }
    
    @IBAction func zoomToCurrenLocation(_ sender: Any) {
        mapView.zoomToLocation(mapView.userLocation.location)
    }
}
