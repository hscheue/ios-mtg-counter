//
//  PlayersLayoutView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI

struct PlayersLayoutView: View {
    let players: [PlayerState]
    var outwards: Bool = false
    
    var body: some View {
        Group {
            if players.count == 1 {
                NewPlayerCardView(playerState: players[0])
            } else if players.count == 2 {
                VStack {
                    NewPlayerCardView(playerState: players[1])
                        .rotationEffect(outwards ? .degrees(180) : .zero)
                    NewPlayerCardView(playerState: players[0])
                }
            } else if players.count == 3 {
                ThreePlayerLayoutView(players: players, outwards: outwards)
            } else if players.count == 4 {
                FourPlayerLayoutView(players: players, outwards: outwards)
            } else if players.count > 4 {
                FiveSixPlayerLayoutView(players: players, outwards: outwards)
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
