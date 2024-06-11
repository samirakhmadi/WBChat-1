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
        VStack(spacing: isSelected ? 12 : 0){
            if !isSelected {
                Image(tab.icon)
                    .scaleEffect(!isSelected ? 1.3 : 1)
            } else {
                VStack {
                    Text(tab.title)
                        .font(.system(size: 14).weight(.semibold))
                    Text("\u{2022}")
                }
            }
        }
        .foregroundStyle(foregroundColor)
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
            VStack(spacing: 20){
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

