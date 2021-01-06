//
//  D100Shape.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/5/21.
//

import SwiftUI

// TODO: more insetting for non-edge points
struct D100Shape: Shape, InsettableShape {
    var insetAmount: CGFloat = 0
    let sides: CGFloat = 15
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    func path(in rect: CGRect) -> Path {
        let midX = rect.midX
        let midY = rect.midY
        
        let outerRadius = min(rect.width, rect.height) / 2 - insetAmount
        let insetRadius = 0.8 * outerRadius
       
        var outlinePoints: [CGPoint] {
            let radians = stride(
                from: -CGFloat.pi / sides / 2,
                to: 2 * CGFloat.pi,
                by: CGFloat.pi / sides)
            var arr = [CGPoint]()
            for rad in radians {
                arr.append(CGPoint(
                            x: outerRadius * cos(rad) + midX,
                            y: outerRadius * sin(rad) + midY))
            }
            return arr
        }
        
        var inlinePoints: [CGPoint] {
            let radians = stride(
                from: -CGFloat.pi / 2 / sides,
                to: 2 * CGFloat.pi,
                by: CGFloat.pi * 2 / sides)
            var arr = [CGPoint]()
            for rad in radians {
                arr.append(CGPoint(
                            x: insetRadius * cos(rad) + midX,
                            y: insetRadius * sin(rad) + midY))
            }
            return arr
        }
            
        return Path { path in
            for index in 0..<outlinePoints.count {
                let point = outlinePoints[index]
                
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            
            for index in 0..<inlinePoints.count {
                let point = inlinePoints[index]
                
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            
            for outerIndex in stride(from: 0, through: outlinePoints.count, by: 2) {
                path.move(to: outlinePoints[outerIndex])
                path.addLine(to: inlinePoints[outerIndex / 2])
            }
        }
    }
}

struct D100View: View {
    var body: some View {
        D100Shape()
            .strokeBorder()
            .frame(width: 200, height: 200)
            .scaledToFit() // this for vstacks? do this internally?
    }
}

struct D100Shape_Previews: PreviewProvider {
    static var previews: some View {
        D100View()
    }
}

