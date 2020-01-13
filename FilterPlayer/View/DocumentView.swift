//
//  DocumentView.swift
//  FilterPlayer
//
//  Created by Leo on 12/31/19.
//  Copyright © 2019 Super Art Software. All rights reserved.
//

import SwiftUI

struct DocumentView: View {
    var document: UIDocument
    var dismiss: () -> Void

    var body: some View {
        VStack {
            Text("This file is not currently supported.")
            HStack {
                Text("File Name")
                    .foregroundColor(.secondary)

                Text(document.fileURL.lastPathComponent)
            }
            Button("Done", action: dismiss)
        }
    }
}

#if DEBUG
struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView(document: UIDocument(fileURL: URL(string: "file:///Users/leo/Public")!)) { }
    }
}
#endif
