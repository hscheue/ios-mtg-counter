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
    @ObservedObject var player: Player
    var horizontal = true

    @StateObject private var clickState = ClickState()
    
    func adjustLifeByTap(by adjustment: Int) {
        player.life += adjustment
        withAnimation { clickState.value += adjustment }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 1))
            
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
                    .offset(x: 10,y: -10)
                    .rotationEffect(horizontal ? .zero : .degrees(90))
                    .foregroundColor(.gray)
                    .allowsHitTesting(false)
            }
        }
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
                    .offset(x: -10, y: -10)
                    .rotationEffect(horizontal ? .zero : .degrees(90))
                    .font(.system(size: 32))
                    .foregroundColor(.gray)
                    .allowsHitTesting(false)
            }
        }
    }
}

struct PresentedLifeView: View {
    let changeLife: Int
    let currentLife: Int
    let horizontal: Bool
    
    private var changeColor: Color {
        changeLife > 0 ? Color.green : Color.red
    }
    @State private var changeOpacity: Double = 0
    @State private var changeOffset: CGFloat = 10

    var body: some View {
        VStack {
            if changeLife != 0 {
                Text("\(changeLife, specifier: "%+d")")
                    .foregroundColor(changeColor)
                    .font(.system(size: 32))
                    .opacity(changeOpacity)
                    .offset(x: 0, y: changeOffset)
            }
            
            Text("\(currentLife)")
                .font(.system(size: 48))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text("Life")
                .font(.system(size: 16))
        }
        .onChange(of: changeLife) { _ in
            changeOpacity = 0
            changeOffset = 10
            withAnimation {
                changeOpacity = 1
                changeOffset = 0
            }
        }
        .rotationEffect(horizontal ? .zero : .degrees(90))
        .allowsHitTesting(false)
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
