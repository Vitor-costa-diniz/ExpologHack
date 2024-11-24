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
                    emptyRoutes
                        .padding(.bottom, 32)
                    
                    Button(action: {}) {
                        Text("Criar entrega")
                            .font(.custom(TokenFont.semibold.rawValue, size: 14))
                            .foregroundStyle(.white)
                            .frame(height: 48)
                            .frame(maxWidth: 345)
                            .background {
                                Color.primary500
                                    .clipShape(.rect(cornerRadius: 8))
                            }
                    }
                    
                } else {
                    emptyState
                }
            }
        }
    }
    
    private var emptyRoutes: some View {
        VStack(spacing: 8) {
            Image(.miniMap)
                .padding(.bottom, 8)
            
            Text("Faça sua primeira entrega conosco!")
                .font(.custom(TokenFont.semibold.rawValue, size: 20))
                .foregroundStyle(.white)
            
            Text("Suas entregas realizadas serão exibidas nessa seção, faça sua primeira viagem conosco.")
                .font(.custom(TokenFont.medium.rawValue, size: 16))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 24)
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

#Preview {
    FreightListView(hasVehicle: false, freightViewModel: .init(), packageViewModel: .init())
}
