//
//  MealsView_SearchView.swift
//  WBChat
//
//  Created by Александр on 11.08.2024.
//

import SwiftUI

struct MealsView_SearchView: View {
    @State private var isExpanded = false
    @Binding var searchQuery: String
    
    var body: some View {
        HStack(spacing: 20) {
            textField
            searchButton
        }
        .frame(maxWidth: .infinity)
        .animation(.easeInOut(duration: 0.3), value: isExpanded)
    }
}

private extension MealsView_SearchView {
    var textField: some View {
        TextField("Search...", text: $searchQuery)
            .tint(.brand)
            .foregroundStyle(.neutralText)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(.neutralText, lineWidth: 1))
            .offset(x: isExpanded ? 0 : 500)
            .transition(.move(edge: .trailing))
            .animation(.easeInOut(duration: 0.8), value: isExpanded)
    }
    var searchButton: some View {
        Button {
            withAnimation {
                isExpanded.toggle()
            }
        } label: {
            Image(systemName: isExpanded ? "xmark.circle.fill" : "magnifyingglass")
                .font(.headline)
                .foregroundColor(.neutral)
                .padding()
                .background(.brand)
                .clipShape(Circle())
                .rotationEffect(.degrees(isExpanded ? 0 : 360))
        }
    }
}

#Preview {
    MealsView_SearchView(searchQuery: .constant("Beef"))
        .padding(.horizontal)
}
