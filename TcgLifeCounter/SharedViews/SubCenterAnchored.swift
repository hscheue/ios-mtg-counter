//
//  SubCenterAnchored.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/12/21.
//

import SwiftUI

extension HorizontalAlignment {
    enum SubCenter: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }
    
    static let subCenter = HorizontalAlignment(SubCenter.self)
}

struct SubCenterAnchored<Content>: View where Content : View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack(alignment: .subCenter) {
            Spacer()
                .layoutPriority(-1)
            
            HStack {
                content()
            }
            
            GeometryReader { geo in
                EmptyView()
                    .alignmentGuide(.subCenter) { d in d.width/2 }
            }
            .layoutPriority(-1)
        }
    }
}

extension VerticalAlignment {
    enum HCenter: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
    }
    static let hCenter = VerticalAlignment(HCenter.self)
}

struct VerticalCenterAnchor<Content>: View where Content : View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        HStack(alignment: .hCenter) {
            Spacer()
                .layoutPriority(-1)
            
            VStack {
                content()
            }
            
            GeometryReader { geo in
                EmptyView()
                    .alignmentGuide(.hCenter) { d in d.height / 2 }
            }
            .layoutPriority(-1)
        }
    }
}
