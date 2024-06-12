//
//  UsersOnlineIntent.swift
//  WBChat
//
//  Created by Александр on 12.06.2024.
//

import Foundation
import AppIntents
import Network
import SwiftUI

struct UsersOnlineIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Сколько контактов онлайн?"
    static var description = IntentDescription("Возвращает количество людей, находящихся в данный момент в сети.")
    static var openAppWhenRun: Bool = false
    
    private let monitor = NWPathMonitor()

    @MainActor
    func perform() async throws -> some ShowsSnippetView {

        guard await isNetworkAvailable() else {
            return .result(view: FailureView(text: "Нет подключения к сети", imageName: "wifi.slash"))
        }
        
        do {
            let numberOfPeopleOnline = try await fetchNumberOfPeopleOnline()
            return .result(view: SuccessView(text: "\(numberOfPeopleOnline)"))
        } catch {
            return .result(view: FailureView())
        }
    }

    private func isNetworkAvailable() async -> Bool {
        return await withCheckedContinuation { continuation in
            let queue = DispatchQueue(label: "NetworkMonitor")
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    continuation.resume(returning: true)
                } else {
                    continuation.resume(returning: false)
                }
                self.monitor.cancel()
            }
            monitor.start(queue: queue)
        }
    }

    private func fetchNumberOfPeopleOnline() async throws -> Int {

        try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        
        return Contact.contacts.filter { $0.isOnline }.count
    }
}
