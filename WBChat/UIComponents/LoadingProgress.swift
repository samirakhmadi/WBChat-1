//
//  LoadingProgress.swift
//  WBChat
//
//  Created by Александр on 03.07.2024.
//

import SwiftUI

struct LoadingProgress: View {
    var showProgress: Bool
    var body: some View {
        switch showProgress {
        case true:
            ProgressView()
        case false:
            EmptyView()
        }
    }
}

#Preview {
    LoadingProgress(showProgress: true)
}
