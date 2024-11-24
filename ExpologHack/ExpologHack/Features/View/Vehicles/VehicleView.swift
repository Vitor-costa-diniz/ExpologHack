//
//  VehicleView.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct VehicleView: View {
    @ObservedObject var viewModel: VehicleViewModel
    @State private var showSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color.neutral600
                .ignoresSafeArea()
            
            VStack(spacing: 8) {
                Image(.personTruck)
                    .padding(.bottom, 8)
                
                Text("Nenhum veículo cadastrado!")
                    .font(.custom(TokenFont.semibold.rawValue, size: 20))
                
                Text("Parece que você ainda não possui nenhum veículo cadastrado, cadastre seu veículo para realizar viagens.")
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 32)
                    .font(.custom(TokenFont.medium.rawValue, size: 16))
                
                Button(action: { showSheet.toggle() }) {
                    Text("Cadastrar veículo")
                        .font(.custom(TokenFont.semibold.rawValue, size: 14))
                        .foregroundStyle(.white)
                        .frame(height: 48)
                        .frame(maxWidth: 345)
                        .background {
                            Color.primary500
                                .clipShape(.rect(cornerRadius: 8))
                        }
                }
            }
            .padding(.horizontal, 24)
            .sheet(isPresented: $showSheet, content: {
                AddVehicleSheet()
                    .environmentObject(viewModel)
            })
            
        }
    }
}

#Preview {
    VehicleView(viewModel: .init())
}
