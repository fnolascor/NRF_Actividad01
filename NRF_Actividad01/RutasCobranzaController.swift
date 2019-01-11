//
//  RutasCobranzaController.swift
//  NRF_Actividad01
//
//  Created by usuario on 1/9/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit
import MapKit

class RutasCobranzaController: UIViewController {
    @IBOutlet weak var uiMap: MKMapView!
    @IBOutlet weak var txtPersonaVisita: UITextField!
    @IBOutlet weak var txtAdeudo: UITextField!
    @IBOutlet weak var txtNotas: UITextField!
    @IBOutlet weak var txtTiempoEstimado: UITextField!
    @IBOutlet weak var txtDireccion: UITextField!
    @IBOutlet weak var txtCodigoPostal: UITextField!
    @IBOutlet weak var txtDelegacion: UITextField!
    
    var nombreEmpleado: String?
    
    func CalcularTiempo(segundos: Double) -> String
    {
        let horas = Int(segundos / 3600)
        let minutos = Int((segundos-Double(horas)*3600)/60)
        return String(horas) + ":" + String(minutos) + " hrs"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if nombreEmpleado != nil
        {
            uiMap.delegate = self
            var coordinates2: CLLocationCoordinate2D? = nil
            
            if(nombreEmpleado! == "Francisco Nolasco Reyes")
            {
                txtPersonaVisita.text = "Ernesto Hernández Ordaz"
                txtAdeudo.text = "$4687.00"
                txtNotas.text = "N/E"
                coordinates2 = CLLocationCoordinate2D(latitude:19.4932808, longitude:-99.120454)
            }
            else if(nombreEmpleado! == "Jazmin Valentina Salazar Velázquez")
            {
                txtPersonaVisita.text = "Fanny Jazmin Salazar López"
                txtAdeudo.text = "$100.00"
                txtNotas.text = "N/E"
                coordinates2 = CLLocationCoordinate2D(latitude:19.3948, longitude:-99.1736)
            }
            else if(nombreEmpleado! == "Rogelio López Gómez")
            {
                txtPersonaVisita.text = "José Luis Cázares Arroyo"
                txtAdeudo.text = "$3001.75"
                txtNotas.text = "Cocina integral"
                coordinates2 = CLLocationCoordinate2D(latitude:19.3040996, longitude:-99.192218)
            }
            
            let coordinates = CLLocationCoordinate2D(latitude:19.4336523, longitude:-99.1454316)
            
            //MARK: Trazando ruta
            let sourcePlacemark = MKPlacemark.init(coordinate: coordinates)
            let sourceMapItem = MKMapItem.init(placemark: sourcePlacemark)
            
            let destinationPlacemark = MKPlacemark.init(coordinate: coordinates2!)
            let destinationMapItem = MKMapItem.init(placemark: destinationPlacemark)
            
            
            //MARK: Obtener direcciones
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(CLLocation(latitude: coordinates2!.latitude, longitude: coordinates2!.longitude))
            {
                (placemarks, error) in
                if(error != nil)
                {
                    print(error)
                }
                if let placemarks = placemarks
                {
                    self.txtDelegacion.text = placemarks[0].subLocality
                    self.txtDireccion.text = placemarks[0].name
                    self.txtCodigoPostal.text = placemarks[0].postalCode
                    
                }
            }
            
            let directionRequest = MKDirections.Request()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .automobile
            
            let directions = MKDirections(request: directionRequest)
            directions.calculate {
                (response, error) -> Void in
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    return
                }
                let route = response.routes[0]
                
                self.txtTiempoEstimado.text = self.CalcularTiempo(segundos: route.expectedTravelTime)
                self.uiMap.addOverlay(route.polyline, level: .aboveRoads)
                let rect = route.polyline.boundingMapRect
                self.uiMap.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
    }
}

extension RutasCobranzaController: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineDashPattern = [2,4];
        renderer.lineWidth = 4.0
        renderer.alpha = 1
        return renderer
    }
}
