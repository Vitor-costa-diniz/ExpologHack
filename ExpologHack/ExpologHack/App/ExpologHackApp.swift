//
//  ExpologHackApp.swift
//  ExpologHack
//
//  Created by Vitor Costa on 23/11/24.
//

import SwiftUI

@main
struct ExpologHackApp: App {
    var body: some Scene {
        let persistenceContainer = PersistenceController.shared
        WindowGroup {
            BaseListView(packageViewModel: PackageViewModel(), freightViewModel: FreightViewModel(), vehicleViewModel: VehicleViewModel())
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
