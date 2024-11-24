//
//  NameSheet.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct NameSheet: View {
    @Binding var showSheet: Bool
    @Binding var name: String?
    @State private var nameMock: String = ""
    
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
                            TextField("Nome da medição", text: $nameMock)
                            .keyboardType(.alphabet)
                            .padding(.leading)
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 16)
                    Spacer()
                }
            }
            .onAppear {
                nameMock = name ?? ""
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        showSheet.toggle()
                        nameMock = ""
                    }
                    .font(.custom(TokenFont.regular.rawValue, size: 16))
                    .foregroundStyle(Color.primary200)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Concluido") {
                        showSheet = false
                        name = nameMock
                    }
                    .font(.custom(TokenFont.regular.rawValue, size: 16))
                    .foregroundStyle(nameMock.isEmpty ? Color.neutral400 : Color.primary200)
                    .disabled(nameMock.isEmpty)
                }
            }
            .toolbarBackground(Color.neutral700)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitle("Nome", displayMode: .inline)
        }
    }
}

#Preview {
    NameSheet(showSheet: .constant(true), name: .constant(""))
}
