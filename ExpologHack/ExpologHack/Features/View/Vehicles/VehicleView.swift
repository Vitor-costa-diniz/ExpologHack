//
//  VehicleView.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct VehicleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Veículo")
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "plus")
                })
            }
            .padding(.horizontal)
            
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
    VehicleView()
}
