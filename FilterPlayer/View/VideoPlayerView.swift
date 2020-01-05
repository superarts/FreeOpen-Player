//
//  VideoPlayerView.swift
//  FilterPlayer
//
//  Created by Leo on 1/1/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import AVFoundation

// AVPlayer is not supported by SwiftUI yet
class LegacyPlayerView: UIView {

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

import Combine

final class ObservableVideoPlayer: ObservableObject {
    // Exposing `player` to pass it to `LegacyPlayerView`
    let player: AVPlayer

    init(url: URL) {
        player = AVPlayer(url: url)
    }

    // MARK: - Observable

    let objectWillChange = ObservableObjectPublisher()

    var status = "" {
        willSet { objectWillChange.send() }
    }

    // MARK: - Playback control

    func play() {
        player.play()
        status = "Playing"
    }

    func pause() {
        player.pause()
        status = "Paused"
    }

    func toggle() {
        if player.timeControlStatus == .paused {
            play()
        } else {
            pause()
        }
    }
}

// MARK: - UI

import SwiftUI

// VideoPlayerViewModel captures `self` in toggleAction.
// It should be strongly retained, because it owns View.
final class VideoPlayerViewModel {
    // Exposing `view` for navigation
    var view: VideoPlayerView!

    // Exposing `player` for observation
    let player: ObservableVideoPlayer

    init(document: UIDocument, dismiss: @escaping () -> Void) {
        player = ObservableVideoPlayer(url: document.fileURL)
        view = VideoPlayerView(player: player.player, dismiss: dismiss, toggle: toggleAction)

        player.play()
    }

    private lazy var toggleAction: () -> Void = {
        print("PLAYER toggle \(self.player.player.timeControlStatus)")
        self.player.toggle()
    }
}

struct VideoPlayerView: View {
    @EnvironmentObject private var player: ObservableVideoPlayer
    private let representer: VideoPlayerRepresenter
    private let dismissAction: () -> Void
    private let toggleAction: () -> Void

    init(player: AVPlayer, dismiss: @escaping () -> Void, toggle: @escaping () -> Void) {
        self.dismissAction = dismiss
        self.toggleAction = toggle
        representer = VideoPlayerRepresenter(player: player)
    }

    var body: some View {
        VStack {
            Text("Playing")
            representer
            Button(self.player.status, action: toggleAction)
            Button("Done", action: dismissAction)
        }
    }
}

// MARK: - Preview

/// Represent PlayerView
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
