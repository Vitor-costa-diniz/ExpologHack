//
//  PackageInfoView.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 23/11/24.
//

import SwiftUI

struct PackageInfoView: View {
    
    @State var package: Package
    @ObservedObject var packageViewModel: PackageViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Description(title: "Nome", info: package.name ?? "Não há um número 1")
                Description(title: "Destino", info: package.destiny ?? "Não há um número 1")
                Description(title: "Local de partida", info: package.location ?? "Não há um email")
                Description(title: "Quantidade", info: String(package.amount ?? "Não a valor"))
                Spacer()
            }
            
            Spacer()
        }.navigationTitle(package.name ?? "Sem nome")
            .padding(.leading, 20)
    }
}
