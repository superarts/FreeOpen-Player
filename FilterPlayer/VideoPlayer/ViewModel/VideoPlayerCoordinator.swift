//
//  VideoPlayerCoordinator.swift
//  FilterPlayer
//
//  Created by Leo on 1/12/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

/// This `Coordinator` doesn't need to capture `self`, so it is immutable.
struct VideoPlayerCoordinator {
    /// Instead of `View`, VideoPlayer has `@environmentObject`.
    /// `view` is mutable because its `AboutView` is injected from `AboutCoordinator`.
    private var view: VideoPlayerView!
    /// `ViewModel` depends on a `UIDocument`.
    private let viewModel: VideoPlayerViewModel
    /// `Coordinator` for next `About` screen
    private let aboutCoordinator: AboutCoordinator

    /// `View` with `@environmentObject`
    var environment: some View {
        view.environmentObject(viewModel.player)
    }

    /// `Init` with a `UIDocument` to view, and an action when `dismissed`
    init(document: UIDocument, dismiss: @escaping () -> Void) {
        viewModel = VideoPlayerViewModel(url: document.fileURL)
        view = VideoPlayerView(
            player: viewModel.player.player,
            toggle: viewModel.toggleAction,
            dismiss: dismiss
        )
        aboutCoordinator = AboutCoordinator()
        view.aboutViewAction = aboutCoordinator.viewAction
    }
}
