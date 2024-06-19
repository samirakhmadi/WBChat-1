//
//  CustomTabView_TabItem.swift
//  WBChat
//
//  Created by Александр on 11.06.2024.
//

import SwiftUI

struct CustomTabView_TabItem: View {
    var tab: Tab
    var foregroundColor: Color
    var isSelected: Bool
    @Binding var activeTab: Tab
    var body: some View {
        Image(tab.icon)
            .foregroundStyle(isSelected ? .brand :foregroundColor)
            .padding(.top, 12)
            .padding(.bottom, 5)
            .onTapGesture {
                withAnimation(.spring(
                    response: 0.7,
                    dampingFraction: 0.8)
                ) {
                    activeTab = tab
                }
            }
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    struct BindingViewPreviewContainer : View {
        @State private var activeTab: Tab = .contacts
        
        var body: some View {
            HStack(spacing: 20){
                ForEach(Tab.allCases) { tab in
                    CustomTabView_TabItem(
                        tab: tab,
                        foregroundColor: .red,
                        isSelected: activeTab == tab,
                        activeTab: $activeTab
                    )
                }
            }
        }
    }
    return BindingViewPreviewContainer()
}

