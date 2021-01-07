//
//  FivePlayerLayoutView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/26/20.
//

import SwiftUI

struct FourPlayerLayoutView: View {
    let players: [Player]
    var outwards: Bool = false
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var vertical: Bool { verticalSizeClass != .regular }
    
    var body: some View {
        HVStack(horizontal: !vertical) {
            HVStack(horizontal: vertical) {
                ForEach(0..<2, id: \.self) { index in
                    PlayerCardView(
                        player: players[index],
                        horizontal: vertical)
                }
                .rotationEffect(outwards && vertical ? .degrees(180) : .zero)
            }
            
            HVStack(horizontal: vertical) {
                ForEach(2..<4, id: \.self) { index in
                    PlayerCardView(
                        player: players[index],
                        horizontal: vertical)
                }
                .rotationEffect(outwards && !vertical ? .degrees(180) : .zero)
            }
        }
    }
}

// is also six player
struct FivePlayerLayoutView: View {
    let players: [Player]
    var outwards: Bool = false
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var vertical: Bool { verticalSizeClass == .regular }
    
    var body: some View {
        GeometryReader { geo in
            HVStack(horizontal: vertical) {
                HVStack(horizontal: !vertical) {
                    ForEach(0..<3, id: \.self) { index in
                        PlayerCardView(
                            player: players[index],
                            horizontal: !vertical)
                    }
                    .rotationEffect(outwards && !vertical ? .degrees(180) : .zero)
                }
                
                HVStack(horizontal: !vertical) {
                    ForEach(3..<6, id: \.self) { index in
                        if players.count > index {
                            PlayerCardView(
                                player: players[index],
                                horizontal: !vertical)
                        }
                    }
                    .rotationEffect(outwards && vertical ? .degrees(180) : .zero)
                }
            }
        }
    }
}

struct FivePlayerLayoutView_Previews: PreviewProvider {
    static let players = (0..<6).map { _ in Player() }
    static var previews: some View {
        FivePlayerLayoutView(players: Array(players[..<5]))
        FivePlayerLayoutView(players: Array(players[..<5]), outwards: true)
        FivePlayerLayoutView(players: Array(players[..<6]))
        FivePlayerLayoutView(players: Array(players[..<6]), outwards: true)
        FourPlayerLayoutView(players: Array(players[..<4]))
        FourPlayerLayoutView(players: Array(players[..<4]), outwards: true)
    }
}
