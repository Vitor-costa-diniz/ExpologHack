//
//  AddVehicleSheet.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct VehicleSheet: View {
    @EnvironmentObject private var viewModel: VehicleViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showNameSheet: Bool = false
    @State private var showCapacitySheet: Bool = false
    @State private var showSpecsSheet: Bool = false
    @State private var temporaryName: String?
    @State private var temporaryCapacity: String?
    @State private var temporarySpecs: String?
    var isAdd: Bool
    
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
                        .sheet(isPresented: $showCapacitySheet, content: {
                            AddLoadCapacitySheet(showSheet: $showCapacitySheet, capacity: $temporaryCapacity)
                        })
                        .sheet(isPresented: $showSpecsSheet, content: {
                            SpecsSheet(showSheet: $showSpecsSheet, specs: $temporarySpecs)
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
                                Button(isAdd ? "Adicionar" : "Salvar") {
                                    if viewModel.arePropertiesValid() && temporaryName != nil {
                                        viewModel.name = temporaryName
                                        viewModel.capacity = temporaryCapacity
                                        viewModel.specs = temporarySpecs
                                        if isAdd {
                                            viewModel.createVehicle()
                                        } else {
                                            viewModel.updateVehicle()
                                        }
                                        dismiss()
                                    }
                                }
                                .font(.custom(TokenFont.bold.rawValue, size: 16))
                                .foregroundStyle(viewModel.arePropertiesValid() && temporaryName != nil ?
                                    Color.primary200 :
                                    Color.neutral400)
                            }
                        }
                        .toolbarBackground(Color.neutral700)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .navigationBarTitle("Adicionar veículo", displayMode: .inline)
                        .onAppear {
                            if !isAdd {
                                viewModel.loadFirstVehicle()
                            }
                            temporaryName = viewModel.name
                            temporaryCapacity = viewModel.capacity
                            temporarySpecs = viewModel.specs
                        }
                        .onDisappear {
                            temporaryName = nil
                            temporaryCapacity = nil
                            temporarySpecs = nil
                        }
                }
            }
        }
    }
    
    private var formVehicle: some View {
        List {
            ActionListRow(title: "Nome do motorista") {
                Text("\(temporaryName ?? "Inserir")")
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
                            Text("0000000")
                                .foregroundStyle(Color.secondary)
                        }
                        .frame(width: 70)
                        
                    case .loadCapacity:
                        HStack {
                            Text("\(temporaryCapacity ?? "Inserir")")
                            Image(.arrowRightBold)
                                .padding(.top, 2.4)
                        }
                        .onTapGesture {
                            showCapacitySheet.toggle()
                        }
                        
                    case .height:
                        TextField(text: $viewModel.height) {
                            Text("0")
                                .foregroundStyle(Color.secondary)
                        }
                        .keyboardType(.decimalPad)
                        .frame(width: viewModel.height.count == 0 ? 12 : CGFloat(viewModel.height.count) * 12)
                        .padding(.trailing, -5)
                        Text("m")
                        
                    case .length:
                        TextField(text: $viewModel.length) {
                            Text("0")
                                .foregroundStyle(Color.secondary)
                        }
                        .keyboardType(.decimalPad)
                        .frame(width: viewModel.length.count == 0 ? 10 : CGFloat(viewModel.length.count) * 10)
                        .padding(.trailing, -5)
                        Text("m")
                        
                    case .width:
                        TextField(text: $viewModel.width) {
                            Text("0")
                                .foregroundStyle(Color.secondary)
                        }
                        .keyboardType(.decimalPad)
                        .frame(width: viewModel.width.count == 0 ? 10 : CGFloat(viewModel.width.count) * 10)
                        .padding(.trailing, -5)
                        Text("m")
                    }
                }
                .font(.custom(TokenFont.regular.rawValue, size: 16))
                .foregroundStyle(Color.secondary)
            }
            
            ActionListRow(title: "Descrição") {
                Text("\(temporarySpecs ?? "Nenhuma")")
                    .foregroundStyle(Color.secondary)
                    .font(.custom(TokenFont.regular.rawValue, size: 16))
                Image(.arrowRightBold)
                    .padding(.top, 2.4)
            } action: {
                showSpecsSheet.toggle()
            }
        }
        .scrollDisabled(true)
        .listStyle(DefaultListStyle())
        .scrollContentBackground(.hidden)
        .onChange(of: viewModel.vehiclePlate) { value in
            if viewModel.vehiclePlate.count > 7 {
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
    VehicleSheet(isAdd: true)
        .environmentObject(VehicleViewModel())
}
