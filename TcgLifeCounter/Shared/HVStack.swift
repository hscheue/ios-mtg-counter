//
//  HVStack.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/6/21.
//

import SwiftUI

struct HVStack<Content>: View where Content : View {
    let horizontal: Bool
    let alignment: Alignment
    var content: () -> Content
    
    var body: some View {
        if horizontal {
            HStack(
                alignment: alignment.vertical,
                spacing: 0,
                content: content)
        } else {
            VStack(
                alignment: alignment.horizontal,
                spacing: 0,
                content: content)
        }
    }
    
    init(
        horizontal: Bool = true,
        alignment: Alignment = .center,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.horizontal = horizontal
        self.alignment = alignment
        self.content = content
    }
}
