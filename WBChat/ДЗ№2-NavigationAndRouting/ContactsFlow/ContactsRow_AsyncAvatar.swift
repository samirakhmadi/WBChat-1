//
//  ContactsRow_AsyncAvatar.swift
//  WBChat
//
//  Created by Александр on 27.07.2024.
//

import SwiftUI

// AsyncAvatar -  вью для асинхронной загрузки и отображения аватара.
// Существует встроенный AsyncImage, где не нужен GCD, но захотелось попробовать создать свой вариант
struct ContactsRow_AsyncAvatar: View {
    // Перечисление для описания состояния загрузки
    enum LoadingState {
        case loading
        case loaded(image: UIImage)
        case failed
    }
    
    // Состояние загрузки
    @State private var loadingState: LoadingState = .loading

    let url: String
    
    var body: some View {
        avatar
            .onAppear {
                loadAvatar()
            }
    }
    
    // Метод для загрузки аватара
    private func loadAvatar() {
        ImageLoader.shared.loadImage(from: url) { loadedImage in
            switch loadedImage {
            case .some(let avatar):
                withAnimation(.easeIn){
                    loadingState = .loaded(image: avatar)
                }
            case .none:
                withAnimation(.easeIn){
                    loadingState = .failed
                }
            }
        }
    }
}

// Приватное расширение для определения вью аватара
private extension ContactsRow_AsyncAvatar {
    var avatar: some View {
        Group {
            switch loadingState {
            case .loading:
                // Отображаем индикатор загрузки
                ProgressView()
            case .loaded(let image):
                // Отображаем загруженное изображение
                Image(uiImage: image)
                    .resizable()
                    
            case .failed:
                // Отображаем изображение ошибки
                Image(systemName: "network.slash")
                    .resizable()
                    .background(.brand)
            }
        }
    }
}

#Preview {
    VStack {
        ContactsRow_AsyncAvatar(url: "www.example.com/icon")
            .frame(width: 50, height: 50)
        
        ContactsRow_AsyncAvatar(url: "https://ui-avatars.com/api/?name=Aboba+Aboba")
            .frame(width: 50, height: 50)
    }
}
