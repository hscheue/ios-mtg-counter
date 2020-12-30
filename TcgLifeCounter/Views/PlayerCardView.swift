//
//  PlayerCardView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI

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

struct PlayerCardView: View {
    @ObservedObject var player: Player
    var horizontal = true
    
    @State var minusOpacity = 0.0
    @State var plusOpacity = 0.0
    
    func adjustLifeByTap(by adjustment: Int) {
        player.life += adjustment
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
    
    var body: some View {
        ZStack {
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
                            .background(Color.black.opacity(minusOpacity))
                        
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
                            .background(Color.black.opacity(plusOpacity))
                        
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
            
            Text("\(player.life) Life")
                .font(.system(size: 48))
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
        
    }
}
