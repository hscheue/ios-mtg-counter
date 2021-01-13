//
//  PresentedLifeView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/13/21.
//

import SwiftUI

struct PresentedLifeView: View {
    let changeLife: Int
    let currentLife: Int
    let horizontal: Bool
    
    private var changeColor: Color {
        changeLife > 0 ? Color.green : Color.red
    }
    @State private var changeOpacity: Double = 0
    @State private var changeOffset: CGFloat = 10
    
    var body: some View {
        VerticalCenterAnchor {
            VStack {
                if changeLife != 0 {
                    Text("\(changeLife, specifier: "%+d")")
                        .foregroundColor(changeColor)
                        .font(.system(size: 32))
                        .opacity(changeOpacity)
                        .offset(x: 0, y: changeOffset)
                }
                
                Text("\(currentLife)")
                    .font(.system(size: 48))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .alignmentGuide(.hCenter) { dimension in
                        dimension.height / 2
                    }
                
                Text("Life")
                    .font(.system(size: 16))
            }
        }
        .onChange(of: changeLife) { _ in
            changeOpacity = 0
            changeOffset = 10
            withAnimation {
                changeOpacity = 1
                changeOffset = 0
            }
        }
        .rotationEffect(horizontal ? .zero : .degrees(90))
        .allowsHitTesting(false)
    }
}

struct PresentedLifeView_Previews: PreviewProvider {
    static var previews: some View {
        PresentedLifeView(
            changeLife: 1,
            currentLife: 20,
            horizontal: true
        )
    }
}
