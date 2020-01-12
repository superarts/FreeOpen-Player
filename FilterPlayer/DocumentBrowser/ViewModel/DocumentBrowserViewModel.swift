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
final class DocumentBrowserViewModel {
    /// Instead of an extension, we use composition with a stand-alone delegate object.
    private(set) var documentBrowserDelegate: DocumentBrowserViewControllerDelegate!
    /// This action handles business operations when a file viewer is closed
    let dismissDocumentAction: (UIDocument) -> Void = { document in
        document.close(completionHandler: nil)
    }

    /// Navigation logic file opening is injected from `Coordinator`.
    private let presentVideoAction: (UIDocument) -> Void
    private let presentDefaultAction: (UIDocument) -> Void

    init(
        presentVideoAction: @escaping (UIDocument) -> Void,
        presentDefaultAction: @escaping (UIDocument) -> Void
    ) {
        self.presentVideoAction = presentVideoAction
        self.presentDefaultAction = presentDefaultAction
        documentBrowserDelegate = DocumentBrowserViewControllerDelegate(
            documentAction: documentAction
        )
    }

    private lazy var documentAction: (UIDocument) -> Void = { document in
        let type = AVFileType(document.fileType ?? "")
        if [.mp4, .mov, .m4v].contains(type) {
            self.presentVideoAction(document)
        } else {
            self.presentDefaultAction(document)
        }
    }
}
