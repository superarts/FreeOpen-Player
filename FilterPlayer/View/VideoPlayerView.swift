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

    override init(frame: CGRect) {
        super.init(frame: frame)

        let url = URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!
        let player = AVPlayer(url: url)
        player.play()

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

struct VideoPlayerView: View {
    var body: some View {
        VideoPlayerRepresenter()
    }
}

// MARK: - Preview

#if DEBUG
struct VideoPlayerRepresenter: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoPlayerRepresenter>) {
    }

    func makeUIView(context: Context) -> UIView {
        return PlayerView(frame: .zero)
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
#endif
