//
//  FivePlayerLayoutView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/26/20.
//

import SwiftUI

struct FourPlayerLayoutView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    let players: [Player]
    var outwards: Bool = false
    
    var horizontal: Bool {
        verticalSizeClass == nil || verticalSizeClass == .compact
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                PlayerCardView(
                    player: players[0],
                    horizontal: horizontal
                )
                PlayerCardView(
                    player: players[1],
                    horizontal: horizontal
                )
            }
            
            VStack(spacing: 0) {
                PlayerCardView(
                    player: players[2],
                    horizontal: horizontal
                )
                .rotationEffect(
                    outwards
                        ? .degrees(180)
                        : .zero)
                PlayerCardView(
                    player: players[3],
                    horizontal: horizontal
                )
                .rotationEffect(
                    outwards
                        ? .degrees(180)
                        : .zero)
            }
        }
    }
}

// is also six player
struct FivePlayerLayoutView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    let players: [Player]
    var outwards: Bool = false
    
    var horizontal: Bool {
        verticalSizeClass == nil || verticalSizeClass == .compact
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                PlayerCardView(
                    player: players[0],
                    horizontal: horizontal)
                PlayerCardView(
                    player: players[1],
                    horizontal: horizontal)
                PlayerCardView(
                    player: players[2],
                    horizontal: horizontal)
            }
            
            VStack(spacing: 0) {
                PlayerCardView(
                    player: players[3],
                    horizontal: horizontal)
                    .rotationEffect(
                        outwards
                            ? .degrees(180)
                            : .zero)
                PlayerCardView(
                    player: players[4],
                    horizontal: horizontal)
                    .rotationEffect(
                        outwards
                            ? .degrees(180)
                            : .zero)
                if players.count == 6 {
                    PlayerCardView(
                        player: players[5],
                        horizontal: horizontal)
                        .rotationEffect(
                            outwards
                                ? .degrees(180)
                                : .zero)
                }
            }
        }
    }
}

struct FivePlayerLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        FivePlayerLayoutView(
            players: [
                Player(),
                Player(),
                Player(),
                Player(),
                Player()
            ]
        )
    }
}
