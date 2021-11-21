//
//  FivePlayerLayoutView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/26/20.
//

import SwiftUI

struct FourPlayerLayoutView: View {
    let players: [PlayerState]
    var outwards: Bool = false
    let indexRanges = [0..<2, 2..<4]
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var vertical: Bool {
        verticalSizeClass != .compact
            && horizontalSizeClass != .regular
    }
    
    var body: some View {
        HVStack(horizontal: vertical) {
            ForEach(0..<2, id: \.self) { indexKey in
                let rotateOrientation: Bool = indexKey == 1 && vertical || indexKey == 0 && !vertical
                let rotatePermission = outwards && rotateOrientation
                HVStack(horizontal: !vertical) {
                    ForEach(indexRanges[indexKey], id: \.self) { index in
                        PlayerCardView(player: players[index], horizontal: !vertical)
                    }
                    .rotationEffect(rotatePermission ? .degrees(180) : .zero)
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
        HVStack(horizontal: vertical) {
            ForEach(0..<2, id: \.self) { index in
                let rotateOrientation: Bool = index == 1 && vertical || index == 0 && !vertical
                let rotatePermission = outwards && rotateOrientation
                HVStack(horizontal: !vertical) {
                    ForEach(indexRanges[index], id: \.self) { indexValue in
                        if players.count > indexValue {
                            PlayerCardView(player: players[indexValue], horizontal: !vertical)
                        }
                    }
                    .rotationEffect(rotatePermission ? .degrees(180) : .zero)
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

