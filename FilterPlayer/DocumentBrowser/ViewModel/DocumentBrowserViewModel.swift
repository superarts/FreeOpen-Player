//
//  DocumentBrowserViewModel.swift
//  FilterPlayer
//
//  Created by Leo on 1/11/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import AVFoundation
import UIKit

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

    private func action(document: UIDocument) {
        let type = AVFileType(document.fileType ?? "")
        if [.mp4, .mov, .m4v].contains(type) {
            self.presentVideoAction(document)
        } else {
            self.presentDefaultAction(document)
        }
    }
}
