//
//  AlertView.swift
//  FilterPlayer
//
//  Created by Leo on 1/1/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

/// This `Coordinator` shows how to provides an action that returns a `View` to be used in a closure.
final class AboutCoordinator {
    private var _view: AboutView?

    var viewAction: (Binding<Bool>) -> AboutView {
        return { isPresented in
            guard self._view == nil else {
                return self._view!
            }
            self._view = AboutView(isPresented: isPresented)
            return self._view!
        }
    }
}

/// No `ViewModel` yet.
struct AboutView: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("FreeOpen Player™")
            Button("Done") {
                self.isPresented = false
            }
        }
    }
}

#if DEBUG
// For `SwiftUI` preview
struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        return AboutCoordinator().viewAction(.constant(false))
    }
}
#endif
