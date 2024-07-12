//
//  LoadingProgress.swift
//  
//
//  Created by Александр on 12.07.2024.
//

import SwiftUI

public struct LoadingProgress: View {
    var showProgress: Bool
    
    public init(showProgress: Bool) {
        self.showProgress = showProgress
    }
    
    public var body: some View {
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

