//
//  AddVehicleSheet.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct AddVehicleSheet: View {
    @EnvironmentObject private var viewModel: VehicleViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showNameSheet: Bool = false
    @State private var temporaryName: String?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.neutral600
                    .ignoresSafeArea()
                
                VStack {
                    formVehicle
                        .sheet(isPresented: $showNameSheet, content: {
                            NameSheet(showSheet: $showNameSheet, name: $temporaryName)
                        })
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
                                    viewModel.name = temporaryName
                                    dismiss()
                                }
                                .font(.custom(TokenFont.bold.rawValue, size: 16))
                                .foregroundStyle(Color.neutral400)
                            }
                        }
                        .toolbarBackground(Color.neutral700)
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
                showNameSheet.toggle()
            }
            
            ForEach(VehicleComponentTitle.allCases, id: \.self) { result in
                ListRow(title: result.rawValue) {
                    switch result {
                    case .vehicleType:
                        Picker("", selection: $viewModel.selectVehicleType) {
                            Text(VehicleType.truck.rawValue).tag(VehicleType.truck)
                                .foregroundStyle(Color.secondary)
                            Text(VehicleType.car.rawValue).tag(VehicleType.car)
                        }
                        .tint(Color.gray)
                        
                    case .plate:
                        TextField(text: $viewModel.vehiclePlate) {
                            Text("000000")
                                .foregroundStyle(Color.secondary)
                        }
                        .frame(width: 60)
                        
                    case .loadCapacity:
                        Text("Inserir")
                        Image(.arrowRightBold)
                            .padding(.top, 2.4)
                        
                    case .height:
                        TextField(text: $viewModel.height) {
                            Text("0")
                                .foregroundStyle(Color.secondary)
                        }
                        .keyboardType(.decimalPad)
                        .frame(width: viewModel.height.count == 0 ? 9 : CGFloat(viewModel.height.count) * 9)
                        .padding(.trailing, -5)
                        Text("m")
                        
                    case .length:
                        TextField(text: $viewModel.length) {
                            Text("0")
                                .foregroundStyle(Color.secondary)
                        }
                        .keyboardType(.decimalPad)
                        .frame(width: viewModel.length.count == 0 ? 9 : CGFloat(viewModel.length.count) * 9)
                        .padding(.trailing, -5)
                        Text("m")
                        
                    case .width:
                        TextField(text: $viewModel.width) {
                            Text("0")
                                .foregroundStyle(Color.secondary)
                        }
                        .keyboardType(.decimalPad)
                        .frame(width: viewModel.width.count == 0 ? 9 : CGFloat(viewModel.width.count) * 9)
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
        .onChange(of: viewModel.vehiclePlate) { value in
            if viewModel.vehiclePlate.count > 6 {
                viewModel.vehiclePlate.removeLast()
            }
        }
        .onChange(of: viewModel.height) { value in
            if viewModel.height.count > 6 {
                viewModel.height.removeLast()
            }
        }
        .onChange(of: viewModel.length) { value in
            if viewModel.length.count > 6 {
                viewModel.length.removeLast()
            }
        }
        .onChange(of: viewModel.width) { value in
            if viewModel.width.count > 6 {
                viewModel.width.removeLast()
            }
        }
    }
}

#Preview {
    AddVehicleSheet()
        .environmentObject(VehicleViewModel())
}
