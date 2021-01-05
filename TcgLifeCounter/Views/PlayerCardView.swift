//
//  PlayerCardView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI
import Combine

// https://www.hackingwithswift.com/quick-start/swiftui/how-to-automatically-switch-between-hstack-and-vstack-based-on-size-class

struct HVStack<Content>: View where Content : View {
    let horizontal: Bool
    let alignment: Alignment
    var content: () -> Content
    
    var body: some View {
        if horizontal {
            HStack(
                alignment: alignment.vertical,
                spacing: 0,
                content: content)
        } else {
            VStack(
                alignment: alignment.horizontal,
                spacing: 0,
                content: content)
        }
    }
    
    init(
        horizontal: Bool = true,
        alignment: Alignment = .center,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.horizontal = horizontal
        self.alignment = alignment
        self.content = content
    }
}

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
    
    @State var minusOpacity = 0.0
    @State var plusOpacity = 0.0
    @State var changeOpacity = 0.0
    @State var changeOffset: CGFloat = 0
    @StateObject var clickState = ClickState()
    
    func adjustLifeByTap(by adjustment: Int) {
        player.life += adjustment
        withAnimation {
            clickState.value += adjustment
        }
        
        changeOffset = 10
        withAnimation {
            changeOffset = 0
        }
        
        changeOpacity = 0.0
        withAnimation {
            changeOpacity = 1.0
        }
        
        if adjustment < 0 {
            minusOpacity = 0.2
            withAnimation {
                minusOpacity = 0.0
            }
        } else {
            plusOpacity = 0.2
            withAnimation {
                plusOpacity = 0.0
            }
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
                
                Button(action: { adjustLifeByTap(by: -1) }) {
                    ZStack(alignment: horizontal
                            ? .bottomLeading: .topLeading
                    ) {
                        Text("Decrease life for player \(player.name)")
                            .hidden()
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: .infinity)
                            .background(
                                (colorScheme == ColorScheme.dark
                                    ? Color.white
                                    : Color.black)
                                    .opacity(minusOpacity))
                        
                        Text("-1")
                            .rotationEffect(
                                horizontal ? .zero : .degrees(90))
                            .font(.system(size: 32))
                            .offset(
                                x: horizontal ? 10 : 10,
                                y: horizontal ? -10 : 10)
                            .foregroundColor(.gray)
                            .allowsHitTesting(false)
                        
                    }
                }
                
                
                Button(action: { adjustLifeByTap(by: 1) }) {
                    ZStack(
                        alignment: horizontal ? .bottomTrailing : .bottomLeading
                    ) {
                        Text("Increase life for player \(player.name)")
                            .hidden()
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: .infinity)
                            .background((colorScheme == ColorScheme.dark
                                            ? Color.white
                                            : Color.black)
                                            .opacity(plusOpacity))
                        
                        Text("+1")
                            .rotationEffect(
                                horizontal ? .zero : .degrees(90)
                            )
                            .font(.system(size: 32))
                            .offset(
                                x: horizontal ? -10 : 10,
                                y: horizontal ? -10 : -10
                            )
                            .foregroundColor(.gray)
                            .allowsHitTesting(false)
                    }
                }
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
