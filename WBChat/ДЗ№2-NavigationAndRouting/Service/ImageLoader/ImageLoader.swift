//
//  ImageLoader.swift
//  WBChat
//
//  Created by Александр on 27.07.2024.
//

import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    private init() {}
    // Метод для загрузки изображения по URL
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        // Проверяем, можно ли создать URL из строки
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        // Выполняем загрузку в фоновом потоке
        DispatchQueue.global(qos: .userInitiated).async {
            // Пытаемся загрузить данные и создать изображение
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                // Если успешно, вызываем completion в главном потоке
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                // Если не удалось, вызываем completion с nil в главном потоке
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
