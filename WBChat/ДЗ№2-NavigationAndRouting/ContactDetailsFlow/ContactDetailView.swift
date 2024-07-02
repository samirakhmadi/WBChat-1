//
//  ContactDetailView.swift
//  WBChat
//
//  Created by Александр on 07.06.2024.
//

import SwiftUI

struct ContactDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isDetailShowing: Bool
    let contact: Contact
    var body: some View {
        VStack {
            contactAvatar
            textContainer
            socialsStack
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ViewBackgroundColor())
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
            ToolbarItemGroup(placement: .principal) {
                title
            }
            ToolbarItem(placement: .topBarTrailing) {
                editButton
            }
        }
        .onAppear {
            isDetailShowing.toggle()
        }
        .onDisappear{
            isDetailShowing.toggle()
        }
    }
}


//MARK: Toolbar item'ы
private extension ContactDetailView {
    var backButton: some View {
        NavigationBackButton()
    }
    
    var title: some View {
        HStack{
            Text("Профиль")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .tint(.neutralText)
            Spacer()
        }
        .padding(.leading, 8)
    }
    
    var editButton: some View {
        Button {
        } label: {
            Image(.edit)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
        .tint(.neutralText)
    }
}

//MARK: SubViews
private extension ContactDetailView {
    var contactAvatar: some View {
        ContactDetailView_UserAvatar(contact: contact)
            .padding(.top, 40)
    }
    
    var textContainer: some View {
        VStack(spacing: 4){
            Text(contact.name)
                .font(.system(size: 24).weight(.semibold))
            Text(contact.phoneNumber.formatCustomNumber(mask: "+X XXX XXX-XX-XX"))
                .font(.system(size: 16))
                .foregroundStyle(.neutralDisabled)
        }
        .padding(.top, 20)
    }
    
    var socialsStack: some View {
        HStack(spacing: 12) {
            ForEach(Socials.allCases) { social in
                Button {
                } label: {
                    Image(social.icon)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.brand)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 26)
                        .background(Capsule().stroke(.brand, lineWidth: 1.67))
                }
            }
        }
        .padding(.top, 40)
    }
}


#Preview {
    struct BindingViewPreviewContainer : View {
        var body: some View {
            NavigationStack {
                ContactDetailView(
                    isDetailShowing: .constant(false), contact: .init(
                        name: "Петя",
                        phoneNumber: "79999999999",
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
