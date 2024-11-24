//
//  FreightModel.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct FreightUpdate: Identifiable {
    let id: UUID
    let iconName: Image
    let status: String
    let location: String
    let updateTime: String
    let isActive: Bool
    
    static let mockData = [
        FreightUpdate(
            id: UUID(),
            iconName: Image(.elipseIcon),
            status: "Chegada ao destino final",
            location: "Entrega feita em São Paulo, SP",
            updateTime: "24/11/24, 17:55",
            isActive: true
        ),
        FreightUpdate(
            id: UUID(),
            iconName: Image(.elipseIcon),
            status: "Em trânsito para entrega",
            location: "Carga em São Paulo, SP",
            updateTime: "24/11/24, 15:29",
            isActive: false
        ),
        FreightUpdate(
            id: UUID(),
            iconName: Image(.elipseIcon),
            status: "Atualização de frete",
            location: "Carga em São Paulo, SP",
            updateTime: "24/11/24, 13:42",
            isActive: false
        ),
        FreightUpdate(
            id: UUID(),
            iconName: Image(.elipseIcon),
            status: "Atualização de frete",
            location: "Carga em Contagem, MG",
            updateTime: "23/11/24, 13:42",
            isActive: false
        ),
        FreightUpdate(
            id: UUID(),
            iconName: Image(.elipseIcon),
            status: "Atualização de frete",
            location: "Carga em Fortaleza, CE",
            updateTime: "22/11/24, 20:33",
            isActive: false
        ),
        FreightUpdate(
            id: UUID(),
            iconName: Image(.elipseIcon),
            status: "Início da viagem",
            location: "Carga em Fortaleza, CE",
            updateTime: "22/11/24, 18:21",
            isActive: false
        )
    ]
}
