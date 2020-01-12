//
//  VideoPlayerViewModel.swift
//  FilterPlayer
//
//  Created by Leo on 1/5/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

/// - `VideoPlayerViewModel` depends on `UIKit`, because it handles `UIDocument`.
/// - `VideoPlayerViewModel` captures `self` in toggleAction. It should be strongly retained, because it owns View.
final class VideoPlayerViewModel {

    /// Reactive video player
    let player: ObservableVideoPlayer

    init(url: URL) {
        player = ObservableVideoPlayer(url: url)
        player.play()
    }

    /// Action for play/pause button
    lazy var toggleAction: () -> Void = {
        print("PLAYER toggle \(self.player.player.timeControlStatus)")
        self.player.toggle()
    }
}
