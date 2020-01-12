//
//  DocumentBrowserViewControllerDelegate.swift
//  FilterPlayer
//
//  Created by Leo on 1/11/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI
import AVFoundation

/// This delegate object separates responsibility of `ViewModel`.
/// It only handles UI Logic. Business logic should be handled by `ViewModel`.
final class DocumentBrowserViewControllerDelegate: NSObject, UIDocumentBrowserViewControllerDelegate {
    /// This action is used to handle opening files.
    private let documentAction: (UIDocument) -> Void

    init(documentAction: @escaping (UIDocument) -> Void) {
        self.documentAction = documentAction
        super.init()
    }

    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        let newDocumentURL: URL? = nil

        // Set the URL for the new document here. Optionally, you can present a template chooser before calling the importHandler.
        // Make sure the importHandler is always called, even if the user cancels the creation request.
        if newDocumentURL != nil {
            importHandler(newDocumentURL, .move)
        } else {
            importHandler(nil, .none)
        }
    }

    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        print("DOC did pick \(documentURLs)")
        guard let sourceURL = documentURLs.first else { return }

        // Present the Document View Controller for the first document that was picked.
        // If you support picking multiple items, make sure you handle them all.
        presentDocument(at: sourceURL)
    }

    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        // Present the Document View Controller for the new newly created document
        presentDocument(at: destinationURL)
    }

    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
    }

    // MARK: Document Presentation

    func presentDocument(at documentURL: URL) {
        let document = Document(fileURL: documentURL)

        // Access the document
        document.open(completionHandler: { success in
            if success {
                /// Picking file is UI logic, which is handled here, in delegate object.
                /// File type handling is business logic, which is handled in `ViewModel`.
                /// Presenting a new `View` is navigation logic, which is handled in `Coordinator`.
                self.documentAction(document)
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
}
