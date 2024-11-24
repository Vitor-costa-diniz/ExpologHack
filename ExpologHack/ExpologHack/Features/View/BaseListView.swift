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
    
    init(packageViewModel: PackageViewModel, freightViewModel: FreightViewModel) {
        self.packageViewModel = packageViewModel
        self.freightViewModel = freightViewModel
        UITabBar.appearance().barTintColor = .systemBackground
    }
    
    let tabBarImage = ["person.fill", "person.2.fill"]
    
    var body: some View {
        VStack {
            FreightListView(freightViewModel: freightViewModel, packageViewModel: packageViewModel)
            Spacer()
        }
        .onAppear {
            freightViewModel.fetch()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
