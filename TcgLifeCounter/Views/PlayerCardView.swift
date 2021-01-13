//
//  PlayerCardView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI
import Combine

class ClickState: ObservableObject {
    var cancellable: AnyCancellable?
    
    @Published var value: Int = 0
    
    init() {
        cancellable = $value
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .sink { change in withAnimation { self.value = 0 } }
    }
}

struct PlayerCardView: View {
    // MARK: Initialized
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var clickState = ClickState()
    
    // MARK: Constructed
    @ObservedObject var player: Player
    var horizontal = true
    
    // MARK: View Body
    var body: some View {
        ZStack {
            Rectangle().fill(fillColor)
            
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
            
            PresentedLifeView(
                changeLife: clickState.value,
                currentLife: player.life,
                horizontal: horizontal
            )
        }
        .clipShape(RoundedRectangle(cornerRadius: 42.0, style: .continuous))
        .shadow(color: shadowColor, radius: 7, x: 2.0, y: 2.0)
        .padding(4)
    }
    
    // MARK: Computed
    var fillColor: Color {
        colorScheme == .light ? Color.white : Color.black
    }
    var shadowColor: Color {
        colorScheme == .light ? Color.gray.opacity(0.4) : Color.black
    }
    
    // MARK: Functions
    func adjustLifeByTap(by adjustment: Int) {
        player.life += adjustment
        withAnimation { clickState.value += adjustment }
    }
}



struct ButtonView: View {
    @ObservedObject var player: Player
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
                Text("Decrease life for player \(player.name)")
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
    @ObservedObject var player: Player
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
            ZStack(alignment: horizontal ? .bottomTrailing : .bottomLeading) {
                Text("Increase life for player \(player.name)")
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
        .contentShape(HalfRoundedRect(horizontal ? .right : .bottom))
    }
}

struct PlayerCardView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCardView(player: Player(), horizontal: true)
            .previewDisplayName("Horizontal Display")
        PlayerCardView(player: Player(), horizontal: false)
            .previewDisplayName("Vertical Display")
        PlayerCardView(player: Player(), horizontal: true)
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
    }
}
