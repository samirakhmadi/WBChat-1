//
//  ContactsView.swift
//  WBChat
//
//  Created by Александр on 07.06.2024.
//

import SwiftUI

struct ContactsView: View {
    
    @State private  var searchText: String = ""

    var body: some View {
        List(Contact.contacts.indices, id: \.self) { index in ContactsView_ContactRow(contact: Contact.contacts[index])
                .listRowSeparator(.hidden, edges: .all)
                .listRowBackground(ViewBackgroundColor())
                .listRowInsets(
                    .init(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: 0)
                )
                .padding(.top, index != 0 ? 16 : 0)
                .padding(.horizontal, 24)
        }
        .listStyle(.plain)
        .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .automatic)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ViewBackgroundColor())
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                viewTitle
            }
            ToolbarItem(placement: .topBarTrailing) {
                addButton
            }
        }
        .navigationBarBackButtonHidden()
    }
}

private extension ContactsView {
    var viewTitle: some View {
        Text("Контакты")
            .font(.system(size: 18).weight(.semibold))
            .foregroundStyle(.neutralText)
    }
    
    var addButton: some View {
        Button("", systemImage: "plus") {

        }
        .frame(width: 24, height: 24)
        .fontWeight(.black)
        .labelStyle(.iconOnly)
        .tint(.neutralText)
    }
}

#Preview {
    NavigationStack {
        ContactsView()
    }
}
