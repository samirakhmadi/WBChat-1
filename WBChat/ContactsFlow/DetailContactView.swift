//
//  DetailContactView.swift
//  WBChat
//
//  Created by Александр on 07.06.2024.
//

import SwiftUI

struct DetailContactView: View {
    @Environment(\.dismiss) private var dismiss
    let contact: Contact
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 10) {
                ContactRow_UserAvatar(contact: contact)
                VStack(alignment: .leading) {
                    Text(contact.name)
                    Text(contact.status)
                        .foregroundStyle(contact.isOnline ? .green : .secondary)
                    Text("+7\(contact.phoneNumber)")
                }
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ViewBackgroundColor())
        .navigationBarTitleDisplayMode(.inline)
        .tint(.neutralText)
        .onAppear {
            UINavigationBar.appearance().tintColor = UIColor.neutralText
        }
    }
}



#Preview {
    struct BindingViewPreviewContainer : View {
        @Namespace private var animation
        
        var body: some View {
            NavigationStack {
                DetailContactView(
                    contact: .init(
                        name: "Петя",
                        phoneNumber: "6666666666",
                        status: "Онлайн",
                        isOnline: true,
                        hasNewStories: true,
                        avatar: .Avatars.petya
                    )
                )
            }
        }
    }
    return BindingViewPreviewContainer()
}
