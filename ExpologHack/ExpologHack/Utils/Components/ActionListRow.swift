//
//  ActionListRow.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct ActionListRow<Content: View>: View {
    
    typealias Action = () -> Void
    let title: String
    let content: Content
    let action: Action
    
    init(title: String, @ViewBuilder content: () -> Content, action: @escaping Action) {
        self.title = title
        self.content = content()
        self.action = action
    }
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color.inverse)
            Spacer()
            content
        }
        .contentShape(Rectangle())
        .listRowBackground(Color.neutral800)
        .onTapGesture(perform: action)
    }
}

#Preview {
    ActionListRow(title: "Teste") {
        Text("Ola")
    } action: {}
}
