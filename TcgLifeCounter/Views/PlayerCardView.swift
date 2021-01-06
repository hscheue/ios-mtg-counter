//
//  PlayerCardView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI
import Combine

// can with animations go in here?
class ClickState: ObservableObject {
    var cancellable: AnyCancellable?
    @Published var value: Int = 0
    @Published var opacity = 0
    
    init() {
        cancellable = $value
            .filter { $0 != 0 }
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .sink { change in
                withAnimation { // so this does work!?
                    self.value = 0
                }
                // TODO: on debounce add to history
            }
    }
}

struct PlayerCardView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var player: Player
    var horizontal = true

    @State var changeOpacity = 0.0
    @State var changeOffset: CGFloat = 0
    @StateObject var clickState = ClickState()
    
    func adjustLifeByTap(by adjustment: Int) {
        player.life += adjustment
        changeOffset = 10
        changeOpacity = 0.0
        withAnimation {
            clickState.value += adjustment
            changeOffset = 0
            changeOpacity = 1.0
        }
    }
    
    var changeColor: Color {
        clickState.value > 0 ? Color.green : Color.red
    }
    
    var body: some View {
        return ZStack {
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
            
            VStack {
                if clickState.value != 0 {
                    Text("\(clickState.value, specifier: "%+d")")
                        .foregroundColor(changeColor)
                        .font(.system(size: 32))
                        .opacity(changeOpacity)
                        .offset(x: 0, y: changeOffset)
                }
                
                Text("\(player.life)")
                    .font(.system(size: 48))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Text("Life")
                    .font(.system(size: 16))
            }
            .rotationEffect(
                horizontal ? .zero : .degrees(90))
            .allowsHitTesting(false)
        }
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
                    .rotationEffect(horizontal ? .zero : .degrees(90))
                    .font(.system(size: 32))
                    .offset(x: horizontal ? 10 : 10, y: horizontal ? -10 : 10)
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
                    .rotationEffect(horizontal ? .zero : .degrees(90))
                    .font(.system(size: 32))
                    .offset(x: horizontal ? -10 : 10, y: horizontal ? -10 : -10)
                    .foregroundColor(.gray)
                    .allowsHitTesting(false)
            }
        }
    }
}
