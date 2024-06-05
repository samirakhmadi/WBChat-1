//
//  Extension+HStack.swift
//  WBChat
//
//  Created by Александр on 05.06.2024.
//

import SwiftUI

extension HStack {
    init(alignment: VerticalAlignment = .center, @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: 0, content: content)
    }
}

