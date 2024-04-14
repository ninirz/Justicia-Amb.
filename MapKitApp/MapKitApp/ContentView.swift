//
//  ContentView.swift
//  MapKitApp
//
//  Created by Wendy Sanchez Cortes on 11/04/24.
//

import SwiftUI
// Map Kit
import MapKit

// Creamos una clase a la que le delegamos el manejo de la solicitud y actualizacion de la ubicación. Notificando cada vez que la ubicación del dispositivo cambie, ocurra un error, sean los permisos denegados, etc.

// La clase debe extdernde NSOBject

//Agregamos este estado. Todo el contendo de la clase manda actualizaciones a los estados.
@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager ()
    let manager: CLLocationManager = CLLocationManager()
    var region: MKCoordinateRegion = MKCoordinateRegion()
    
    override init() {
        super.init()
        self.manager.delegate = self // Delegado
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // ESTAS 3 FUNCIONES SON PARTE DEL DELEGADO CLLocationManagerDelegate
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Sobre el estado de la autorización
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization() // Lanzo alerta de permiso
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation() // Pido la ubicacion, lat, long
        case .denied:
            print("Denied")
        case .restricted:
            print("Restricted")
        default:
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
            
    }
}

// Guardar nuestras coordenadas
extension CLLocationCoordinate2D {
    static var cetys = CLLocationCoordinate2D(latitude: 32.505193356856495, longitude:  -116.9245693289165)
    
    static var tecMty = CLLocationCoordinate2D(latitude: 25.65186,longitude: -100.28942)
    static var cuaad = CLLocationCoordinate2D(latitude: 20.7407, longitude:  -103.3118)
    static var unach = CLLocationCoordinate2D(latitude: 14.89459016224614, longitude: -92.2714503552291)
    static var fiUNAM = CLLocationCoordinate2D(latitude: 19.331164700290387, longitude:  -99.18462362360968)
    static var cuvalles = CLLocationCoordinate2D(latitude: 20.53459, longitude:  -103.96733)
    
}

struct ContentView: View {
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    // Creamos una instancia que controle unicamente las ubicaciones
    @State private var locationManager = LocationManager.shared
    
    @State private var mapItems : [MKMapItem] = []
    
    // como no podemos hacer busquedas asincronas, creamos esto para llamar al task
    @State private var isSearching = false
    
    // Buscar en el mapa
    func perfomSearch(search: String, region: MKCoordinateRegion) async throws -> [MKMapItem] {
            
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = search
            request.resultTypes = .pointOfInterest
            
            request.region = region
            let search = MKLocalSearch(request: request)
            let response = try await search.start()
            
            return response.mapItems
        }
    
    func search() async {
            do {
                mapItems = try await perfomSearch(search: "Coffe", region: locationManager.region)
                print("HEY HEY")
                print(mapItems)
                isSearching = false
            } catch {
                print("HEY HEY")
                mapItems = []
                isSearching = false
            }
        }
    
    var body: some View {
        ZStack {
            Map (position: $position){
                // La ubicación del dispositivo actual
                UserAnnotation()
                
                // Marker >> Señala puntos del mapa
                Marker("Tec de Mty", coordinate: .tecMty).tint(.blue)
                Marker("CETYS", coordinate: .cetys).tint(.orange)
                Marker("CUAAD", coordinate: .cuaad).tint(.brown)
                Marker("UNACH", coordinate: .unach).tint(.orange)
                Marker("CUValles", coordinate: .cuvalles).tint(.cyan)
                
                // Annotation >> A diferencia los marcadores, es personalizable, es una vista.
                
                Annotation("UNAM FI", coordinate: .fiUNAM) {
                    Image(systemName: "graduationcap.fill")
                        .padding(5)
                        .foregroundStyle(.white)
                        .background(Color.black)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                
                
            } // PARA DETECTAR CAMBIOS DE ESTADO. COMO onChange se basa en comparar State, debe poder comapralos, pro lo tanto debe implemnetar el protoco Equatble, en este caso haremos yna extemsion para determinar como debe comrparlos.
            
            .task(id: isSearching, {
                            if isSearching {
                                await search()
                            }
                        })
            .
            onChange(of: locationManager.region) {
                position = .region(locationManager.region)
            }
            .mapStyle(.standard)
            
            VStack {
                Spacer ()
                Button ("FI UNAM") {
                    print("HEY HEY 1")
                    let regionFI = MKCoordinateRegion(center: .fiUNAM, span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009))
                    position = .region(regionFI)
                }
                .buttonStyle(.borderedProminent)
                
                Button("Search"){
                    print("HEY HEY")
                    isSearching = true
                }
                .buttonStyle(.borderedProminent)
                
                //NO PUEDO USAR FUNCIONES ASINCRONAS EN EL BODY
            }
        }
        
        
    }
}

extension MKCoordinateRegion: Equatable {
    
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
            return lhs.center.latitude == rhs.center.latitude && lhs.center.longitude == rhs.center.longitude && rhs.span.latitudeDelta == lhs.span.latitudeDelta && lhs.span.longitudeDelta == rhs.span.longitudeDelta
        }
    
}

