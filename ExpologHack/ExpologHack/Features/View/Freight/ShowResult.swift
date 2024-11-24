//
//  ShowResult.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct ShowResult: View {
    var body: some View {
        ZStack {
            Color.neutral600
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    routeStopsInfo
                        .padding(.top, -2)
                    
                    driverInfos
                    
                    fuelInfos
                }
                .padding(.top, 24)
                .navigationTitle("Detalhes da entrega")
            }
        }
    }
    
    private var routeStopsInfo: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(.miniTruck)
                    .frame(width: 52, height: 52)
                    .background(
                        Circle()
                            .foregroundStyle(Color.primary200)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Duração da viagem: 1d 22hrs e 32min")
                        .font(.custom(TokenFont.medium.rawValue, size: 14))
                        .foregroundStyle(Color.neutral0)
                    
                    Text("Frete #38422")
                        .font(.custom(TokenFont.medium.rawValue, size: 20))
                        .foregroundStyle(Color.neutral0)
                }
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(FreightUpdate.mockData) { update in
                    HStack(alignment: .top, spacing: 12) {
                        update.iconName
                            .frame(width: 52, height: 52)
                            .background(
                                Circle()
                                    .foregroundStyle(update.isActive ? Color.primary200 : Color.neutral200)
                            )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(update.status)
                                .font(.custom(TokenFont.medium.rawValue, size: 16))
                                .foregroundStyle(Color.neutral0)
                            
                            Text(update.location)
                                .font(.custom(TokenFont.regular.rawValue, size: 13))
                                .foregroundStyle(Color.neutral0)
                            
                            Text("Atualização realizada em: \(update.updateTime)")
                                .font(.custom(TokenFont.regular.rawValue, size: 10))
                                .foregroundStyle(Color.neutral100)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(
            Color.cardBackground
                .clipShape(.rect(cornerRadius: 16))
        )
        .padding(.horizontal, 16)
    }
    
    private var driverInfos: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Código do cliente")
                        .font(.custom(TokenFont.medium.rawValue, size: 16))
                        .foregroundStyle(.neutral0)
                    
                    Text("#500424")
                        .font(.custom(TokenFont.medium.rawValue, size: 14))
                        .foregroundStyle(.neutral100)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Mercadoria")
                        .font(.custom(TokenFont.medium.rawValue, size: 16))
                        .foregroundStyle(.neutral0)
                    
                    Text("Frutas")
                        .font(.custom(TokenFont.medium.rawValue, size: 14))
                        .foregroundStyle(.neutral100)
                }
                
                Spacer()
            }
            
            HStack(alignment: .lastTextBaseline) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Pacotes")
                        .font(.custom(TokenFont.medium.rawValue, size: 16))
                        .foregroundStyle(.neutral0)
                    
                    Text("20 pallets")
                        .font(.custom(TokenFont.medium.rawValue, size: 14))
                        .foregroundStyle(.neutral100)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Peso")
                        .font(.custom(TokenFont.medium.rawValue, size: 16))
                        .foregroundStyle(.neutral0)
                    
                    Text("15000 Quilos")
                        .font(.custom(TokenFont.medium.rawValue, size: 14))
                        .foregroundStyle(.neutral100)
                    
                }
                .offset(x: 35)
                
                Spacer()
            }
        }
        .padding()
        .background(
            Color.cardBackground
                .clipShape(.rect(cornerRadius: 16))
        )
        .padding(.horizontal, 16)
    }
    
    private var fuelInfos: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Consumo médio de combustível")
                    .font(.custom(TokenFont.medium.rawValue, size: 16))
                    .foregroundStyle(.neutral0)
                
                Text("3,6km/L")
                    .font(.custom(TokenFont.medium.rawValue, size: 16))
                    .foregroundStyle(.neutral100)
                    .padding(.bottom, 12)
                
                Text("Emissão total de CO₂")
                    .font(.custom(TokenFont.medium.rawValue, size: 16))
                    .foregroundStyle(.neutral0)
                
                Text("2,3 toneladas de CO₂")
                    .font(.custom(TokenFont.medium.rawValue, size: 16))
                    .foregroundStyle(.neutral100)
                    .padding(.bottom, 12)
                
                Text("Custo médio da viagem: R$ 6624,00")
                    .font(.custom(TokenFont.medium.rawValue, size: 16))
                    .foregroundStyle(.neutral0)
                
                Text("Combustível: R$ 5.142,00")
                    .font(.custom(TokenFont.medium.rawValue, size: 16))
                    .foregroundStyle(.neutral100)
                
                Text("Pedágios: R$ 1.500,00.")
                    .font(.custom(TokenFont.medium.rawValue, size: 16))
                    .foregroundStyle(.neutral100)
            }
            
            Spacer()
        }
        .padding()
        .background(
            Color.cardBackground
                .clipShape(.rect(cornerRadius: 16))
        )
        .padding(.horizontal, 16)
    }
}

#Preview {
    ShowResult()
}
