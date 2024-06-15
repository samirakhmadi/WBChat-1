//
//  ContactsView.swift
//  WBChat
//
//  Created by Александр on 07.06.2024.
//

import SwiftUI

struct ContactsView: View {
    
    @State private var searchText: String = ""
    @Binding var isDetailShowing: Bool
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.homeRoutes){
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    searchField
                    ForEach(Contact.contacts.indices, id: \.self) { index in
                        let contact = Contact.contacts[index]
                        contactButton(contact: contact, isNeedTopPadding: index != 0)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        viewTitle
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        addButton
                    }
                }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: ContactsRoutes.self) { route in
                    switch route {
                    case .contactDetail(let contact):
                        ContactDetailView(
                            isDetailShowing: $isDetailShowing,
                            contact: contact
                        )
                    case .addContact:
                        Text("Добавить контакт")
                            
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ViewBackgroundColor())
        }
        .tint(.neutralText)
    }
}

private extension ContactsView {
    
    var searchField: some View {
        CustomSearchField(text: $searchText, placeholder: "Search")
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
    }
    
    var viewTitle: some View {
        Text("Контакты")
            .font(.system(size: 18).weight(.semibold))
            .foregroundStyle(.neutralText)
    }
    
    func contactButton(contact: Contact, isNeedTopPadding: Bool) -> some View {
        Button {
            router.homeRoutes.append(ContactsRoutes.contactDetail(contact))
        } label: {
            ContactsView_ContactRow(
                contact: contact,
                isNeedTopPadding: isNeedTopPadding)
        }
    }
    
    var addButton: some View {
        Button("", systemImage: "plus") {
            router.homeRoutes.append(ContactsRoutes.addContact)
        }
        .frame(width: 24, height: 24)
        .fontWeight(.black)
        .labelStyle(.iconOnly)
        .tint(.neutralText)
    }
}

#Preview {
    NavigationStack {
        ContactsView(isDetailShowing: .constant(false))
            .environmentObject(Router())
    }
}
