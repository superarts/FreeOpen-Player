# FreeOpen Player™

This project is to explore `SwiftUI`.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Contents

- [Prelude](#prelude)
- [`v0.1`: Single View Video Player](#v01-single-view-video-player)
  - [Working with `UIKit`](#working-with-uikit)
  - [Preview in `SwiftUI`](#preview-in-swiftui)
  - [View Model](#view-model)
  - [Observable](#observable)
  - [`DocumentBrowserViewController`](#documentbrowserviewcontroller)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Prelude

It's quite late for me to finally start exploring `SwiftUI`, so perhaps it won't be very helpful. Keep reading if you want to see `SwiftUI` and `Combine` through fresh eyes.

To start, I'm trying to build a video player with real time filter, which will be stupid - just a `UIView` overlay. The idea is to start with something really simple but still does something useful.

I'm not going to add links to files for now; to look up code, please clone repo, open project in Xcode, and search for keywords `command + shift + F`.

## [`v0.1`: Single View Video Player](https://github.com/superarts/FreeOpen-Player/tree/0.1-single-view)

I started this project using the "Document Based App" template. By default, it doesn't have scene delegate, and `SwiftUI` preview is not enabled, too.

### Working with `UIKit`

- `LegacyPlayerView` is a `UIView` that contains a `AVPlayerLayer`. It is passive.
- `VideoPlayerRepresenter` is a wrapper that represents `UIView` in `SwiftUI`.
- `VideoPlayerView` sets up `VideoPlayerRepresenter`, and put the `LegacyPlayerView` in it. It handles UI logic.

### Preview in `SwiftUI`

Please check the following components for Preview.

- `VideoPlayerView_Previews` in `VideoPlayerView`
- `DocumentBrowserViewControllerRepresenter` and `DocumentViewController_Previews` in `DocumentBrowserViewController`
- `DocumentView_Previews` in `DocumentView`

### View Model

`VideoPlayerViewModel` handles business logic.

- In my current design, `ViewModel` holds `View` and `Model`. It acts like "ViewModel+Presenter" or "ViewModel+Coordinator", and I need to learn more about navigation in `SwiftUI` to change the design.
- `ObservableVideoPlayer` is a reactive model. To make it an `environmentObject` in `Views` like `LegacyPlayerView`, we use a `environment` to provide `View`.

### Observable

- `ObservableVideoPlayer` doesn't have `@Published` properties; its `status` is managed manually by itself.
- In `VideoPlayerView`, `self.player.status` shows how to observe a `@EnvironmentObject`.

### `DocumentBrowserViewController`

- `DocumentBrowserViewController` is not refactored yet. It is currently a typical massive view controller that does everything.
- In `presentDocument(at:)`, we inject `dismissAction` into `VideoPlayerViewModel`. The idea is that `VideoPlayerViewModel` should not be aware of its caller. However, I need to learn more about the whole navigation concept of `SwiftUI` to figure out which part should be responsible for navigation.