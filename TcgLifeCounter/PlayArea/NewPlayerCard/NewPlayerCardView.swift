//
//  NewPlayerCardView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 11/20/21.
//

import SwiftUI

struct MinusText: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Text("Decrease life")
                .hidden()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Text("-1")
                .font(.system(size: 32))
                .offset(x: 30,y: -15)
                .foregroundColor(.gray)
                .allowsHitTesting(false)
        }
    }
}

struct AdditionText: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Text("Increase life")
                .hidden()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Text("+1")
                .offset(x: -30, y: -15)
                .font(.system(size: 32))
                .foregroundColor(.gray)
                .allowsHitTesting(false)
        }
    }
}


struct NewPlayerCardView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var playerState: PlayerState
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(fillColor)
            
            Rectangle()
                .fill(opacityGradientHorizontal)
            
            Rectangle()
                .fill(opacityGradientVertical)
            
            HVStack() {
                NewButtonView(
                    playerState: playerState,
                    clickAction: { adjustLifeByTap(by: -1) },
                    content: MinusText()
                )
                NewButtonView(
                    playerState: playerState,
                    clickAction: { adjustLifeByTap(by: +1) },
                    content: AdditionText()
                )
            }
            
            NewLifeCounterView(
                playerState: playerState,
                horizontal: true
            )
        }
        .clipShape(RoundedRectangle(cornerRadius: 42.0, style: .continuous))
        .shadow(color: shadowColor, radius: 5, x: 2.0, y: 2.0)
    }
}

extension NewPlayerCardView {
    var fillColor: Color {
        colorScheme == .light ? Color.white : Color(white: 0.1)
    }
    func adjustLifeByTap(by adjustment: Int) {
        playerState.inc(by: adjustment)
    }
    var gradient: Gradient {
        let base = colorScheme == .dark
            ? Color.white
            : Color.black
        
        return .init(stops: [
            Gradient.Stop(color: base.opacity(0.05), location: 0.05),
            Gradient.Stop(color: base.opacity(0.01), location: 0.1),
            Gradient.Stop(color: base.opacity(0), location: 0.3),
            Gradient.Stop(color: base.opacity(0), location: 0.7),
            Gradient.Stop(color: base.opacity(0.01), location: 0.9),
            Gradient.Stop(color: base.opacity(0.05), location: 0.95),
        ])
    }
    var opacityGradientHorizontal: LinearGradient {
        .init(gradient: gradient, startPoint: .leading, endPoint: .trailing)
    }
    var opacityGradientVertical: LinearGradient {
        .init(gradient: gradient, startPoint: .top, endPoint: .bottom)
    }
    var shadowColor: Color {
        colorScheme == .light ? Color.gray.opacity(0.4) : Color.black
    }
}

struct NewPlayerCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlayerCardView(playerState: PlayerState())
    }
}
