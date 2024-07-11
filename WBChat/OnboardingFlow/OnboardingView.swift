//
//  OnboardingView.swift
//  WBChat
//
//  Created by Александр on 05.06.2024.
//

import SwiftUI

struct OnboardingView: View {
    @State private var showSheetView: Bool = false
    @Environment(\.dismiss) private var dismiss

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
            .background(ViewBackgroundColor())
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
        PlainTextButton(title: Localization.userAgreementText.rawValue, titleColor: .brand) {
            coordinator.navigate(to: .termsOfUse)
//            router.onboardingRoutes.append(.termsOfUseView)
        }
            .padding(.top, 158)
    }
    
    var startButton: some View {
        CapsuleButton(title: Localization.startChattingText.rawValue){
//            router.onboardingRoutes.append(.phoneInputView)
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
