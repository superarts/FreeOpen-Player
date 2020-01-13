//
//  DocumentBrowserCoordinator.swift
//  FilterPlayer
//
//  Created by Leo on 1/11/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

/// `Coordinator` handles navigation logic; it is mutable because navigation actions need to capture `self`.
final class DocumentBrowserCoordinator {
    /// Provides `view` for navigation purpose
    let view = DocumentBrowserView()

    /// `Coordinator` holds `view` (and its `UIViewController`s), as well as `ViewModel`
    private let controller: DocumentBrowserViewController
    /// Setting up `ViewModel` requires actions that captures `self`.
    private var viewModel: DocumentBrowserViewModel!

    init() {
        self.controller = view.representer.controller
        viewModel = DocumentBrowserViewModel(
            presentVideoAction: presentVideoAction,
            presentDefaultAction: presentDefaultAction
        )
        /// `documentBrowserDelegate` is responsible of handling `UIKit` delegate logic;
        /// behaviors are injected via `ViewModel` from `Coordinator`.
        self.controller.delegate = viewModel.documentBrowserDelegate
    }

    /// Navigation behavior to handle opening video files.
    private lazy var presentVideoAction: (UIDocument) -> Void = { document in
        let coordinator = VideoPlayerCoordinator(document: document) {
            self.dismiss(document: document)
        }
        let controller = UIHostingController(rootView: coordinator.environment)
        self.controller.present(controller, animated: true, completion: nil)
    }

    /// Default navigation behavior for other supported files.
    private lazy var presentDefaultAction: (UIDocument) -> Void = { document in
        let view = DocumentView(document: document) {
            self.dismiss(document: document)
        }
        let controller = UIHostingController(rootView: view)
        self.controller.present(controller, animated: true, completion: nil)
    }

    /// Dismiss document viewer
    private func dismiss(document: UIDocument) -> Void {
        self.controller.dismiss(animated: true) {
            self.viewModel.dismissDocumentAction(document)
        }
    }
}
