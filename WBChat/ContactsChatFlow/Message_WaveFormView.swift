//
//  Message_WaveFormView.swift
//  WBChat
//
//  Created by Александр on 06.08.2024.
//

import SwiftUI
import ExyteChat

struct Message_WaveFormView: View {
    let recording: Recording
    @State private var isPlaying: Bool = false
    
    var body: some View {
        HStack(spacing: 16) {
            HStack(spacing: 4){
                Button {
                    isPlaying.toggle()
                } label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .foregroundColor(.white)
                        .frame(width: 16, height: 16)
                }
                Text(recording.duration.formatDuration())
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .medium))
            }
            HStack(spacing: 2) {
                ForEach(recording.waveformSamples.indices, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color.white)
                        .frame(width: 3, height: recording.waveformSamples[index] * 40)
                }
            }
        }
        .padding(.vertical, 10.5)
        .padding(.horizontal, 8)
        .background(.voiceMessageBG)
        .cornerRadius(4)
    }
}

#Preview {
    Message_WaveFormView(recording: .init(duration: 20, waveformSamples: [0.2, 0.5, 0.3, 0.8, 0.4, 0.6, 0.7, 0.2, 0.5, 0.9, 0.3, 0.6, 0.4, 0.7]))
}
