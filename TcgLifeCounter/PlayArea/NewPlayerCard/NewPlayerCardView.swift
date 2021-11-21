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
    }
}

extension NewPlayerCardView {
    var fillColor: Color {
        colorScheme == .light ? Color.white : Color(white: 0.1)
    }
    func adjustLifeByTap(by adjustment: Int) {
        playerState.inc(by: adjustment)
    }
}

struct NewPlayerCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlayerCardView(playerState: PlayerState())
    }
}
