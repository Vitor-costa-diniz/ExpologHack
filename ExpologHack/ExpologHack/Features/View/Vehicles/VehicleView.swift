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
        VStack {
            HStack {
                Text("Veículo")
                Spacer()
                if viewModel.vehicles.isEmpty {
                    Button(action: { viewModel.createVehicle(vehicle: ["Palhio"])}, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .padding(.horizontal, 16)
            
            VStack {
                if !$viewModel.vehicles.isEmpty {
                    List {
                        ForEach(viewModel.vehicles) { item in
                            Section {
                                Text(item.name!)
                                Text(item.loadCapacity!)
                                Text(item.plate!)
                                Text(item.type!)
                            }
                        }
                    }
                } else {
                    HStack {
                        VStack(alignment: .center) {
                            Spacer()
                            Text("Adicione um novo Frete clicando em +")
                                .fontWeight(.regular)
                                .font(.system(size: 15))
                            Spacer()
                        }
                    }
                    
                }
            }
            
            Spacer()
            
            Button(action: {}, label: {
                Text("Novo frete")
                    .foregroundStyle(.white)
                    .padding()
                    .background {
                        Color.red
                    }
            })
        }
    }
}

#Preview {
    VehicleView(viewModel: .init())
}
