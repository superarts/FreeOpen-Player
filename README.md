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
- [`v0.2`: Navigation](#v02-navigation)
  - [Wrapper for `UIViewController`](#wrapper-for-uiviewcontroller)
  - [Storyboard to Scene](#storyboard-to-scene)
  - [Ownership](#ownership)
    - [`DocumentBrowser`](#documentbrowser)
    - [`VideoPlayer`](#videoplayer)
  - [Navigation](#navigation)

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

## [`v0.2`: Navigation](https://github.com/superarts/FreeOpen-Player/tree/0.2-navigation#v02-navigation)

### Wrapper for `UIViewController`

The reason that Xcode "Document Based App" template is not based on `SwiftUI` is probably due to the fact that `UIDocumentBrowserViewController` is still a `UIKit` component. In [Working with `UIKit`](#working-with-uikit), we created wrapper to represent `UIView` in `View`, and `VideoPlayerView` is our `SwiftUI` view. Now we are going to wrap `DocumentBrowserViewController` with `SwiftUI`.

- `DocumentBrowserView` is created as a `SwiftUI` View.
- `DocumentBrowserRepresenter` represents `DocumentBrowserViewController`, which is inherited from `UIDocumentBrowserViewController` in `UIKit`.
- `DocumentBrowserView_Previews` handles `SwiftUI` preview.

### Storyboard to Scene

Now all of views are based on `SwiftUI`, but the app is still `Storyboard` based. We know that iOS app starts from `main()` and when its run loop reaches `UIApplicationDelegate`, UI will be launched based on different settings:

- If nothing is set up, we need to add a `UIView` to `UIWindow`, or add a `UIViewController` as the `rootViewCoontroller` of `UIWindow` (programmatically or from `xib`);
- If `Main storyboard file base name` is set up in `Info.plist`, iOS looks for the storyboard file, instantiate its root view controller, and add it to `UIWindow`;
- And now, we have a new `Application Scene Manifest` in `Info.plist`. `Configuration Name` is the new entry point name.

So to move to `SwiftUI`, we need to:

- Replace `Main storyboard file base name` with `Application Scene Manifest` in `Info.plist`;
- Update `AppDelegate` with `UISceneSession`;
- Add `SceneDelegate`, and our entry `View` will be set there.
- We also need to handle `openURL`. I'll work on that future releases.

Our app is now fully based on `SwiftUI`. 

### Ownership

In `0.1` design, the way I was using [View Model](#view-model) was more like a combination of coordinator and view model. The idea is that it handles all business logic, which includes navigation logic. With `UIKit`, it would access `UINavigationController`; with `SwiftUI`, it injects behavior to `View`, and provides `View` to previous view model.

~Although this model would work, I feel like by the design of `SwiftUI`, it would be much easier to handle navigation logic inside `View` due to tools like `@State`. In this case, `View` will own `ViewModel` and get behaviors from it, instead of being injected. I'm exploring this route in `v0.2`.~
(Update: I figured out how it would work, please skip this part.)

After some exploration, I went back to the old `MVVM-C` approach. It works like this:

- `Coordinator` owns `View` and `ViewModel`.
- App starts from a root `Coordinator's View`.
- `View` and `ViewModel` do not own each other - we have different setup.
- `View` cannot be mutable; using `class` will give you crash at `AppDelegate` with no helpful backtrace info.

#### `DocumentBrowser`

- `ViewModel`
  - `ViewModel` depends on navigation actions from `Coordinator`.
  - `ViewModel` owns a `DocumentBrowserViewControllerDelegate`.
  - `DocumentBrowserViewControllerDelegate` depends on document handling action from `ViewModel`.
- `View` owns `Representer`, that owns `UIViewController`.
- `Coordinator`
  - `Coordinator` sets `ViewModel`'s delegate object to `View`'s controller.
  - `Coordinator`'s navigation logic depends on `View`'s controller.
  - `Coordinator`'s navigation logic to next `VideoPlayerView` is not purely from `VideoPlayerCoordinator`, because part of the navigation logic depends on `UIKit`.
- `Coordinator` and `ViewModel` are mutable, because they have actions that capture `self`.

#### `VideoPlayer`

- `ViewModel` provides business logic when play/pause button is toggled.
  - Such logic is injected by `Coordinator`.
- `View` reads `@EnvironmentObject`.
- `View` owns `Representer` that owns `LegacyPlayerView`.
- `Coordinator`'s navigation logic to next `AboutView` is from `AboutCoordinator`.

### Navigation

Although we just have a couple of `Views`, navigation logic design is still not easy, because some of them involves `UIKit` while some of them are purely `SwiftUI` based. We now have 3 `Coordinators`, and they cover several use cases.

In `v0.2`, I stick to `MVVM-C` because it allows me to put navigation logic in a dedicated place. Since `View` doesn't own `ViewModel` now, behaviors have to be injected, instead of properties. This allows business logic to be decoupled from navigation logic and UI logic.

## `v0.3`: TBD