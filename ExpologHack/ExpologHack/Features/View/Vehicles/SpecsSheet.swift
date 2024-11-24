//
//  SpecsSheet.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct SpecsSheet: View {
    @Binding var showSheet: Bool
    @Binding var specs: String?
    @State private var specsMock: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.neutral600
                    .ignoresSafeArea()
                
                VStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 200)
                        .foregroundStyle(.surfContainer)
                        .overlay {
                            ZStack(alignment: .topLeading) {
                                Text("Especificidades")
                                    .offset(x: 16.0, y: 10.0)
                                    .foregroundStyle(Color.secondary)
                                    .opacity(specsMock != "" ? 0 : 1)
                                TextEditor(text: $specsMock)
                                    .scrollContentBackground(.hidden)
                                    .padding(.leading, 12)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    Spacer()
                }
            }
            .onAppear {
                specsMock = specs ?? ""
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        showSheet.toggle()
                        specsMock = ""
                    }
                    .font(.custom(TokenFont.regular.rawValue, size: 16))
                    .foregroundStyle(Color.primary200)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Concluido") {
                        showSheet = false
                        specs = specsMock
                    }
                    .font(.custom(TokenFont.regular.rawValue, size: 16))
                    .foregroundStyle(specsMock.isEmpty ? Color.neutral400 : Color.primary200)
                    .disabled(specsMock.isEmpty)
                }
            }
            .toolbarBackground(Color.neutral700)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitle("Especificidades", displayMode: .inline)
        }
    }
}

#Preview {
    SpecsSheet(showSheet: .constant(true), specs: .constant(""))
}
