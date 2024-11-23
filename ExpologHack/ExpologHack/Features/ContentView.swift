//
//  ContentView.swift
//  ExpologHack
//
//  Created by Vitor Costa on 23/11/24.
//

import SwiftUI
import CoreLocation
import MapboxDirections
import MapboxNavigationCore
import MapboxNavigationUIKit
import MapboxMaps


struct NavigationViewControllerRepresentable: UIViewControllerRepresentable {
    var departure: String
    var addresses: [String]
    
    @State private var isLoading: Bool = true
    @State private var waypoints: [Waypoint] = []
    
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        Task {
            await geocodeAddresses()
            DispatchQueue.main.async {
                isLoading = false
                calculateRoutes { navigationViewController in
                    DispatchQueue.main.async {
                        viewController.present(navigationViewController, animated: true, completion: nil)
                    }
                }
            }
        }
        
        // Mostrar uma tela de carregamento enquanto os dados não estiverem prontos
        if isLoading {
            let loadingView = UIActivityIndicatorView(style: .large)
            loadingView.startAnimating()
            viewController.view.addSubview(loadingView)
            loadingView.center = viewController.view.center
        }
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Nenhuma atualização necessária no momento
    }
    
    @MainActor private func calculateRoutes(completion: @escaping (NavigationViewController) -> Void) {
        let mapboxNavigationProvider = MapboxNavigationProvider(
            coreConfig: .init(locationSource: .simulation(initialLocation: CLLocation(latitude: waypoints.first!.coordinate.latitude, longitude: waypoints.first!.coordinate.longitude)))
        )
        
        let mapboxNavigation = mapboxNavigationProvider.mapboxNavigation
        let coordinates = waypoints.map { $0.coordinate }
        let options = NavigationRouteOptions(coordinates: coordinates)

        let request = mapboxNavigation.routingProvider().calculateRoutes(options: options)
        
        Task {
            switch await request.result {
            case .failure(let error):
                print("Erro ao calcular a rota: \(error.localizedDescription)")
            case .success(let navigationRoutes):
                let navigationOptions = NavigationOptions(
                    mapboxNavigation: mapboxNavigation,
                    voiceController: mapboxNavigationProvider.routeVoiceController,
                    eventsManager: mapboxNavigationProvider.eventsManager()
                )
                
                let navigationViewController = NavigationViewController(
                    navigationRoutes: navigationRoutes,
                    navigationOptions: navigationOptions
                )
                
                navigationViewController.modalPresentationStyle = .fullScreen
                navigationViewController.routeLineTracksTraversal = true
                
                completion(navigationViewController)
            }
        }
    }
    
    private func geocodeAddresses() async {
        let geocoder = CLGeocoder()
        
        let allAddresses = [departure] + addresses.filter { !$0.isEmpty }
        
        for address in allAddresses {
            do {
                let placemarks = try await geocoder.geocodeAddressString(address)
                if let location = placemarks.first?.location {
                    waypoints.append(Waypoint(coordinate: location.coordinate, name: address))
                }
            } catch {
                print("Erro ao geocodificar endereço \(address): \(error.localizedDescription)")
            }
        }
    }
}
