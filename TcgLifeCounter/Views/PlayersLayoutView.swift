//
//  PlayersLayoutView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI

struct TwoPlayerLayoutView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    let players: [Player]
    
    var body: some View {
        if verticalSizeClass == nil || verticalSizeClass == .regular {
            VStack(spacing: 0) {
                ForEach(players) {
                    PlayerCardView(player: $0, horizontal: true)
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
        } else {
            TwoPlayerLayoutView(players: players)
        }
    }
}

struct PlayersLayoutView_Previews: PreviewProvider {
    static let players = (0..<6).map { _ in Player() }

    static var previews: some View {
        ForEach(2...6, id: \.self) { num in
            PlayersLayoutView(players: Array(players[..<num]))
                .previewDisplayName("\(num) Players iPhone")
                .previewDevice("iPhone 11 Pro Max")
            
            PlayersLayoutView(players: Array(players[..<num]))
                .previewDisplayName("\(num) Players iPad")
                .previewDevice("iPad Pro (12.9-inch) (4th generation)")
        }
    }
}
