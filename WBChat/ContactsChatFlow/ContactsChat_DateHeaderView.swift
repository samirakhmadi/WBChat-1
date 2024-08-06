//
//  ContactsChat_DateHeaderView.swift
//  WBChat
//
//  Created by Александр on 06.08.2024.
//

import SwiftUI

struct ContactsChat_DateHeaderView: View {
    let date: Date
    var body: some View {
        HStack(spacing: 16) {
            Rectangle()
                .frame(height: 1)
            Text(date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)).uppercased())
            Rectangle()
                .frame(height: 1)
        }
        .foregroundStyle(.chatDividerLine)
        .padding(.horizontal, 16)
//        .padding(.bottom, 12)
    }
}

#Preview {
    ContactsChat_DateHeaderView(date: .now)
}
