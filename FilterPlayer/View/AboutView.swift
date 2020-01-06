//
//  AlertView.swift
//  FilterPlayer
//
//  Created by Leo on 1/1/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    private let dismissAction: () -> Void

    init(dismiss: @escaping () -> Void) {
        self.dismissAction = dismiss
    }

    var body: some View {
        VStack {
            Text("FreeOpen Player™")
            Button("Done", action: dismissAction)
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView { }
    }
}
