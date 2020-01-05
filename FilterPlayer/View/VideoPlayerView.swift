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

//    private let url: URL

    init(player: AVPlayer) {
//        self.url = url
        super.init(frame: .zero)
        playerLayer.player = player
        layer.addSublayer(playerLayer)
//        setupPlayer()
    }

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }

//    private func setupPlayer() {
//        // let url = URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!
//        let player = AVPlayer(url: url)
//        player.play()
//
//        playerLayer.player = player
//        layer.addSublayer(playerLayer)
//    }

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

//    private let document: UIDocument
//    private let dismiss: () -> Void
    private let player: AVPlayer
//    private let playerLayer: AVPlayerLayer

    init(document: UIDocument, dismiss: @escaping () -> Void) {
//        self.document = document
//        self.dismiss = dismiss

        player = AVPlayer(url: document.fileURL)
        view = VideoPlayerView(player: player, dismiss: dismiss)

        setupPlayer()
    }

    private func setupPlayer() {
        //view.representer.playerView.playerLayer.player = player
        player.play()
    }
}

struct VideoPlayerView: View {
    let representer: VideoPlayerRepresenter

//    private let document: UIDocument
    private let dismiss: () -> Void

    init(player: AVPlayer, dismiss: @escaping () -> Void) {
//        self.document = document
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

//    private let url: URL

    init(player: AVPlayer) {
//        self.url = url
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
