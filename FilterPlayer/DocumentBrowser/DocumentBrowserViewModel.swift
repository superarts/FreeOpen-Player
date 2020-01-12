//
//  DocumentBrowserViewModel.swift
//  FilterPlayer
//
//  Created by Leo on 1/11/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import UIKit

/// Coordinator handles navigation logic
final class DocumentBrowserCoordinator {
    lazy var presentAction: (UIViewController) -> Void = { controller in
        self.controller.present(controller, animated: true, completion: nil)
    }

    lazy var dismissAction: () -> Void = {
        self.controller.dismiss(animated: true) { }
    }

    private let controller: DocumentBrowserViewController

    init(controller: DocumentBrowserViewController) {
        self.controller = controller
    }

//    private mutating func setup() {
//        viewModel = DocumentBrowserViewModel(
//            presentVideoAction: { controller in
//                self.controller.present(controller, animated: true, completion: nil)
//            },
//            presentDefaultAction: { controller in
//                self.controller.present(controller, animated: true, completion: nil)
//            },
//            dismissAction: {
//                self.controller.dismiss(animated: true) { }
//            }
//        )
//        representer.controller.delegate = viewModel.documentBrowserDelegate
//    }
}

struct DocumentBrowserViewModel {

    let presentVideoAction: (UIViewController) -> Void
    let presentDefaultAction: (UIViewController) -> Void
    let dismissAction: () -> Void
    let documentBrowserDelegate: DocumentBrowserViewControllerDelegate

    init(
        presentVideoAction: @escaping (UIViewController) -> Void,
        presentDefaultAction: @escaping (UIViewController) -> Void,
        dismissAction: @escaping () -> Void
    ) {
        self.presentVideoAction = presentVideoAction
        self.presentDefaultAction = presentDefaultAction
        self.dismissAction = dismissAction
        documentBrowserDelegate = DocumentBrowserViewControllerDelegate(
            presentVideoAction: presentVideoAction,
            presentDefaultAction: presentDefaultAction,
            dismissAction: dismissAction
        )
    }
}
