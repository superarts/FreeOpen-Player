//
//  DocumentBrowserView.swift
//  FilterPlayer
//
//  Created by Leo on 1/6/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

// MARK: - View

struct DocumentBrowserView: View {

    let representer: DocumentBrowserRepresenter

    init() {
        representer = DocumentBrowserRepresenter()
//        setup()
    }

    /// Mutating because navigation logic depends on `representer.controller`
//    private mutating func setup() {
//        let coordinator = DocumentBrowserCoordinator(controller: self.representer.controller) { }
//        viewModel = DocumentBrowserViewModel(
//            presentVideoAction: coordinator.presentAction,
//            presentDefaultAction: coordinator.presentAction,
//            dismissAction: coordinator.dismissAction
//        )
//        representer.controller.delegate = viewModel.documentBrowserDelegate
//    }

    var body: some View {
        representer
    }
}

// MARK: - Wrapper

struct DocumentBrowserRepresenter: UIViewControllerRepresentable {
    typealias RepresenterType = DocumentBrowserRepresenter
    typealias UIViewControllerType = DocumentBrowserViewController

    /// Exposing `controller` so that delegate can be set
    let controller = DocumentBrowserViewController()
//    private let documentBrowserDelegate: DocumentBrowserViewControllerDelegate

//    init(delegate: DocumentBrowserViewControllerDelegate) {
//        controller = DocumentBrowserViewController()
//        self.documentBrowserDelegate = delegate
//    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<RepresenterType>) -> RepresenterType.UIViewControllerType {
        return controller
    }

    func updateUIViewController(_ viewController: RepresenterType.UIViewControllerType, context: UIViewControllerRepresentableContext<RepresenterType>) {
    }
}

// MARK: - Preview

#if DEBUG
//struct DocumentBrowserView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentBrowserRepresenter(delegate: DocumentBrowserViewControllerDelegate())
//    }
//}
#endif
