//
//  SearchBar.swift
//  WBChat
//
//  Created by Samir on 10.08.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var defaultText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .modifier(IconStyleSearchField())
                .foregroundColor(searchText.isEmpty ? Color("grayColor") : Color("textFieldTextColor"))
                .padding(8)
            
            TextField(defaultText, text: $searchText)
                .modifier(BodyText1())
                .foregroundColor(Color("textFieldTextColor"))
                .frame(height: 36)
        }
        .background(Color("searchTextField"))
        .cornerRadius(5)
    }
}

#Preview {
    SearchBar(searchText: .constant(""), defaultText: "Search")
}



