//
//  ScreenLockModifier.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 7/19/21.
//

import SwiftUI

struct ScreenLockModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                UIApplication.shared.isIdleTimerDisabled = true
            }
            .onDisappear {
                UIApplication.shared.isIdleTimerDisabled = false
            }
    }
}

extension View {
    func keepAwake() -> some View {
        modifier(ScreenLockModifier())
    }
}
