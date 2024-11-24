//
//  AddVehicleSheet.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct AddVehicleSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.neutral600
                    .ignoresSafeArea()
                
                VStack {
                    List {
                        ActionListRow(title: "Nome do motorista") {
                            Text("Inserir")
                                .font(.custom(TokenFont.regular.rawValue, size: 16))
                                .foregroundStyle(Color.secondary)
                            Image(.arrowRightBold)
                                .padding(.top, 2.4)
                        } action: {
                            
                        }
                        
                        ForEach(VehicleComponentTitle.allCases, id: \.self) { result in
                            ListRow(title: result.rawValue) {
                                switch result {
                                case .vehicleType:
                                    Text("Inserir")
                                case .plate:
                                    Text("Teste")
                                case .loadCapacity:
                                    Text("Inserir")
                                    Image(.arrowRightBold)
                                        .padding(.top, 2.4)
                                case .height:
                                    Text("0m")
                                case .length:
                                    Text("0m")
                                case .width:
                                    Text("0m")
                                }
                            }
                            .font(.custom(TokenFont.regular.rawValue, size: 16))
                            .foregroundStyle(Color.secondary)
                        }
                        
                        ActionListRow(title: "Especificidades") {
                            Text("Nenhuma")
                                .foregroundStyle(Color.secondary)
                                .font(.custom(TokenFont.regular.rawValue, size: 16))
                            Image(.arrowRightBold)
                                .padding(.top, 2.4)
                        } action: {
                            
                        }
                    }
                    .scrollDisabled(true)
                    .listStyle(DefaultListStyle())

                    .scrollContentBackground(.hidden)
                    
                    .toolbar {
                        ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                            Button("Cancelar") {
                                dismiss()
                            }
                            .font(.custom(TokenFont.regular.rawValue, size: 16))
                            .foregroundStyle(Color.primary200)
                        }
                        
                        ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                            Button("Adicionar") {
                                dismiss()
                            }
                            .font(.custom(TokenFont.bold.rawValue, size: 16))
                            .foregroundStyle(Color.neutral400)
                        }
                    }
                    .toolbarBackground(Color.neutral500)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .navigationBarTitle("Adicionar veículo", displayMode: .inline)
                    
                }
            }
        }
    }
}

#Preview {
    AddVehicleSheet()
}
