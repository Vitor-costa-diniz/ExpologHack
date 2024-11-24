//
//  ListRow.swift
//  ExpologHack
//
//  Created by Vitor Costa on 24/11/24.
//

import SwiftUI

struct ListRow<Content: View>: View {

    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
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
    }
}

#Preview {
    ListRow(title: "Nome") {
        Text("Test")
            .foregroundColor(.gray)
    }
}
