//
//  AddAddressInfo.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 23/11/24.
//

import Foundation


import SwiftUI

struct RoutePlannerView: View {
    @State private var departure: String = ""
    @State private var addresses: [String] = [""] // Inicializa com um endereço
    @State private var vehicleModel: String = ""
    @State private var routeMessage: String = ""
    @State private var navigateToMap = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Ponto de Partida")) {
                    AddressInputView(address: $departure)
                }
                
                Section(header: Text("Pontos de Parada")) {
                    // Exibe os campos de endereço de parada
                    ForEach(0..<addresses.count, id: \.self) { index in
                        AddressInputView(address: $addresses[index])
                    }
                    
                    HStack {
                        Button(action: addAddress) {
                            Text("Adicionar Ponto de Parada")
                                .foregroundColor(.blue)
                        }
                        .disabled(addresses.count >= 10) // Desabilita o botão se houver 10 endereços
                        
                        Button(action: removeAddress) {
                            Text("Remover Ponto de Parada")
                                .foregroundColor(.red)
                        }
                        .disabled(addresses.count <= 1) // Desabilita o botão se houver apenas 1 endereço
                    }
                }
                
                Section(header: Text("Modelo do Veículo")) {
                    TextField("Digite o modelo do veículo", text: $vehicleModel)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button(action: {
                    calculateRoute()
                    navigateToMap = true
                }) {
                    Text("Calcular Rota")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Section(header: Text("Mensagem da Rota")) {
                    Text(routeMessage)
                        .multilineTextAlignment(.leading)
                        .padding()
                }
            }
            .navigationBarTitle("Planejamento de Rota")
            .background(
                NavigationLink(destination: NavigationViewControllerRepresentable(departure: departure, addresses: addresses), isActive: $navigateToMap) {
                    EmptyView()
                }
            )
        }
    }
    
    private func addAddress() {
        if addresses.count < 10 {
            addresses.append("")
        }
    }
    
    private func removeAddress() {
        if addresses.count > 1 {
            addresses.removeLast()
        }
    }
    
    private func shareRoute() {
        let pdfData = generatePDF()
        
        let activityController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityController, animated: true)
    }
    
    private func generatePDF() -> Data {
        let pdfMetaData: [String: Any] = [
            "Creator": "Route Planner App",
            "Author": "Your Company",
            "Title": "Rota Planejada"
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData
        
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 595, height: 842), format: format)
        
        let data = renderer.pdfData { context in
            context.beginPage()
            
            let text = "Local de Partida: \(departure)\nPontos de Parada: \(addresses.joined(separator: ", "))\nVeículo: \(vehicleModel)\n\nAqui estarão os dados adicionais no futuro."
            let textRect = CGRect(x: 10, y: 10, width: 580, height: 100)
            text.draw(in: textRect, withAttributes: [.font: UIFont.systemFont(ofSize: 12)])
            
            if let routeImage = captureMapImage() {
                context.cgContext.draw(routeImage.cgImage!, in: CGRect(x: 10, y: 120, width: 580, height: 300))
            }
        }
        
        return data
    }
    
    private func captureMapImage() -> UIImage? {
        return UIImage(named: "routeSnapshot") // Exemplo de imagem fixa
    }
    
    private func calculateRoute() {
        let allAddresses = [departure] + addresses.filter { !$0.isEmpty }
        
        // Gerar a string conforme solicitado
        routeMessage = "Tento o ponto de partida \(allAddresses.first ?? "") e os pontos de parada \(allAddresses.dropFirst().joined(separator: ", ")), e sabendo que o veículo \(vehicleModel) será utilizado, calcule a distância total a ser percorrida, o tempo médio para executar a rota, qual será o gasto de combustível baseado no Veículo citado, qual a emissão total de CO2 nessa rota, você deve fazer isso para três opções de rota, a que gera o menor custo de combustível, a mais rápida e a que gera a menor pegada de carbono."
        
        // Aqui você pode adicionar a lógica para calcular a distância, tempo, custo de combustível e emissões
    }
}


import SwiftUI

struct AddressInputView: View {
    @Binding var address: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Endereço")
                .font(.headline)
            TextField("Digite o endereço", text: $address)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

