//
//  VideoPlayerView.swift
//  FilterPlayer
//
//  Created by Leo on 1/1/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI
import AVFoundation

// MARK: - View

/// `SwiftUI` Views should be passive. Use ViewModel to handle business logic.
struct VideoPlayerView: View {

    @EnvironmentObject private var player: ObservableVideoPlayer
    @State var isAboutPresented: Bool
    private let representer: VideoPlayerRepresenter
    var aboutViewAction: ((Binding<Bool>) -> AboutView)!
    private let toggleAction: () -> Void
    private let dismissAction: () -> Void
//    private let viewModel: VideoPlayerViewModel

    init(player: AVPlayer, toggle: @escaping () -> Void, dismiss: @escaping () -> Void) {
        _isAboutPresented = State(initialValue: false)
//        self.aboutViewAction = aboutViewAction
        self.toggleAction = toggle
        self.dismissAction = dismiss
//        self.viewModel = VideoPlayerViewModel(url: document.fileURL)
        representer = VideoPlayerRepresenter(player: player)
        print("xx1 \($isAboutPresented)")
    }

//    var environment: some View {
//        environmentObject(viewModel.player)
//    }

    var body: some View {
        VStack {
            Text("Player")
            representer
            Button(self.player.status, action: toggleAction)
            Button("Done", action: dismissAction)
            Button("About") {
                self.isAboutPresented = true
            }.sheet(isPresented: self.$isAboutPresented) {
                self.aboutViewAction(self.$isAboutPresented)
//                AboutView {
//                    self.isAboutPresented = false
//                }
            }
        }
    }
}

// MARK: - Wrapper

/// Represent LegacyPlayerView. It is set up by ViewModel.
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

// MARK: - Preview

#if DEBUG
/// For `SwiftUI` preview
//struct VideoPlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        return VideoPlayerView(document: UIDocument(fileURL: URL(string: "/Users/leo/Public")!)) { }
//    }
//}
#endif
