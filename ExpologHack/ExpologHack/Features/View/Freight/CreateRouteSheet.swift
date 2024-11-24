//
//  CreateRouteSheet.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct CreateRouteSheet: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: FreightViewModel
    @State private var stopPoint: String = ""
    @State private var navigateToMap = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.neutral600
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Adicione a carga a ser transportada")
                            .font(.custom(TokenFont.medium.rawValue, size: 16))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    
                    TextField(text: $viewModel.selectLoad) {
                        Text("Carga a ser transportada")
                    }
                    .frame(minHeight: 50)
                    .padding(.horizontal, 16)
                    .background {
                        Color.neutralN400
                            .clipShape(.rect(cornerRadius: 12))
                    }
                    
                    Text("Insira o ponto de partida e os destinos:")
                        .font(.custom(TokenFont.medium.rawValue, size: 16))
                    
                    TextField(text: $viewModel.derparturePoint) {
                        Text("Ponto de partida")
                    }
                    .frame(minHeight: 50)
                    .padding(.horizontal, 16)
                    .background {
                        Color.neutralN400
                            .clipShape(.rect(cornerRadius: 12))
                    }
                    .padding(.bottom, 8)
                    
                    ForEach(0 ..< max(1, viewModel.stopPoints.count + 1), id: \.self) { index in
                            VStack(alignment: .leading) {
                                TextField(
                                    "Destino \(index + 1)",
                                    text: Binding(
                                        get: {
                                            if index < viewModel.stopPoints.count {
                                                return viewModel.stopPoints[index]
                                            } else {
                                                return ""
                                            }
                                        },
                                        set: { newValue in
                                            if index < viewModel.stopPoints.count {
                                                viewModel.stopPoints[index] = newValue
                                            } else {
                                                stopPoint = newValue
                                            }
                                        }
                                    )
                                )
                                .frame(minHeight: 50)
                                .padding(.horizontal, 16)
                                .background {
                                    Color.neutralN400
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            if !stopPoint.isEmpty {
                                viewModel.stopPoints.append(stopPoint)
                                stopPoint = ""
                            }
                        }, label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundStyle(.white)
                                .padding(10)
                                .background {
                                    Color.primary200
                                        .clipShape(.circle)
                                }
                        })
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if !viewModel.selectLoad.isEmpty && !viewModel.stopPoints.isEmpty && !viewModel.derparturePoint.isEmpty {
                            viewModel.stopPoints.append(stopPoint)
                            IAController().sendNewMessage(departure: viewModel.derparturePoint,
                                                          content: viewModel.stopPoints)
                            navigateToMap = true
                        }
                    }, label: {
                        Text("Iniciar Viagem")
                            .font(.custom(TokenFont.semibold.rawValue, size: 14))
                            .foregroundStyle(.white)
                            .frame(height: 48)
                            .frame(maxWidth: 345)
                            .background {
                                (!viewModel.selectLoad.isEmpty && !viewModel.stopPoints.isEmpty && !viewModel.derparturePoint.isEmpty) ?
                                Color.primary500
                                    .clipShape(.rect(cornerRadius: 8))
                                : Color.inactivated
                                    .clipShape(.rect(cornerRadius: 8))
                            }
                    }).frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .padding(.top, 32)
                .padding(.horizontal, 24)
            }
            .sheet(isPresented: $navigateToMap, content: {
                NavigationView(navigation: Navigation(), addresses: ["Rua Bismarck 323, Parangaba, Fortaleza-CE", "Rua Jose Villar 3333, Fortaleza-CE"], departure:  "Rua Suíça 120, Maraponga, Fortaleza - CE")
            })
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                    .font(.custom(TokenFont.regular.rawValue, size: 16))
                    .foregroundStyle(Color.primary200)
                }
            }
            .toolbarBackground(Color.neutral700)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitle("Criar entrega", displayMode: .inline)
        }
    }
}

#Preview {
    CreateRouteSheet(viewModel: .init())
}


enum Loads: String, CaseIterable {
    case none = "Adicionar Carga"
    case load = "carga-112321.pdf"
}
