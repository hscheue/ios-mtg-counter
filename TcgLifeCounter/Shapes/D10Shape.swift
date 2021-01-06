//
//  D10Shape.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/5/21.
//

import SwiftUI

// TODO: more insetting for non-edge points
struct D10Shape: Shape, InsettableShape {
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    func path(in rect: CGRect) -> Path {
        let maxX = rect.maxX - insetAmount
        let maxY = rect.maxY - insetAmount
        let minX = rect.minX + insetAmount
        let minY = rect.minY + insetAmount
        
        let midX = rect.midX
        let midY = rect.midY
        
        let outlineDiff: CGFloat = rect.width / 8
        let outOff: CGFloat = 1.2
        
        let point1 = CGPoint(x: midX, y: minY)
        let point2 = CGPoint(x: maxX, y: midY - (2 - outOff) * outlineDiff)
        let point3 = CGPoint(x: maxX, y: midY + (outOff) * outlineDiff)
        let point4 = CGPoint(x: midX, y: maxY)
        let point5 = CGPoint(x: minX, y: midY + (outOff) * outlineDiff)
        let point6 = CGPoint(x: minX, y: midY - (2 - outOff) * outlineDiff)
        
        let point7 = CGPoint(x: point3.x - 1.5 * outlineDiff, y: point3.y)
        let point8 = CGPoint(x: midX, y: point3.y + 0.9 * outlineDiff)
        let point9 = CGPoint(x: point5.x + 1.5 * outlineDiff, y: point3.y)
       
        let points: [CGPoint] = [
            point1,
            point2,
            point3,
            point4,
            point5,
            point6,
            point1,
            point7,
            point3,
            point7,
            point8,
            point4,
            point8,
            point9,
            point1,
            point9,
            point5
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
        }
    }
}

struct D10View: View {
    var body: some View {
        D10Shape()
            .strokeBorder()
            .frame(width: 200, height: 200)
            .scaledToFit() // this for vstacks? do this internally?
    }
}

struct D10Shape_Previews: PreviewProvider {
    static var previews: some View {
        D10View()
    }
}

