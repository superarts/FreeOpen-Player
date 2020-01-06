//
//  VideoPlayerView.swift
//  FilterPlayer
//
//  Created by Leo on 1/1/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI
import AVFoundation

/// `SwiftUI` Views are passive. Their behaviors are controlled by ViewModels.
struct VideoPlayerView: View {

    @EnvironmentObject private var player: ObservableVideoPlayer
    @State private var isAboutPresented: Bool = false
    private let representer: VideoPlayerRepresenter
    private let dismissAction: () -> Void
    private let toggleAction: () -> Void

    init(
        player: AVPlayer,
        dismiss: @escaping () -> Void,
        toggle: @escaping () -> Void
    ) {
        self.dismissAction = dismiss
        self.toggleAction = toggle
        representer = VideoPlayerRepresenter(player: player)
    }

    var body: some View {
        VStack {
            Text("Player")
            representer
            Button(self.player.status, action: toggleAction)
            Button("Done", action: dismissAction)
            Button("About") {
                self.isAboutPresented = true
            }.sheet(isPresented: self.$isAboutPresented) {
                AboutView {
                    self.isAboutPresented = false
                }
            }
        }
    }
}

// MARK: - Preview

/// Represent LegacyPlayerView. It is set up by ViewModel.
struct VideoPlayerRepresenter: UIViewRepresentable {
    private let playerView: LegacyPlayerView

    init(player: AVPlayer) {
        playerView = LegacyPlayerView(player: player)
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoPlayerRepresenter>) {
    }

    func makeUIView(context: Context) -> UIView {
        return playerView
    }
}

#if DEBUG
/// For `SwiftUI` preview
struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        return VideoPlayerView(
            player: AVPlayer(url: URL(string: "file:///Users/leo/Public")!),
            dismiss: { },
            toggle: { }
        )
    }
}
#endif
