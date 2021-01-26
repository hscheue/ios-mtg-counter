//
//  NextPresentedLifeView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/13/21.
//

//
//  CommitChangeStateView.swift
//  MatchedGeometry
//
//  Created by harry scheuerle on 1/13/21.
//

import SwiftUI

struct CommitChangeStateView: View {
    @ObservedObject var playerState: PlayerState
    let horizontal: Bool
    
    @Namespace var lifetotal
    
    
    @State private var changeOpacity: Double = 0
    @State private var changeOffset: CGFloat = 10
    
    var diff: Int? {
        if let curr = playerState.current?.value {
            let prev = playerState.previous?.value
                ?? playerState.starting
            let diff = curr - prev
            
            return diff != 0 ? diff : nil
        }
        return nil
    }
    private var changeColor: Color {
        diff ?? 0 > 0 ? Color.green : Color.red
    }
    
    var body: some View {
        func testView() -> some View {
            HStack(alignment: .lastTextBaseline) {
                if let prev = playerState.previous {
                    Text("\(prev.value)")
                        .font(.system(size: 32))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .matchedGeometryEffect(id: prev.id, in: lifetotal)
                }
                VStack {
                    if let curr = playerState.current?.value,
                       let prev = playerState.previous?.value
                        ?? playerState.starting,
                       let diff = curr - prev,
                       diff != 0,
                       playerState.isChanging {
                        Text("\(diff, specifier: "%+d")")
                            .foregroundColor(changeColor)
                            .font(.system(size: 32))
                            .opacity(changeOpacity)
                            .offset(x: 0, y: changeOffset)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    
                    
                    if let curr = playerState.current {
                        Text("\(curr.value)")
                            .font(.system(size: 64))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .matchedGeometryEffect(id: curr.id, in: lifetotal)
                            .centerAnchored()
                    }
                }
                
            }
        }
        
        return CenterAnchor {
            VStack {
                HStack {
                    if playerState.changeAnimated {
                        testView()
                    } else if playerState.isChanging {
                        testView()
                    } else {
                        testView()
                    }
                }
            }
            .layoutPriority(-1)
        }
        .onChange(of: diff) { _ in
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
