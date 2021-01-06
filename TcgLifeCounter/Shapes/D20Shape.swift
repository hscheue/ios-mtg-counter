//
//  D20Shape.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/5/21.
//

import SwiftUI

// TODO: more insetting for non-edge points
struct D20Shape: Shape, InsettableShape {
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    func path(in rect: CGRect) -> Path {
        let midX = rect.midX
        let midY = rect.midY
        
        let outerRadius = min(rect.width, rect.height) / 2 - insetAmount
        
        var outlinePoints: [CGPoint] {
            let radians = stride(
                from: -CGFloat.pi / 6,
                to: 2 * CGFloat.pi,
                by: CGFloat.pi * 2 / 6
            )
            var arr = [CGPoint]()
            for rad in radians {
                arr.append(CGPoint(
                            x: outerRadius * cos(rad) + midX,
                            y: outerRadius * sin(rad) + midY))
            }
            return arr
        }
        
        let row1 = outlinePoints[0].y
        let row2 = outlinePoints[1].y
        let rowDiff = row2 - row1
        let pointA = midX - rowDiff / 2
        let pointB = midX + rowDiff / 2
        
        let point1 = CGPoint(x: pointB, y: row2)
        let point2 = CGPoint(x: midX, y: row1)
        let point3 = CGPoint(x: pointA, y: row2)

        return Path { path in
            for index in 0..<outlinePoints.count {
                let point = outlinePoints[index]
                
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.addLine(to: point1)
            path.addLine(to: point2)
            path.addLine(to: point3)
            path.addLine(to: outlinePoints[4])
            path.addLine(to: point2)
            path.addLine(to: outlinePoints[0])
            path.move(to: outlinePoints[1])
            path.addLine(to: point1)
            path.addLine(to: point3)
            path.addLine(to: outlinePoints[3])
            
            path.move(to: CGPoint(x: midX, y: row1))
            path.addLine(to: outlinePoints[5])
            
            path.move(to: point1)
            path.addLine(to: outlinePoints[2])
            
            path.move(to: point3)
            path.addLine(to: outlinePoints[2])
        }
    }
}

struct D20View: View {
    var body: some View {
        D20Shape()
            .strokeBorder()
            .frame(width: 200, height: 200)
            .scaledToFit() // this for vstacks? do this internally?
    }
}

struct D20Shape_Previews: PreviewProvider {
    static var previews: some View {
        D20View()
    }
}

