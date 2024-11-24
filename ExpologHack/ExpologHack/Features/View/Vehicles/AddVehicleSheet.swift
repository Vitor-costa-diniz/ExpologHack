//
//  AddVehicleSheet.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct AddVehicleSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectVehicleType: VehicleType = .truck
    @State private var vehiclePlate: String = ""
    @State private var height: String = ""
    @State private var length: String = ""
    @State private var width: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.neutral600
                    .ignoresSafeArea()
                
                VStack {
                    formVehicle
                        .onChange(of: vehiclePlate) { value in
                            if vehiclePlate.count > 6 {
                                vehiclePlate.removeLast()
                            }
                        }
                        .onChange(of: height) { value in
                            if height.count > 6 {
                                height.removeLast()
                            }
                        }
                        .onChange(of: length) { value in
                            if length.count > 6 {
                                length.removeLast()
                            }
                        }
                        .onChange(of: width) { value in
                            if width.count > 6 {
                                width.removeLast()
                            }
                        }
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
    
    private var formVehicle: some View {
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
                        Picker("", selection: $selectVehicleType) {
                            Text(VehicleType.truck.rawValue).tag(VehicleType.truck)
                                .foregroundStyle(Color.secondary)
                            Text(VehicleType.car.rawValue).tag(VehicleType.car)
                        }
                    case .plate:
                        TextField(text: $vehiclePlate) {
                            Text("000000")
                                .foregroundStyle(Color.secondary)
                        }
                        .frame(width: 60)
                    case .loadCapacity:
                        Text("Inserir")
                        Image(.arrowRightBold)
                            .padding(.top, 2.4)
                    case .height:
                        TextField(text: $height) {
                            Text("0")
                                .foregroundStyle(Color.secondary)
                        }
                        .keyboardType(.decimalPad)
                        .frame(width: height.count == 0 ? 9 : CGFloat(height.count) * 9)
                        .padding(.trailing, -5)
                        Text("m")
                        
                    case .length:
                        TextField(text: $length) {
                            Text("0")
                                .foregroundStyle(Color.secondary)
                        }
                        .keyboardType(.decimalPad)
                        .frame(width: height.count == 0 ? 9 : CGFloat(height.count) * 9)
                        .padding(.trailing, -5)
                        Text("m")
                        
                    case .width:
                        TextField(text: $width) {
                            Text("0")
                                .foregroundStyle(Color.secondary)
                        }
                        .keyboardType(.decimalPad)
                        .frame(width: height.count == 0 ? 9 : CGFloat(height.count) * 9)
                        .padding(.trailing, -5)
                        Text("m")
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
        
    }
}

#Preview {
    AddVehicleSheet()
}
