//
//  VideoPlayerViewModel.swift
//  FilterPlayer
//
//  Created by Leo on 1/5/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

final class VideoPlayerCoordinator {
    private var view: VideoPlayerView!
    private let viewModel: VideoPlayerViewModel
    private var aboutCoordinator: AboutCoordinator

    var environment: some View {
        view.environmentObject(viewModel.player)
    }

    init(document: UIDocument, dismiss: @escaping () -> Void) {
        viewModel = VideoPlayerViewModel(url: document.fileURL)
        view = VideoPlayerView(
            player: viewModel.player.player,
//            aboutViewAction: aboutCoordinator.viewAction,
            toggle: viewModel.toggleAction,
            dismiss: dismiss
        )
        print("xx2 \(view.$isAboutPresented)")
//        aboutCoordinator = AboutCoordinator(isPresented: view.$isAboutPresented)
        aboutCoordinator = AboutCoordinator()
        view.aboutViewAction = aboutCoordinator.viewAction
//        aboutCoordinator.dismissAction = aboutDismissAction
    }

//    private lazy var aboutDismissAction: () -> Void = {
//        self.view.isAboutPresented = false
//        let b: Binding<Bool> = self.view.$isAboutPresented
//    }
//    func aboutView() -> AboutView {
//        return AboutView {
//            self.view.isAboutPresented = false
//        }
//    }
}

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
