//
//  PlayerCardView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI
import Combine

struct PlayerCardView: View {
    // MARK: Initialized
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: Constructed
    @ObservedObject var player: PlayerState
    var horizontal = true
    
    // MARK: View Body
    var body: some View {
        ZStack {
            Rectangle()
                .fill(fillColor)
            
            Rectangle()
                .fill(opacityGradientHorizontal)
            
            Rectangle()
                .fill(opacityGradientVertical)
            
            HVStack(horizontal: horizontal) {
                ButtonView(
                    player: player,
                    horizontal: horizontal,
                    clickAction: { adjustLifeByTap(by: -1) }
                )
                ButtonAddView(
                    player: player,
                    horizontal: horizontal,
                    clickAction: { adjustLifeByTap(by: 1) }
                )
            }
            
            CommitChangeStateView(
                playerState: player,
                horizontal: horizontal
            )
        }
        .clipShape(RoundedRectangle(cornerRadius: 42.0, style: .continuous))
        .shadow(color: shadowColor, radius: 7, x: 2.0, y: 2.0)
        .padding(4)
    }
    
    // MARK: Computed
    var gradient: Gradient {
        let base = colorScheme == .dark
            ? Color.white
            : Color.black
        
        return .init(stops: [
            Gradient.Stop(color: base.opacity(0.05), location: 0.05),
            Gradient.Stop(color: base.opacity(0.01), location: 0.1),
            Gradient.Stop(color: base.opacity(0), location: 0.3),
            Gradient.Stop(color: base.opacity(0), location: 0.7),
            Gradient.Stop(color: base.opacity(0.01), location: 0.9),
            Gradient.Stop(color: base.opacity(0.05), location: 0.95),
        ])
    }
    var opacityGradientHorizontal: LinearGradient {
        .init(gradient: gradient, startPoint: .leading, endPoint: .trailing)
    }
    var opacityGradientVertical: LinearGradient {
        .init(gradient: gradient, startPoint: .top, endPoint: .bottom)
    }
    var fillColor: Color {
        colorScheme == .light ? Color.white : Color(white: 0.1)
    }
    var shadowColor: Color {
        colorScheme == .light ? Color.gray.opacity(0.4) : Color.black
    }
    
    // MARK: Functions
    func adjustLifeByTap(by adjustment: Int) {
        player.inc(by: adjustment)
    }
}

struct ButtonView: View {
    @ObservedObject var player: PlayerState
    let horizontal: Bool
    let clickAction: () -> Void
    
    @Environment(\.colorScheme) private var colorScheme
    @State private var opacity: Double = 0
    
    func handleClick() {
        clickAction()
        opacity = 0.2
        withAnimation {
            opacity = 0
        }
    }
    
    var body: some View {
        let backgroundColor = colorScheme == ColorScheme.dark
            ? Color.white
            : Color.black
        
        Button(action: handleClick) {
            ZStack(alignment: horizontal ? .bottomLeading: .topLeading) {
                Text("Decrease life")
                    .hidden()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(backgroundColor.opacity(opacity))
                
                Text("-1")
                    .font(.system(size: 32))
                    .offset(x: 30,y: -15)
                    .rotationEffect(horizontal ? .zero : .degrees(90))
                    .foregroundColor(.gray)
                    .allowsHitTesting(false)
            }
        }
        .contentShape(HalfRoundedRect(horizontal ? .left : .top))
    }
}

struct ButtonAddView: View {
    @ObservedObject var player: PlayerState
    let horizontal: Bool
    let clickAction: () -> Void
    
    @Environment(\.colorScheme) private var colorScheme
    @State private var opacity: Double = 0
    
    func handleClick() {
        clickAction()
        opacity = 0.2
        withAnimation {
            opacity = 0
        }
    }
    
    var body: some View {
        let backgroundColor = colorScheme == ColorScheme.dark
            ? Color.white
            : Color.black
        
        Button(action: handleClick) {
            ZStack {
                ZStack(alignment: horizontal
                        ? .topTrailing : .bottomTrailing) {
                    Text(player.name)
                        .offset(x: -15, y: 15)
                        .rotationEffect(horizontal ? .zero : .degrees(90), anchor: UnitPoint(x: 1, y: 1))
                        .offset(x: !horizontal ? -15: 0)
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .allowsHitTesting(false)
                    
                    Text("Increase life")
                        .hidden()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(backgroundColor.opacity(opacity))
                    
                }
                ZStack(alignment: horizontal
                        ? .bottomTrailing : .bottomLeading) {
                    
                    Text("Increase life")
                        .hidden()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(backgroundColor.opacity(opacity))
                    
                    Text("+1")
                        .offset(x: -30, y: -15)
                        .rotationEffect(horizontal ? .zero : .degrees(90))
                        .font(.system(size: 32))
                        .foregroundColor(.gray)
                        .allowsHitTesting(false)
                }
            }
        }
        .contentShape(HalfRoundedRect(horizontal ? .right : .bottom))
    }
}

struct PlayerCardView_Previews: PreviewProvider {
    
    static let players = (0..<2).map { _ in PlayerState() }
    
    static var previews: some View {
        PlayersLayoutView(
            players: Array(players[..<2]),
            outwards: false
        )
        PlayersLayoutView(
            players: Array(players[..<2]),
            outwards: false
        ).preferredColorScheme(.dark)
        PlayerCardView(player: PlayerState(), horizontal: true)
            .previewDisplayName("Horizontal Display")
        PlayerCardView(player: PlayerState(), horizontal: false)
            .previewDisplayName("Vertical Display")
        PlayerCardView(player: PlayerState(), horizontal: true)
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
    }
}
