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
    }

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

    func makeUIViewController(context: UIViewControllerRepresentableContext<RepresenterType>) -> RepresenterType.UIViewControllerType {
        return controller
    }

    func updateUIViewController(_ viewController: RepresenterType.UIViewControllerType, context: UIViewControllerRepresentableContext<RepresenterType>) {
    }
}

// MARK: - Preview

#if DEBUG
struct DocumentBrowserView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentBrowserRepresenter()
    }
}
#endif
