//
//  NewVehicleView.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 23/11/24.
//


import SwiftUI
import Combine

struct NewFreightView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name: String = ""
    @State private var packageCode: String = ""
    @State private var showingAlert = false
    @State private var showingModal = false
    @State private var searchText: String = ""
    @State private var checked: Bool = false
    @State var packages: [Package] = []
    
    public var packageViewModel: PackageViewModel
    var freightViewModel: FreightViewModel
    
    var body: some View {
        VStack {
            VStack {
                    InputView(text: $name, title: "Nome", placeholder: "Nome do frete")
                    InputView(text: $packageCode, title: "Código da carga", placeholder: "Adicione o código")
            }.foregroundColor(.black)
            Spacer()
        }
        .navigationBarTitle("Novo Frete", displayMode: .inline)
        .navigationBarItems(trailing: trailingButton)
    }

    var trailingButton: some View {
        Button("Salvar") {
            if name.count > 0 {
                self.presentationMode.wrappedValue.dismiss()
                freightViewModel.createfreight(model: name, packages: packageViewModel.createPackage(packages: [packageCode]))
            } else {
                showingAlert = true
            }
        }
        
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Olá"), message: Text("Parece que você esqueceu de dar um nome ao Frete"), dismissButton: .default(Text("OK")))
        }
    }
}

