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
        UITabBar.appearance().barTintColor = UIColor(.neutral500)
    }
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            FreightListView(hasVehicle: !vehicleViewModel.vehicles.isEmpty,
                            freightViewModel: freightViewModel,
                            packageViewModel: packageViewModel)
                .tag(0)
                .tabItem {
                    Label(
                        title: { Text("Fretes") },
                        icon: { Image(.packageBox) }
                    )
                }
            
            VehicleView(viewModel: vehicleViewModel)
                .tag(1)
                .tabItem {
                    Label(
                        title: { Text("Veículo") },
                        icon: { Image(.truck) }
                    )
                }
        }
        .tint(Color.primary300)
    }
}

#Preview {
    BaseListView(packageViewModel: .init(), freightViewModel: .init(), vehicleViewModel: .init())
}

