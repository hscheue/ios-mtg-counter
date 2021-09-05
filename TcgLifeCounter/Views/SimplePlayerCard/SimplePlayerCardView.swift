//
//  SimplePlayerCardView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 7/22/21.
//

import SwiftUI
import Combine

struct SimplePlayerCardView: View {
    // MARK: Initialized
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: Constructed
    @ObservedObject var player: PlayerState
    var horizontal = true
    
    // MARK: View Body
    var body: some View {
        ZStack {
            Rectangle()
                .fill(fillColor)
            
            Rectangle()
                .fill(opacityGradientHorizontal)
            
            Rectangle()
                .fill(opacityGradientVertical)
            
            HVStack(horizontal: horizontal) {
                ButtonView(
                    player: player,
                    horizontal: horizontal,
                    clickAction: { adjustLifeByTap(by: -1) }
                )
                ButtonAddView(
                    player: player,
                    horizontal: horizontal,
                    clickAction: { adjustLifeByTap(by: 1) }
                )
            }
            
            CommitChangeStateView(
                playerState: player,
                horizontal: horizontal
            )
        }
        .clipShape(RoundedRectangle(cornerRadius: 42.0, style: .continuous))
        .shadow(color: shadowColor, radius: 7, x: 2.0, y: 2.0)
        .padding(4)
    }
    
    // MARK: Computed
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
    var fillColor: Color {
        colorScheme == .light ? Color.white : Color(white: 0.1)
    }
    var shadowColor: Color {
        colorScheme == .light ? Color.gray.opacity(0.4) : Color.black
    }
    
    // MARK: Functions
    func adjustLifeByTap(by adjustment: Int) {
        player.inc(by: adjustment)
    }
}

struct SimplePlayerCardView_Previews: PreviewProvider {
    
    static let players = (0..<2).map { _ in PlayerState() }
    
    static var previews: some View {
        SimplePlayerCardView(
            players: Array(players[..<2]),
            outwards: false
        )
//        PlayersLayoutView(
//            players: Array(players[..<2]),
//            outwards: false
//        ).preferredColorScheme(.dark)
        SimplePlayerCardView(player: PlayerState(), horizontal: true)
            .previewDisplayName("Horizontal Display")
        SimplePlayerCardView(player: PlayerState(), horizontal: false)
            .previewDisplayName("Vertical Display")
        SimplePlayerCardView(player: PlayerState(), horizontal: true)
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
    }
}
