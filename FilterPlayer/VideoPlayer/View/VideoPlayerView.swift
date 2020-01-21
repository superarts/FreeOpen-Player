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

    /// This action provides `AboutView` with a binding state `isPresented`
    var aboutViewAction: ((Binding<Bool>) -> AboutView)!

    /// `AVPlayer` for representer
    @EnvironmentObject private var player: ObservableVideoPlayer
    /// `State` for `AboutView`
    @State private var isAboutPresented: Bool
    @State private var playingProgress: Float
    /// `Representer` that contains `LegacyPlayerView`
    private let representer: VideoPlayerRepresenter
    /// Action when play/pause state is toggled
    private let toggleAction: () -> Void
    /// Action when `self` is dismissed
    private let dismissAction: () -> Void

    init(player: AVPlayer, toggle: @escaping () -> Void, dismiss: @escaping () -> Void) {
        _isAboutPresented = State(initialValue: false)
        _playingProgress = State(initialValue: 0.5)
        self.toggleAction = toggle
        self.dismissAction = dismiss
        representer = VideoPlayerRepresenter(player: player)
    }

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                        .frame(width: 10.0)
                        .fixedSize()
                    Button("About") {
                        // TODO: find a better place for this `assertion`
                        assert(self.aboutViewAction != nil, "aboutViewAction should be set after AboutCoordinator is initialized")
                        self.isAboutPresented = true
                    }.sheet(isPresented: self.$isAboutPresented) {
                        self.aboutViewAction(self.$isAboutPresented)
                    }
                    Spacer()

                    Button(action: dismissAction) {
                        Image(systemName: "xmark")
                    }
//                    .padding()
//                    .background(Color.yellow)
//                    .cornerRadius(0)
//                    .blur(radius: 0)
//                    .clipShape(Circle())

                    Spacer()
                        .frame(width: 10.0)
                        .fixedSize()
                }
                Text("Player")
            }
            Divider()
            representer
            Divider()
            Button(self.player.status, action: toggleAction)
            Slider(value: $playingProgress)
                .padding(.horizontal)
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
// For `SwiftUI` preview
struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let document = UIDocument(fileURL: URL(string: "file:///Users/leo/Public")!)
        return VideoPlayerCoordinator(document: document) {
            //self.dismiss(document: document)
        }.environment
    }
}
#endif
