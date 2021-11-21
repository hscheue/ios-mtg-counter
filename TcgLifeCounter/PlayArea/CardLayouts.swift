//
//  FivePlayerLayoutView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/26/20.
//

import SwiftUI
import CryptoKit

struct ThreePlayerLayoutView: View {
    let players: [PlayerState]
    var outwards: Bool = false
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var isVerticalStack: Bool { verticalSizeClass != .compact }
    
    var body: some View {
        if (!outwards) {
            VStack {
                NewPlayerCardView(playerState: players[0])
                NewPlayerCardView(playerState: players[1])
                NewPlayerCardView(playerState: players[2])
            }
        } else {
            GeometryReader { geo in
                let isLandscape = geo.size.width < geo.size.height
                
                VStack {
                    HStack {
                        RotationGeometryLeftView(
                            content: NewPlayerCardView(playerState: players[0])
                        )
                        RotationGeometryRightView(
                            content: NewPlayerCardView(playerState: players[1])
                        )
                    }
                    .frame(
                        width: geo.size.width,
                        height: 0.66 * geo.size.height
                    )
                    NewPlayerCardView(playerState: players[2])
                        .rotationEffect(!isLandscape ? .degrees(180) : .zero)
                }
            }
        }
    }
}

struct FourPlayerLayoutView: View {
    let players: [PlayerState]
    var outwards: Bool = false
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var vertical: Bool { verticalSizeClass != .compact && horizontalSizeClass != .regular }
    
    var body: some View {
        if (outwards) {
            HStack {
                VStack {
                    RotationGeometryLeftView(content: NewPlayerCardView(playerState: players[0]))
                    RotationGeometryLeftView(content: NewPlayerCardView(playerState: players[1]))
                }
                VStack {
                    RotationGeometryRightView(content: NewPlayerCardView(playerState: players[2]))
                    RotationGeometryRightView(content: NewPlayerCardView(playerState: players[3]))
                }
            }
        } else if (!vertical) {
            HStack {
                VStack {
                    NewPlayerCardView(playerState: players[0])
                    NewPlayerCardView(playerState: players[1])
                }
                VStack {
                    NewPlayerCardView(playerState: players[2])
                    NewPlayerCardView(playerState: players[3])
                }
            }
        } else {
            HStack {
                VStack {
                    RotationGeometryLeftView(content: NewPlayerCardView(playerState: players[0]))
                    RotationGeometryLeftView(content: NewPlayerCardView(playerState: players[1]))
                }
                VStack {
                    RotationGeometryLeftView(content: NewPlayerCardView(playerState: players[2]))
                    RotationGeometryLeftView(content: NewPlayerCardView(playerState: players[3]))
                }
            }
        }
    }
}

struct FiveSixPlayerLayoutView: View {
    let players: [PlayerState]
    var outwards: Bool = false
    let indexRanges = [0..<3, 3..<6]
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var vertical: Bool {
        verticalSizeClass != .compact
            && horizontalSizeClass != .regular
    }
    
    var body: some View {
        HStack {
            VStack {
                RotationGeometryLeftView(content: NewPlayerCardView(playerState: players[0]))
                RotationGeometryLeftView(content: NewPlayerCardView(playerState: players[1]))
                RotationGeometryLeftView(content: NewPlayerCardView(playerState: players[2]))
            }
            if (outwards) {
                VStack {
                    RotationGeometryRightView(content: NewPlayerCardView(playerState: players[3]))
                    RotationGeometryRightView(content: NewPlayerCardView(playerState: players[4]))
                    if (players.count == 6) {
                        RotationGeometryRightView(content: NewPlayerCardView(playerState: players[5]))
                    }
                }
            } else {
                VStack {
                    RotationGeometryLeftView(content: NewPlayerCardView(playerState: players[3]))
                    RotationGeometryLeftView(content: NewPlayerCardView(playerState: players[4]))
                    if (players.count == 6) {
                        RotationGeometryLeftView(content: NewPlayerCardView(playerState: players[5]))
                    }
                }
            }
        }
    }
}

struct FivePlayerLayoutView_Previews: PreviewProvider {
    static let players = (0..<6).map { i in PlayerState(i, life: 100 / (i + 1), debounce: 2.0) }
    static var previews: some View {
        FiveSixPlayerLayoutView(players: Array(players[..<5]))
        FiveSixPlayerLayoutView(players: Array(players[..<5]), outwards: true)
        FiveSixPlayerLayoutView(players: Array(players[..<6]))
        FiveSixPlayerLayoutView(players: Array(players[..<6]), outwards: true)
        FourPlayerLayoutView(players: Array(players[..<4]))
        FourPlayerLayoutView(players: Array(players[..<4]), outwards: true)
    }
}

