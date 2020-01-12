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
    let view = DocumentBrowserView()

    private let controller: DocumentBrowserViewController
    private var viewModel: DocumentBrowserViewModel!
//    private let dismissDocumentAction: (UIDocument) -> Void

    //    lazy var presentAction: (UIViewController) -> Void = { controller in
    //        self.controller.present(controller, animated: true, completion: nil)
    //    }
    //
    private lazy var presentVideoAction: (UIDocument) -> Void = { document in
        let view = VideoPlayerView(document: document) {
            self.controller.dismiss(animated: true) {
                self.viewModel.dismissDocumentAction(document)
            }
        }
        let controller = UIHostingController(rootView: view.environment)
        self.controller.present(controller, animated: true, completion: nil)
    }

    private lazy var presentDefaultAction: (UIDocument) -> Void = { document in
        let view = DocumentView(document: document) {
            self.controller.dismiss(animated: true) {
                self.viewModel.dismissDocumentAction(document)
            }
        }
        let controller = UIHostingController(rootView: view)
        self.controller.present(controller, animated: true, completion: nil)
    }

    private lazy var dismissAction: (UIDocument) -> Void = { document in
        self.controller.dismiss(animated: true) {
            self.viewModel.dismissDocumentAction(document)
        }
    }

    //init(controller: DocumentBrowserViewController, dismissDocumentAction: @escaping (UIDocument) -> Void) { }
    init() {
        self.controller = view.representer.controller
        viewModel = DocumentBrowserViewModel(
            presentVideoAction: presentVideoAction,
            presentDefaultAction: presentDefaultAction,
            dismissAction: dismissAction
        )
        self.controller.delegate = viewModel.documentBrowserDelegate
//        self.dismissDocumentAction = viewModel.dismissDocumentAction
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

import AVFoundation
import SwiftUI

/// Business logic
struct DocumentBrowserViewModel {

    let documentBrowserDelegate: DocumentBrowserViewControllerDelegate
    let dismissDocumentAction: (UIDocument) -> Void = { document in
        document.close(completionHandler: nil)
    }

    private let presentVideoAction: (UIDocument) -> Void
    private let presentDefaultAction: (UIDocument) -> Void
    private let dismissAction: (UIDocument) -> Void

    init(
        presentVideoAction: @escaping (UIDocument) -> Void,
        presentDefaultAction: @escaping (UIDocument) -> Void,
        dismissAction: @escaping (UIDocument) -> Void
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

    var handleVideoAction: ((UIDocument) -> Void)!

    private func action(document: UIDocument) {
        let type = AVFileType(document.fileType ?? "")
        if [.mp4, .mov, .m4v].contains(type) {
            //                    let viewModel = VideoPlayerViewModel(document: document) {
            //                        self.closeDocument(document)
            //                    }
            //                    let controller = UIHostingController(rootView: viewModel.environment)
//            self.handleVideoAction(document)
//            let view = VideoPlayerView(document: document) {
//                self.closeDocument(document)
//            }
//            let controller = UIHostingController(rootView: view.environment)
            self.presentVideoAction(document)
            //                    self.present(controller, animated: true, completion: nil)
        } else {
            // Display the content of the document:
//            let view = DocumentView(document: document, dismiss: {
//                self.closeDocument(document)
//            })
//
//            let controller = UIHostingController(rootView: view)
            self.presentDefaultAction(document)
            //                    self.present(documentViewController, animated: true, completion: nil)
        }
    }
}
