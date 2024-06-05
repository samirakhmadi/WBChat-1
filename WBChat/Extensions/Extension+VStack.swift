//
//  Extension+VStack.swift
//  WBChat
//
//  Created by Александр on 05.06.2024.
//

import SwiftUI

extension VStack {
    init(alignment: HorizontalAlignment = .center, @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: 0, content: content)
    }
}
