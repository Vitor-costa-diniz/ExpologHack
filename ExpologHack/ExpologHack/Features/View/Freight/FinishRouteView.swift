//
//  FinishRouteView.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct FinishRouteView: View {
    var body: some View {
        ZStack {
            Color.neutral600
                .ignoresSafeArea()
            
            VStack(spacing: 8) {
                Image(.lookBlank)
                    .padding(.bottom, 8)
                
                Text("Entrega completa com sucesso!")
                    .font(.custom(TokenFont.semibold.rawValue, size: 20))
                    .foregroundStyle(.white)
                
                Text("Esperamos que tenhamos sido de ajuda para sua viagem. Não esqueça de gerar um relatório nos detalhes da viagem")
                    .font(.custom(TokenFont.medium.rawValue, size: 16))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 32)
                
                Button(action: {}) {
                    Text("Voltar ao início")
                        .font(.custom(TokenFont.semibold.rawValue, size: 14))
                        .foregroundStyle(.white)
                        .frame(height: 48)
                        .frame(maxWidth: 345)
                        .background {
                            Color.primary500
                                .clipShape(.rect(cornerRadius: 8))
                        }
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    FinishRouteView()
}
