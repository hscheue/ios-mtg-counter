//
//  RotationGeometryView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 11/20/21.
//

import SwiftUI

struct RotationGeometryLeftView<Content>: View where Content : View {
    var content: Content
    var body: some View {
        GeometryReader { geo in
            content
                .rotationEffect(.degrees(90), anchor: .bottomLeading)
                .frame(width: geo.size.height, height: geo.size.width)
                .offset(y: -geo.size.width)
        }
    }
}

struct RotationGeometryRightView<Content>: View where Content : View {
    var content: Content
    var body: some View {
        GeometryReader { geo in
            content
                .rotationEffect(.degrees(-90), anchor: .topLeading)
                .frame(width: geo.size.height, height: geo.size.width)
                .offset(y: geo.size.height)
        }
    }
}
