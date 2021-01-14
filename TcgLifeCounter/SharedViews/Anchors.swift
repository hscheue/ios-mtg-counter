//
//  Anchors.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/13/21.
//

import SwiftUI

extension HorizontalAlignment {
    enum HCenter: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }
    
    static let hCenter = HorizontalAlignment(HCenter.self)
}

extension VerticalAlignment {
    enum VCenter: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
    }
    
    static let vCenter = VerticalAlignment(VCenter.self)
}

struct CenterAnchor<Content>: View where Content: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack(
            alignment: Alignment(horizontal: .hCenter, vertical: .vCenter)
        ) {
            GeometryReader { geo in
                EmptyView()
                    .alignmentGuide(.hCenter) { d in d.width / 2 }
                    .alignmentGuide(.vCenter) { d in d.height / 2 }
            }
            
            self.content()
        }
    }
}

struct CenterAnchoredModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .alignmentGuide(.hCenter) { d in d.width / 2 }
            .alignmentGuide(.vCenter) { d in d.height / 2 }
    }
}

extension View {
    func centerAnchored() -> some View {
        self.modifier(CenterAnchoredModifier())
    }
}


