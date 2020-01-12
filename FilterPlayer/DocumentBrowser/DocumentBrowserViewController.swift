//
//  DocumentBrowserViewController.swift
//  FilterPlayer
//
//  Created by Leo on 12/31/19.
//  Copyright © 2019 Super Art Software. All rights reserved.
//

import UIKit
import SwiftUI
import AVFoundation

class DocumentBrowserViewController: UIDocumentBrowserViewController {

    var documentBrowserDelegate: UIDocumentBrowserViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        allowsDocumentCreation = false
        allowsPickingMultipleItems = false
        
        // Update the style of the UIDocumentBrowserViewController
        // browserUserInterfaceStyle = .dark
        // view.tintColor = .white
        
        // Specify the allowed content types of your application via the Info.plist.
        
        // Do any additional setup after loading the view.
    }
}

// MARK: UIDocumentBrowserViewControllerDelegate

class DocumentBrowserViewControllerDelegate: NSObject, UIDocumentBrowserViewControllerDelegate {

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
                let type = AVFileType(document.fileType ?? "")
                if [.mp4, .mov, .m4v].contains(type) {
                    self.presentVideoAction(document)
                } else {
                    self.presentDefaultAction(document)
                }
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }

    func closeDocument(_ document: Document) {
        dismissAction(document)
    }
}
