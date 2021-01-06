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
    var outwards = false
    
    var isVerticalStack: Bool {
        verticalSizeClass == nil || verticalSizeClass == .regular
    }
    
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

// Should be between stack and corners! single scorekeeper means same direction no matter what!
struct ThreePlayerLayoutView: View {
    let players: [Player]
    var outwards: Bool = false
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var isVerticalStack: Bool {
        verticalSizeClass == nil || verticalSizeClass == .regular
    }
    
    var body: some View {
        if !outwards {
            TwoPlayerLayoutView(players: players)
        } else {
            GeometryReader { geo in
                if geo.size.width < geo.size.height {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            PlayerCardView(
                                player: players[0],
                                horizontal: false
                            )
                            PlayerCardView(
                                player: players[1],
                                horizontal: false
                            )
                                .rotationEffect(.degrees(180))
                        }.frame(
                            width: geo.size.width,
                            height: geo.size.height * 0.66)
                        PlayerCardView(player: players[2])
                    }
                } else {
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            PlayerCardView(
                                player: players[0]
                            )
                            PlayerCardView(
                                player: players[1]
                            )
                                
                        }.frame(
                            width: geo.size.width * 0.66,
                            height: geo.size.height)
                        PlayerCardView(player: players[2], horizontal: false)
                            .rotationEffect(.degrees(180))
                    }
                }
                
            }
        }
    }
}

struct PlayersLayoutView: View {
    let players: [Player]
    var outwards: Bool = false
    
    var body: some View {
        if players.count == 3 {
            ThreePlayerLayoutView(players: players, outwards: outwards)
        } else if players.count == 4 {
            FourPlayerLayoutView(players: players, outwards: outwards)
        } else if players.count > 4 {
            FivePlayerLayoutView(players: players, outwards: outwards)
        } else {
            TwoPlayerLayoutView(players: players, outwards: outwards)
        }
    }
}

struct PlayersLayoutView_Previews: PreviewProvider {
    static let players = (0..<6).map { _ in Player() }
    
    static var previews: some View {
        ForEach(2...6, id: \.self) { num in
            ForEach([false, true], id: \.self) { outwards in
                PlayersLayoutView(
                    players: Array(players[..<num]),
                    outwards: outwards
                )
                .previewDisplayName("\(num) Players iPhone\(outwards ? " outwards" : "")")
                .previewDevice("iPhone 11 Pro Max")
                
                PlayersLayoutView(
                    players: Array(players[..<num]),
                    outwards: outwards
                )
                .previewDisplayName("\(num) Players iPad\(outwards ? " outwards" : "")")
                .previewDevice("iPad Pro (12.9-inch) (4th generation)")
            }
        }
    }
}

struct PlayerLayoutView_PreviewsMore: PreviewProvider {
    static let players = (0..<6).map { _ in Player() }
    
    static var previews: some View {
        ForEach(5...6, id: \.self) { num in
            ForEach([false, true], id: \.self) { outwards in
                PlayersLayoutView(
                    players: Array(players[..<num]),
                    outwards: outwards
                )
                .previewDisplayName("\(num) Players iPhone\(outwards ? " outwards" : "")")
                .previewDevice("iPhone 11 Pro Max")
                
                PlayersLayoutView(
                    players: Array(players[..<num]),
                    outwards: outwards
                )
                .previewDisplayName("\(num) Players iPad\(outwards ? " outwards" : "")")
                .previewDevice("iPad Pro (12.9-inch) (4th generation)")
            }
        }
    }
}
