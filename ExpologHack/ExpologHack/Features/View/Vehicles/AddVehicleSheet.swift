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
            Color.neutral600
                .ignoresSafeArea()
            
            VStack {
                
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

#Preview {
    AddVehicleSheet()
}
