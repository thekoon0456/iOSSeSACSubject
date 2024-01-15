//
//  TheaterViewController.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/15/24.
//

import MapKit
import UIKit


class TheaterViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    let defaultData = TheaterList().mapAnnotations
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureMap()
    }
}


extension TheaterViewController: setUI {
    
    func configureUI() {
        navigationItem.title = "주변 영화관 탐색하기"
    }
    
    func configureMap() {
        mapView.delegate = self
        
        let coordinate2 = CLLocationCoordinate2D(latitude: defaultData[0].latitude,
                                                 longitude: defaultData[0].longitude)
        
        //meters: 중심지로부터 거리
        let region = MKCoordinateRegion(center: coordinate2,
                                        latitudinalMeters: 10000,
                                        longitudinalMeters: 10000)
        
        mapView.setRegion(region, animated: true)
        
        defaultData.forEach { theater in
            let coordinate = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = theater.location
            
            mapView.addAnnotation(annotation)
        }
    }
}

extension TheaterViewController: MKMapViewDelegate {
    
}
