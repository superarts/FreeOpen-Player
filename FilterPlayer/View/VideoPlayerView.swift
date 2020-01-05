//
//  VideoPlayerView.swift
//  FilterPlayer
//
//  Created by Leo on 1/1/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import AVFoundation

class PlayerView: UIView {

    private let playerLayer = AVPlayerLayer()

    init(player: AVPlayer) {
        super.init(frame: .zero)
        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

// MARK: - UI

import SwiftUI

struct VideoPlayerViewModel {
    let view: VideoPlayerView

    private let player: AVPlayer

    init(document: UIDocument, dismiss: @escaping () -> Void) {
        player = AVPlayer(url: document.fileURL)
        view = VideoPlayerView(player: player, dismiss: dismiss)

        setupPlayer()
    }

    private func setupPlayer() {
        player.play()
    }
}

struct VideoPlayerView: View {
    let representer: VideoPlayerRepresenter

    private let dismiss: () -> Void

    init(player: AVPlayer, dismiss: @escaping () -> Void) {
        self.dismiss = dismiss
        representer = VideoPlayerRepresenter(player: player)
    }

    var body: some View {
        VStack {
            Text("Playing")
            representer
            Button("Play") {
                print("play")
            }
            Button("Done", action: dismiss)
        }
    }
}

// MARK: - Preview

/// Represent PlayerView
struct VideoPlayerRepresenter: UIViewRepresentable {
    let playerView: PlayerView

    init(player: AVPlayer) {
        playerView = PlayerView(player: player)
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoPlayerRepresenter>) {
    }

    func makeUIView(context: Context) -> UIView {
        return playerView
    }
}

#if DEBUG
struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(player: AVPlayer(url: URL(string: "file:///Users/leo/Public")!)) { }
    }
}
#endif
