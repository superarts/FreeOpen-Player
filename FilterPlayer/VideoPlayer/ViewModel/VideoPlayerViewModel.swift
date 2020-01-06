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

    /// For navigation, use `environment` instead
    private var view: VideoPlayerView!
    private let player: ObservableVideoPlayer

    init(document: UIDocument, dismiss: @escaping () -> Void) {
        player = ObservableVideoPlayer(url: document.fileURL)
        view = VideoPlayerView(
            player: player.player,
            dismiss: dismiss,
            toggle: toggleAction
        )

        player.play()
    }

    /// `View` with `Environment`
    var environment: some View {
        view.environmentObject(player)
    }

    private lazy var toggleAction: () -> Void = {
        print("PLAYER toggle \(self.player.player.timeControlStatus)")
        self.player.toggle()
    }
}
