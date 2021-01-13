//
//  HalfRoundedRect.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/12/21.
//

import SwiftUI

struct HalfRoundedRect: Shape {
    enum Side {
        case top, right, bottom, left
        
        var corners: UIRectCorner {
            switch self {
            case .top:
                return [.topLeft, .topRight]
            case .right:
                return [.topRight, .bottomRight]
            case .bottom:
                return [.bottomRight, .bottomLeft]
            case .left:
                return [.bottomLeft, .topLeft]
            }
        }
    }
    
    init(_ side: Side) {
        self.side = side
    }
    
    let side: Side
    
    func path(in rect: CGRect) -> Path {
        Path(UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: side.corners,
                cornerRadii: CGSize(width: 43, height: 43)).cgPath)
    }
}
