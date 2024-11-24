//
//  MapView.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 24/11/24.
//

import Foundation
import SwiftUI
import UIKit

struct MapView: UIViewControllerRepresentable {
    let navigation: Navigation
    @State var addresses: [String]
    @State var departure: String

    func makeUIViewController(context: Context) -> UIViewController {
        Task {
            await navigation.geocodeAddresses(departure: departure, addresses: addresses)
            sleep(5)
             try await navigation.requestRoutes()
        }
        return MapViewController(navigation: navigation)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
