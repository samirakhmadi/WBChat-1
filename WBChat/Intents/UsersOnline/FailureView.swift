//
//  FailureView.swift
//  WBChat
//
//  Created by Александр on 12.06.2024.
//

import SwiftUI

struct FailureView: View {
    var text: String?
    var imageName: String?
    
    var body: some View {
        VStack {
            HStack{
                Text("😓")
                image
            }
            .foregroundStyle(.red)
            .imageScale(.medium)
            .font(.largeTitle)
            Text("Очень жаль, но выполнить задачу не удалось.")
                .multilineTextAlignment(.center)
            descr
        }
        .padding()
    }
}

private extension FailureView {
    var descr: some View {
        switch text {
        case .some(let desc):
            Text(desc)
        case .none:
            Text("")
        }
    }
    
    var image: some View {
        switch imageName {
        case .some(let imageName):
            Image(systemName: imageName)
        case .none:
            Image(systemName: "xmark")
        }
    }
}


#Preview {
    VStack(spacing: 10){
        FailureView(imageName: "wifi.slash")
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        FailureView(text: "aboba")
            .border(.red, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
}
