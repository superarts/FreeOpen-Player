//
//  AlertView.swift
//  FilterPlayer
//
//  Created by Leo on 1/1/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

final class AboutCoordinator {
//    var dismissAction: (() -> Void)!

//    @Binding var isPresented: Bool
    private var _view: AboutView?

//    init(isPresented: Binding<Bool>) {
//        self._isPresented = isPresented
//    }

    var viewAction: (Binding<Bool>) -> AboutView {
        return { isPresented in
            guard self._view == nil else {
                return self._view!
            }
            //self._view = AboutView(dismiss: self.dismissAction)
//            self._view = AboutView(isPresented: self.$isPresented)
            self._view = AboutView(isPresented: isPresented)
            return self._view!
        }
    }
}

struct AboutView: View {
//    private let dismissAction: () -> Void
//
//    init(dismiss: @escaping () -> Void) {
//        self.dismissAction = dismiss
//    }

    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("FreeOpen Player™")
//            Button("Done", action: dismissAction)
            Button("Done") {
                self.isPresented = false
            }
        }
    }
}

//    static var previews: some View {
//        AboutView { }
//    }
//}
