//
//  D8Shape.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/5/21.
//

import SwiftUI

// TODO: more insetting for non-edge points
struct D8Shape: Shape, InsettableShape {
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
        
        let backgroundInset: CGFloat = rect.width / 4
        
        let point1 = CGPoint(x: midX, y: minY)
        let point2 = CGPoint(x: maxX, y: maxY - backgroundInset)
        let midPointX12 = (point2.x + point1.x) / 2
        let midPointY12 = (point2.y + point1.y) / 2
        let point3 = CGPoint(x: minX, y: maxY - backgroundInset)
        let midPointX13 = (point3.x + point1.x) / 2
        let midPointY13 = (point3.y + point1.y) / 2
        
        let sixty = CGFloat.pi / 6
        
        let cosInset = backgroundInset * cos(sixty)
        let sinInset = backgroundInset * sin(sixty)
        
        let point4 = CGPoint(
            x: midPointX12 + cosInset,
            y: midPointY12 - sinInset)
        let point5 = CGPoint(x: midX, y: maxY)
        let point6 = CGPoint(
            x: midPointX13 - cosInset,
            y: midPointY13 - sinInset)
        
        let points: [CGPoint] = [
            point1,
            point2,
            point3,
            point1,
            point4,
            point2,
            point5,
            point3,
            point6,
            point1
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

struct D8View: View {
    var body: some View {
        D8Shape()
            .strokeBorder()
            .frame(width: 200, height: 200)
            .scaledToFit() // this for vstacks? do this internally?
    }
}

struct D8Shape_Previews: PreviewProvider {
    static var previews: some View {
        D8View()
    }
}

