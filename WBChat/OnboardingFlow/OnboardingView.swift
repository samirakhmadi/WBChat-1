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
    
    var body: some View {
        NavigationStack {
            VStack {
                onboardingImage
                onboardingTitle
                termsOfUseButton
                startButton
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ViewBackgroundColor())
            .sheet(isPresented: $showSheetView){
                OnboardingView_Sheet()
            }
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
        PlainTextButton(title: Localization.userAgreementText.rawValue, titleColor: .brand) {}
            .padding(.top, 158)
    }
    
    var startButton: some View {
        CapsuleButton(title: Localization.startChattingText.rawValue){
            showSheetView = true
        }
        .padding(.top, 18)
        .padding(.bottom, 20)
        .padding(.horizontal, 24)
    }
}


#Preview {
    OnboardingView()
}
