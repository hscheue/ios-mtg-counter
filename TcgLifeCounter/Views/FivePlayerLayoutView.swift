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
    
    var vertical: Bool {
        verticalSizeClass == nil || verticalSizeClass == .regular
    }
    
    var body: some View {
        HVStack(horizontal: vertical) {
            HVStack(horizontal: !vertical) {
                PlayerCardView(
                    player: players[0],
                    horizontal: !vertical)
                PlayerCardView(
                    player: players[1],
                    horizontal: !vertical)
            }
            
            HVStack(horizontal: !vertical) {
                Group {
                    PlayerCardView(
                        player: players[2],
                        horizontal: !vertical
                    )
                    
                    PlayerCardView(
                        player: players[3],
                        horizontal: !vertical
                    )
                }
                .rotationEffect(
                    outwards && vertical
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
        GeometryReader { geo in
            HVStack(horizontal: !horizontal) {
                HVStack(horizontal: horizontal) {
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
                
                HVStack(horizontal: horizontal) {
                    Group {
                        PlayerCardView(
                            player: players[3],
                            horizontal: horizontal)
                        PlayerCardView(
                            player: players[4],
                            horizontal: horizontal)
                        if players.count == 6 {
                            PlayerCardView(
                                player: players[5],
                                horizontal: horizontal)
                        }
                    }
                    .rotationEffect(
                        outwards && !horizontal
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
        
        FivePlayerLayoutView(
            players: [
                Player(),
                Player(),
                Player(),
                Player(),
                Player()
            ],
            outwards: true
        )
        
        FourPlayerLayoutView(
            players: [
                Player(),
                Player(),
                Player(),
                Player()
            ]
        )
        
        FourPlayerLayoutView(
            players: [
                Player(),
                Player(),
                Player(),
                Player()
            ],
            outwards: true
        )
    }
}
