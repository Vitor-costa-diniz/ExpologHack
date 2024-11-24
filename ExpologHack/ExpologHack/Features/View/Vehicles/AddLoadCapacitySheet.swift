//
//  AddLoadCapacitySheet.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct AddLoadCapacitySheet: View {
    @Binding var showSheet: Bool
    @Binding var capacity: String?
    @State private var capacityMock: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.neutral600
                    .ignoresSafeArea()
                
                VStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 50)
                        .foregroundStyle(.surfContainer)
                        .overlay {
                            TextField("Capacidade de carga", text: $capacityMock)
                            .keyboardType(.alphabet)
                            .padding(.leading)
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 16)
                    Spacer()
                }
            }
            .onAppear {
                capacityMock = capacity ?? ""
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        showSheet.toggle()
                        capacityMock = ""
                    }
                    .font(.custom(TokenFont.regular.rawValue, size: 16))
                    .foregroundStyle(Color.primary200)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Concluido") {
                        showSheet = false
                        capacity = capacityMock
                    }
                    .font(.custom(TokenFont.regular.rawValue, size: 16))
                    .foregroundStyle(capacityMock.isEmpty ? Color.neutral400 : Color.primary200)
                    .disabled(capacityMock.isEmpty)
                }
            }
            .toolbarBackground(Color.neutral700)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitle("Capacidade", displayMode: .inline)
        }
    }
}

#Preview {
    AddLoadCapacitySheet(showSheet: .constant(true), capacity: .constant(""))
}
