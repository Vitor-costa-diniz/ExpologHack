//
//  BaseListView.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 23/11/24.
//

import SwiftUI

struct BaseListView: View {
    @State private var selectedIndex = 0
    @ObservedObject var packageViewModel: PackageViewModel
    @ObservedObject var freightViewModel: FreightViewModel
    @ObservedObject var vehicleViewModel: VehicleViewModel
    
    init(packageViewModel: PackageViewModel, freightViewModel: FreightViewModel, vehicleViewModel: VehicleViewModel) {
        self.packageViewModel = packageViewModel
        self.freightViewModel = freightViewModel
        self.vehicleViewModel = vehicleViewModel
        UITabBar.appearance().barTintColor = .systemBackground
    }
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            FreightListView(freightViewModel: freightViewModel, packageViewModel: packageViewModel)
                .onAppear {
                    freightViewModel.fetch()
                }
                .tag(0)
                .tabItem {
                    Label(
                        title: { Text("Home") },
                        icon: { Image(systemName: "star.fill") }
                    )
                }
            
            
            VehicleView(viewModel: vehicleViewModel)
                .tag(1)
                .tabItem {
                    Label(
                        title: { Text("Home") },
                        icon: { Image(systemName: "star.fill") }
                    )
                }
        }
    }
}
