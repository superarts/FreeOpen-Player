//
//  VideoPlayerView.swift
//  FilterPlayer
//
//  Created by Leo on 1/1/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import AVFoundation

class PlayerView: UIView {
    var url: URL

    private let playerLayer = AVPlayerLayer()

    init(url: URL) {
        self.url = url
        super.init(frame: .zero)
        setupPlayer()
    }

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }

    private func setupPlayer() {
        // let url = URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!
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
    // Init from default constructor
    var document: UIDocument
    var dismiss: () -> Void

    var body: some View {
        VStack {
            Text("Playing")
            VideoPlayerRepresenter(url: document.fileURL)
            Button("Done", action: dismiss)
        }
    }
}

// MARK: - Preview

/// Represent PlayerView
struct VideoPlayerRepresenter: UIViewRepresentable {
    var url: URL

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoPlayerRepresenter>) {
    }

    func makeUIView(context: Context) -> UIView {
        return PlayerView(url: url)
    }
}

#if DEBUG
struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(document: UIDocument(fileURL: URL(string: "file:///Users/leo/Public")!)) { }
    }
}
#endif
