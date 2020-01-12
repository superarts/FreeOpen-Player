//
//  DocumentBrowserCoordinator.swift
//  FilterPlayer
//
//  Created by Leo on 1/11/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

/// Coordinator handles navigation logic
final class DocumentBrowserCoordinator {
    let view = DocumentBrowserView()

    private let controller: DocumentBrowserViewController
    private var viewModel: DocumentBrowserViewModel!

    private lazy var presentVideoAction: (UIDocument) -> Void = { document in
        let view = VideoPlayerView(document: document) {
            self.dismissAction(document)
        }
        let controller = UIHostingController(rootView: view.environment)
        self.controller.present(controller, animated: true, completion: nil)
    }

    private lazy var presentDefaultAction: (UIDocument) -> Void = { document in
        let view = DocumentView(document: document) {
            self.dismissAction(document)
        }
        let controller = UIHostingController(rootView: view)
        self.controller.present(controller, animated: true, completion: nil)
    }

    private lazy var dismissAction: (UIDocument) -> Void = { document in
        self.controller.dismiss(animated: true) {
            self.viewModel.dismissDocumentAction(document)
        }
    }

    init() {
        self.controller = view.representer.controller
        viewModel = DocumentBrowserViewModel(
            presentVideoAction: presentVideoAction,
            presentDefaultAction: presentDefaultAction,
            dismissAction: dismissAction
        )
        self.controller.delegate = viewModel.documentBrowserDelegate
    }
}
