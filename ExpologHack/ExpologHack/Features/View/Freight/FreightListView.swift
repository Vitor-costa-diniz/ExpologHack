//
//  VehicleListView.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 23/11/24.
//

import SwiftUI

struct FreightListView: View {
    @State var searchText: String = ""
    let hasVehicle: Bool
    @ObservedObject var freightViewModel: FreightViewModel
    @ObservedObject var packageViewModel: PackageViewModel
    
    var body: some View {
        ZStack {
            Color.neutral600
                .ignoresSafeArea()
            
            VStack {
                if hasVehicle {
                    
                } else {
                    emptyState
                }
            }
        }
    }
    
    private var emptyState: some View {
        VStack(spacing: 8) {
            Image(.noVehicle)
                .padding(.bottom, 8)
            
            Text("Cadastre um veículo antes.")
                .font(.custom(TokenFont.semibold.rawValue, size: 20))
                .foregroundStyle(.white)
            
            Text("Antes de iniciar uma entrega, é preciso cadastrar seu veículo na plataforma.")
                .font(.custom(TokenFont.medium.rawValue, size: 16))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    FreightListView(hasVehicle: false, freightViewModel: .init(), packageViewModel: .init())
}
