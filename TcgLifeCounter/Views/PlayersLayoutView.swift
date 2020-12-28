//
//  PlayersLayoutView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI

struct TwoPlayerLayoutView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    let players: [Player]
    
    var body: some View {
        if (horizontalSizeClass == nil || horizontalSizeClass == .compact) {
            VStack(spacing: 0) {
                ForEach(players) {
                    PlayerCardView(player: $0)
                }
            }
        } else {
            HStack(spacing: 0) {
                ForEach(players) {
                    PlayerCardView(player: $0)
                }
            }
        }
    }
}

struct PlayersLayoutView: View {
    let players: [Player]
    
    var body: some View {
        if players.count == 4 {
            FourPlayerLayoutView(players: players)
        } else if players.count > 4 {
            FivePlayerLayoutView(players: players)
        } else if players.count == 2 {
            TwoPlayerLayoutView(players: players)
        } else {
            TwoPlayerLayoutView(players: players)
        }
    }
}

struct PlayersLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersLayoutView(players: [Player(), Player()])
    }
}
