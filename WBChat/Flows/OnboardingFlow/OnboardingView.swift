//
//  OnboardingView.swift
//  WBChat
//
//  Created by Александр on 05.06.2024.
//

import SwiftUI
import UIComponents

struct OnboardingView: View {
    @State private var showSheetView: Bool = false
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        NavigationRoot(coordinator: coordinator) {
            VStack {
                onboardingImage
                onboardingTitle
                termsOfUseButton
                startButton
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ViewBackgroundColor(backgroundColor: .neutral))
        }
    }
}

private extension OnboardingView {
    var onboardingImage: some View {
        Image(.onboarding)
            .resizable()
            .scaledToFill()
            .frame(width: 260, height: 270)
            .padding(.horizontal, 56)
            .padding(.top, 45)
    }
    
    var onboardingTitle: some View {
        Text(Localization.onboardingTitleText.rawValue, tableName: Localization.tableName)
            .foregroundStyle(.neutralText)
            .font(.system(size: 24).weight(.bold))
            .multilineTextAlignment(.center)
            .padding(.top, 42)
    }
    
    var termsOfUseButton: some View {
        PlainTextButton(
            title: Localization.userAgreementText.rawValue,
            localizationTableName: Localization.tableName,
            titleColor: .brand
        ) {
            coordinator.navigate(to: .termsOfUse)
        }
        .padding(.top, 158)
    }
    
    var startButton: some View {
        CapsuleButton(
            title: Localization.startChattingText.rawValue,
            localizationTableName: Localization.tableName,
            activeColor: Color.brand ,
            disabledColor: Color.brand.opacity(0.5)) {
                coordinator.navigate(to: .phoneInput)
            }
            .padding(.top, 18)
            .padding(.bottom, 20)
            .padding(.horizontal, 24)
    }
}


#Preview {
    OnboardingView()
        .environmentObject(NavigationCoordinator())
}