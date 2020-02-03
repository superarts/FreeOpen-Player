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
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        item.videoComposition = AVVideoComposition(asset: asset) { request in
            let filter = request
                .sourceImage
                .clampedToExtent()
                .applyingFilter("CIBloom")
                .clamped(to: request.sourceImage.extent)
//            let blurRadius = 6.0
//            let filter = request
//                .sourceImage
//                .clampedToExtent()
//                .applyingGaussianBlur(sigma: blurRadius)
//                .clamped(to: request.sourceImage.extent)
            request.finish(with: filter, context: nil)
        }

        player = AVPlayer(playerItem: item)
        addPeriodicTimeObserver()
        //player = AVPlayer(url: url)
    }

    // MARK: - Observable

    let objectWillChange = ObservableObjectPublisher()

    var status = "" {
        willSet { objectWillChange.send() }
    }

    var progress = 0.0 {
        willSet {
            objectWillChange.send()
            if progress >= 1 {
                status = "Stopped"
            }
        }
    }

    var isDragging = false {
        willSet {
            print("dragging")
            //objectWillChange.send()
            toggle()
        }
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

    func seek() {
        guard let duration = self.player.currentItem?.duration else { return }
        self.player.seek(to: CMTimeMultiplyByFloat64(duration, multiplier: Float64(progress)))
    }

    private func addPeriodicTimeObserver() {
        player.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)),
            queue: DispatchQueue.main
        ) { [weak self] time in
            guard let self = self else { return }
            let currentSeconds = CMTimeGetSeconds(time)
            guard let duration = self.player.currentItem?.duration else { return }
            let totalSeconds = CMTimeGetSeconds(duration)
            self.progress = Double(currentSeconds / totalSeconds)
            print(self.progress)
        }
    }
}
