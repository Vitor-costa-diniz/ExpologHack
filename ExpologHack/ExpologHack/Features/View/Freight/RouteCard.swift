//
//  RouteCard.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct RouteCard: View {
    var body: some View {
        GeometryReader { geo in
            let screenProportion = geo.size.width / geo.size.height
            
            VStack {
                HStack(alignment: .top) {
                    Image(.miniTruck)
                        .background(
                            Circle()
                                .frame(width: 52, height: 52)
                                .foregroundStyle(Color.primary200)
                        )
                        .padding(.leading, 8)
                        .padding(.trailing, 16)
                        .padding(.top, 7)
                    
                    VStack(alignment: .leading) {
                        Text("Duração: 1d 22hrs")
                            .font(.custom(TokenFont.medium.rawValue, size: 14))
                        
                        Text("Frete #38422")
                            .font(.custom(TokenFont.medium.rawValue, size: 20))
                            .monospacedDigit()
                    }
                    
                    Spacer()
                    
                    Text("2932km")
                        .font(.custom(TokenFont.semibold.rawValue, size: 14))
                        .frame(width: 60, height: 20)
                        .padding(.horizontal, 5)
                        .background(
                            Rectangle()
                                .foregroundStyle(Color.primary200)
                                .clipShape(.rect(cornerRadius: 28))
                        )
                        .padding(.trailing, 12)
                }
                
                trainProgress
                    .frame(height: geo.size.height < 121 ? 20 : 30)
                
                HStack {
                    Text("Partida: Fortaleza, CE")
                    
                    Spacer()
                    
                    Text("Chegada: São Paulo, SP")
                }
                .font(.custom(TokenFont.regular.rawValue, size: 12))
            }
            .padding(.top, geo.size.height < 121 ? 6 : screenProportion * 7.4)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: 335)
        .frame(height: 140)
        .background(
            Color.cardBackground
                .clipShape(.rect(cornerRadius: 16))
        )
    }
    
    private var trainProgress: some View {
        ZStack(alignment: .leading) {
            Line()
                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: CGLineCap.round, dash: [10.4]))
                .foregroundStyle(.gray.opacity(0.4))
                .frame(height: 1)
            
            Line()
                .stroke(lineWidth: 4)
                .foregroundStyle(Color.primary200)
                .frame(width: 286, height: 1)
            
            HStack {
                Circle()
                    .stroke(Color.primary200, style: StrokeStyle(lineWidth: 5))
                    .background(Circle().fill(.white))
                    .frame(width: 14, height: 15)
                
                Spacer()
                
                Circle()
                    .stroke(Color.primary200, style: StrokeStyle(lineWidth: 5))
                    .background(Circle().fill(.white))
                    .frame(width: 14, height: 15)
            }
        }
    }
    
}

#Preview {
    RouteCard()
}


struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
