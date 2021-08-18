//
//  MapTableViewCell.swift
//  RecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import MapKit
import SnapKit

class MapView: UIView {
    var paths: [Path]? {
        didSet { updatePaths()}
    }

    var points: [PathPoint]? {
        didSet { updatePoints() }
    }

    private var mapPolylines: [MKPolyline]? {
        didSet {
            oldValue?.forEach { mapView.removeOverlay($0) }
            mapPolylines?.forEach { mapView.addOverlay($0) }
            centerMap()
        }
    }

    private var mapPointAnnotations: [MKPointAnnotation]? {
        didSet {
            oldValue?.forEach { mapView.removeAnnotation($0) }
            mapPointAnnotations?.forEach { mapView.addAnnotation($0) }
            centerMap()
        }
    }

    private let mapView = MKMapView()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapView: ViewBuilder {
    func setupViewHierarchy() {
        addSubview(mapView)
    }

    func setupViewAutolayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupViewProperties() {
        mapView.delegate = self
    }
}

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = .systemRed
            renderer.lineWidth = 1
            return renderer
        }
        return MKOverlayRenderer()
    }
}

private extension MapView {
    func updatePaths() {
        mapPolylines = paths?.map {
            let coordinates = $0.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }
            return MKPolyline(coordinates: coordinates, count: coordinates.count)
        }
    }

    func updatePoints() {
        mapPointAnnotations = points?.map {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
            return annotation
        }
    }
}

private extension MapView {
    func centerMap() {
        var mapRect: MKMapRect = .null
        points?.forEach {
            mapRect = mapRect.union(MKMapRect(
                origin: MKMapPoint(CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)),
                size: MKMapSize(width: 0, height: 0)
            ))
        }
        paths?.forEach { $0.forEach {
            mapRect = mapRect.union(MKMapRect(
                origin: MKMapPoint(CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)),
                size: MKMapSize(width: 0, height: 0)
            ))
        } }
        mapView.setRegion(MKCoordinateRegion(mapRect), animated: false)
    }
}
