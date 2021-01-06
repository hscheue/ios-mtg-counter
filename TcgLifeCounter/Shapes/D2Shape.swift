//
//  D2Shape.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/5/21.
//

import SwiftUI

struct D2Shape: Shape, InsettableShape {
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }

    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2 - insetAmount
        
        return Path { path in
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: radius,
                startAngle: .zero,
                endAngle: .degrees(360),
                clockwise: false
            )
        }
    }
}

struct D2View: View {
    var body: some View {
        D2Shape()
            .strokeBorder()
    }
}

struct D2Shape_Previews: PreviewProvider {
    static var previews: some View {
        D2View()
    }
}
