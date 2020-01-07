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
    var body: some View {
        DocumentBrowserRepresenter()
    }
}

// MARK: - Wrapper

struct DocumentBrowserRepresenter: UIViewControllerRepresentable {
    typealias RepresenterType = DocumentBrowserRepresenter
    typealias UIViewControllerType = DocumentBrowserViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<RepresenterType>) -> RepresenterType.UIViewControllerType {
        return DocumentBrowserViewController()
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
