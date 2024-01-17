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
    
    var theaterData = TheaterList().mapAnnotations {
        didSet {
            print(theaterData)
            resetMapAnnotation()
            configureMap()
        }
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureMap()
    }
    
    @objc func filterButtonTapped(sender: UIBarButtonItem) {
        setMovieAlert()
    }
}

extension TheaterViewController {
    
    func setMovieAlert() {
        let alert = UIAlertController(title: TheaterString.alertTitle.rawValue,
                                      message: TheaterString.alertSubTitle.rawValue,
                                      preferredStyle: .actionSheet)
        
        TheaterName.allCases.forEach { name in
            let button = UIAlertAction(title: name.rawValue,
                                       style: .default) { [self] _ in
                if name == .all {
                    theaterData = defaultData
                } else {
                    theaterData = defaultData.filter { $0.type == name.rawValue }
                }
            }
            
            alert.addAction(button)
        }
        
        present(alert, animated: true)
    }
    
    //맵 구성
    func configureMap() {
        mapView.delegate = self
        
        let coordinate2 = CLLocationCoordinate2D(latitude: theaterData[0].latitude,
                                                 longitude: theaterData[0].longitude)
        
        //meters: 중심지로부터 거리
        let region = MKCoordinateRegion(center: coordinate2,
                                        latitudinalMeters: 10000,
                                        longitudinalMeters: 10000)
        
        mapView.setRegion(region, animated: true)
        
        theaterData.forEach { theater in
            let coordinate = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = theater.location
            
            mapView.addAnnotation(annotation)
        }
    }
    
    //맵 annotaion 리셋
    func resetMapAnnotation() {
        mapView.removeAnnotations(mapView.annotations)
    }
}


extension TheaterViewController: SetUI {
    
    func configureUI() {
        navigationItem.title = TheaterString.naviTitle.rawValue
        
        let item = UIBarButtonItem(image: TheaterImageStyle.mapFilterImage,
                                   style: .plain,
                                   target: self,
                                   action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = item
    }
}

// MARK: - MapView

extension TheaterViewController: MKMapViewDelegate { 
    //시점 이동
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? MKPointAnnotation else { return }
        
        let region = MKCoordinateRegion(center: annotation.coordinate,
                                        latitudinalMeters: 5000,
                                        longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
    }
}
