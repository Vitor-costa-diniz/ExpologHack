//
//  VehicleView.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct VehicleView: View {
    @ObservedObject var viewModel: VehicleViewModel
    
    var body: some View {
        ZStack {
            Color.neutral600
                .ignoresSafeArea()
            
            VStack(spacing: 8) {
                Image(.personTruck)
                    .padding(.bottom, 8)
                
                Text("Nenhum veículo cadastrado!")
                
                Text("Parece que você ainda não possui nenhum veículo cadastrado, cadastre seu veículo para realizar viagens.")
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 32)
                
                Button(action: {}) {
                    Text("Cadastrar veículo")
                        .foregroundStyle(.white)
                        .frame(maxWidth: 345)
                        .frame(height: 48)
                        .background {
                            Color.primary500
                                .clipShape(.rect(cornerRadius: 16))
                        }
                }
            }
            .padding(.horizontal, 24)
            
        }
    }
}

#Preview {
    VehicleView(viewModel: .init())
}
