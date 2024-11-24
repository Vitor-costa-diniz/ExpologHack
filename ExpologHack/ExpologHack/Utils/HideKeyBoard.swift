//
//  HideKeyBoard.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 23/11/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
