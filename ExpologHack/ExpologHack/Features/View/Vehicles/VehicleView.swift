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
        NavigationStack {
            ZStack {
                Color.neutral600
                    .ignoresSafeArea()
                
                VStack(spacing: 8) {
                    if viewModel.vehicles.isEmpty {
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
                    } else {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(viewModel.vehicles.first?.name ?? "Vitor")
                                .font(.custom(TokenFont.semibold.rawValue, size: 28))
                                .padding(.bottom, 24)
                                .foregroundStyle(Color.neutralN50)
                            
                            ForEach(VehicleComponentTitle.allCases, id: \.self) { result in
                                HStack {
                                    Text(result.rawValue)
                                        .foregroundStyle(Color.neutralN50)
                                    Spacer()
                                    Text(viewModel.getVehicleInfo(for: result))
                                        .foregroundStyle(Color.neutralN50)
                                }
                                .padding(.bottom, 16)
                                .font(.custom(TokenFont.regular.rawValue, size: 16))
                            }
                            
                            Text("Especificidades")
                                .font(.custom(TokenFont.semibold.rawValue, size: 20))
                                .foregroundStyle(Color.neutralN50)
                                .padding(.top, 24)
                                .padding(.bottom, 8)
                            
                            Text(viewModel.vehicles.first?.specs ?? "Nada a declarar sobre o caminhão")
                                .foregroundStyle(Color.neutralN50)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                        .padding(.top, 32)
                    }
                }
                .padding(.horizontal, 24)
                .sheet(isPresented: $showSheet, content: {
                    AddVehicleSheet()
                        .environmentObject(viewModel)
                })
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {}, label: {
                            if !viewModel.vehicles.isEmpty {
                                Text("Editar")
                                    .foregroundStyle(Color.primary200)
                                    .font(.custom(TokenFont.semibold.rawValue, size: 16))
                            }
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    VehicleView(viewModel: .init())
}
