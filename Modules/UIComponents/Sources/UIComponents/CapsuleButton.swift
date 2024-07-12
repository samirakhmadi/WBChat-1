//
//  CapsuleButton.swift
//
//
//  Created by Александр on 11.07.2024.
//

import SwiftUI

public struct CapsuleButton: View {
    
    var title: LocalizedStringKey
    var localizationTableName: String
    
    var activeColor: Color
    var disabledColor: Color
    var isDisabled: Bool
    
    var action: () -> Void
    
    public init(
        title: LocalizedStringKey,
        localizationTableName: String,
        activeColor: Color,
        disabledColor: Color,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.localizationTableName = localizationTableName
        self.activeColor = activeColor
        self.disabledColor = disabledColor
        self.isDisabled = isDisabled
        self.action = action
    }
    
    public var body: some View {
        Button { action() }
    label: {
        Text(title, tableName: localizationTableName)
            .font(.system(size: 16).weight(.semibold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 98.5)
            .frame(height: 52)
            .background(
                Capsule()
                    .fill(isDisabled ? disabledColor : activeColor)
            )
            .foregroundStyle(.white)
    }
    .disabled(isDisabled)
    .animation(.easeInOut, value: isDisabled)
    }
}

#Preview {
    CapsuleButton(title: "Some Title", localizationTableName: "Some Table", activeColor: .red, disabledColor: .red.opacity(0.5), action: {})
}

