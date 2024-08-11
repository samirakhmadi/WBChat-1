//
//  Modifiers.swift
//  WBChat
//
//  Created by Alex on 11.08.2024.
//

import SwiftUI

struct BodyText1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .semibold))
    }
}

struct IconStyleSearchField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22))
    }
}

struct RoundedCornerStyle: ViewModifier {
    let radius: CGFloat
    let shadowRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(radius)
            .shadow(radius: shadowRadius)
    }
}

struct HorizontalPadding: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
    }
}

struct ImageStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .modifier(RoundedCornerStyle(radius: 12, shadowRadius: 5))
            .modifier(HorizontalPadding())
    }
}

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .modifier(HorizontalPadding())
            .padding(.top, 16)
    }
}

struct DescriptionHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.secondary)
            .modifier(HorizontalPadding())
    }
}

struct DescriptionContentStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.yellow.opacity(0.2))
            .modifier(RoundedCornerStyle(radius: 10, shadowRadius: 5))
            .modifier(HorizontalPadding())
    }
}

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
            .modifier(RoundedCornerStyle(radius: 10, shadowRadius: 5))
            .modifier(HorizontalPadding())
    }
}
