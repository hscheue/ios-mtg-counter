//
//  FivePlayerLayoutView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/26/20.
//

import SwiftUI

struct FourPlayerLayoutView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    let players: [Player]
    
    var horizontal: Bool {
        horizontalSizeClass == .regular
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                PlayerCardView(player: players[0], horizontal: horizontal)
                PlayerCardView(player: players[1], horizontal: horizontal)
            }
            
            VStack(spacing: 0) {
                PlayerCardView(player: players[2], horizontal: horizontal)
                PlayerCardView(player: players[3], horizontal: horizontal)
            }
        }
    }
}

struct FivePlayerLayoutView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    let players: [Player]
    
    var horizontal: Bool {
        horizontalSizeClass == .regular
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                PlayerCardView(player: players[0], horizontal: horizontal)
                PlayerCardView(player: players[1], horizontal: horizontal)
                PlayerCardView(player: players[2], horizontal: horizontal)
            }
            
            VStack(spacing: 0) {
                PlayerCardView(player: players[3], horizontal: horizontal)
                PlayerCardView(player: players[4], horizontal: horizontal)
                if players.count == 6 {
                    PlayerCardView(player: players[5], horizontal: horizontal)
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
