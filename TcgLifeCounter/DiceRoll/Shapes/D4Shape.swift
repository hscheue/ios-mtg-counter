//
//  D4Shape.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/5/21.
//

import SwiftUI

struct D4Shape: Shape, InsettableShape {
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    func path(in rect: CGRect) -> Path {
        let points: [CGPoint] = [
            .init(
                x: rect.midX,
                y: rect.minY + insetAmount),
            .init(
                x: rect.maxX - insetAmount,
                y: rect.maxY - insetAmount),
            .init(
                x: rect.minX + insetAmount,
                y: rect.maxY - insetAmount),
        ]
            
        return Path { path in
            for index in 0..<points.count {
                let point = points[index]
                
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.addLine(to: points[0])
        }
    }
}

struct D4View: View {
    var body: some View {
        D4Shape()
            .strokeBorder()
            .frame(width: 200, height: 200)
            .scaledToFit() // this for vstacks? do this internally?
    }
}

struct D4Shape_Previews: PreviewProvider {
    static var previews: some View {
        D4View()
    }
}
