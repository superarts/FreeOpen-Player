//
//  DocumentBrowserViewController.swift
//  FilterPlayer
//
//  Created by Leo on 12/31/19.
//  Copyright © 2019 Super Art Software. All rights reserved.
//

import UIKit

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

