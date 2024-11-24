//
//  NavigationView.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 24/11/24.
//

import Foundation
import SwiftUI
import CoreLocation
import MapboxDirections
import MapboxNavigationCore
import MapboxNavigationUIKit
import MapboxMaps


struct NavigationView: View {
    @ObservedObject var navigation: Navigation
    @State var addresses: [String]
    @State var departure: String

    var body: some View {
        ZStack {
            VStack {
                MapView(navigation: navigation, addresses: addresses, departure: departure)
                    .ignoresSafeArea(.all)
                HStack {
                    if navigation.currentPreviewRoutes != nil {
                        Button(action: {
                            navigation.startActiveNavigation()
                        } ) {
                            Text("Iniciar navegação")
                                .foregroundColor(.white) // Texto branco
                                .font(.headline) // Fonte em destaque
                                .frame(width: 249, height: 48) // Dimensões fixas do botão
                                .background(Color.blue) // Fundo azul
                                .cornerRadius(10) // Bordas levemente arredondadas
                                }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 45)
            }
            if navigation.isInActiveNavigation {
                NavigationControlsView(navigation: navigation)
            }
        }
    }
}
