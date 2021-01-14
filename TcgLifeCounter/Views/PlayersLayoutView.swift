//
//  PlayersLayoutView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI

struct TwoPlayerLayoutView: View {
    let players: [PlayerState]
    var outwards = false
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var isVerticalStack: Bool { verticalSizeClass != .compact }
    
    var body: some View {
        HVStack(horizontal: !isVerticalStack) {
            ForEach(0..<players.count, id: \.self) {
                PlayerCardView(player: players[$0])
                    .rotationEffect(
                        outwards && $0 == 0
                            ? .degrees(180)
                            : .zero)
            }
        }
    }
}

struct ThreePlayerLayoutView: View {
    let players: [PlayerState]
    var outwards: Bool = false
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var isVerticalStack: Bool { verticalSizeClass != .compact }
    
    var body: some View {
        if !outwards {
            TwoPlayerLayoutView(players: players)
        } else {
            GeometryReader { geo in
                let isLandscape = geo.size.width < geo.size.height
                
                HVStack(horizontal: !isLandscape) {
                    HVStack(horizontal: isLandscape) {
                        ForEach(0..<2, id: \.self) { index in
                            PlayerCardView(player: players[index], horizontal: !isVerticalStack)
                                .rotationEffect(!isLandscape && index == 0 ? .degrees(180) : .zero)
                                .rotationEffect(isLandscape && index == 1 ? .degrees(180) : .zero)
                        }
                    }
                    .frame(
                        width: geo.size.width * (!isLandscape ? 0.66 : 1),
                        height: geo.size.height * (isLandscape ? 0.66 : 1)
                    )
                    PlayerCardView(player: players[2], horizontal: isLandscape)
                        .rotationEffect(!isLandscape ? .degrees(180) : .zero)
                }
            }
        }
    }
}

struct PlayersLayoutView: View {
    let players: [PlayerState]
    var outwards: Bool = false
    
    var body: some View {
        Group {
            if players.count == 3 {
                ThreePlayerLayoutView(players: players, outwards: outwards)
            } else if players.count == 4 {
                FourPlayerLayoutView(players: players, outwards: outwards)
            } else if players.count > 4 {
                FiveSixPlayerLayoutView(players: players, outwards: outwards)
            } else {
                TwoPlayerLayoutView(players: players, outwards: outwards)
            }
        }
        .padding(4)
    }
}

struct PlayersLayoutView_Previews: PreviewProvider {
    static let players = (0..<6).map { _ in PlayerState() }
    
    static var previews: some View {
        ForEach(2...6, id: \.self) { num in
            ForEach([false, true], id: \.self) { outwards in
                PlayersLayoutView(
                    players: Array(players[..<num]),
                    outwards: outwards
                )
                .previewDisplayName("\(num) Players iPhone\(outwards ? " outwards" : "")")
            }
        }
    }
}
