//
//  ObservableVideoPlayer.swift
//  FilterPlayer
//
//  Created by Leo on 1/5/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import Combine
import AVFoundation

/// "Observable" models are reactive.
/// `ObservableVideoPlayer.player` depends on `AVFoundation`.
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
