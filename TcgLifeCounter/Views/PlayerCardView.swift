//
//  PlayerCardView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 12/23/20.
//

import SwiftUI

// https://www.hackingwithswift.com/quick-start/swiftui/how-to-automatically-switch-between-hstack-and-vstack-based-on-size-class

struct PlayerCardView: View {
    @ObservedObject var player: Player
    var horizontal = false
    @State var minusOpacity = 0.0
    @State var plusOpacity = 0.0
    
    func decreaseLife() {
        player.life -= 1
        minusOpacity = 0.2
        withAnimation {
            minusOpacity = 0.0
        }
    }
    
    func increaseLife() {
        player.life += 1
        plusOpacity = 1.0
        withAnimation {
            plusOpacity = 0.0
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 1))
            
            if horizontal {
                VStack(spacing: 0) {
                    Button(action: decreaseLife) {
                        ZStack(alignment: .topLeading) {
                            Text("Decrease life for player \(player.name)")
                                .hidden()
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity)
                                .background(Color.black.opacity(minusOpacity))
                            
                            Text("-1")
                                .rotationEffect(.degrees(90))
                                .font(.system(size: 32))
                                .offset(x: 10, y: 10)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Button(action: increaseLife) {
                        ZStack(alignment: .bottomLeading) {
                            Text("Increase life for player \(player.name)")
                                .hidden()
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity)
                                .background(Color.black.opacity(plusOpacity))
                            
                            Text("+1")
                                .rotationEffect(.degrees(90))
                                .font(.system(size: 32))
                                .offset(x: 10, y: -10)
                                .foregroundColor(.gray)
                        }
                    }
                }
            } else {
                HStack(spacing: 0) {
                    Button(action: decreaseLife) {
                        ZStack(alignment: .bottomLeading) {
                            Text("Decrease life for player \(player.name)")
                                .hidden()
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity)
                                .background(Color.black.opacity(minusOpacity))
                            
                            Text("-1")
                                .font(.system(size: 32))
                                .offset(x: 10, y: -10)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Button(action: increaseLife) {
                        ZStack(alignment: .bottomTrailing) {
                            Text("Increase life for player \(player.name)")
                                .hidden()
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity)
                                .background(Color.black.opacity(plusOpacity))
                            
                            Text("+1")
                                .font(.system(size: 32))
                                .offset(x: -10, y: -10)
                                .foregroundColor(.gray)
                        }

                    }
                    
                }
            }
            
            
            Text("\(player.life) Life")
                .font(.system(size: 48))
                .rotationEffect(horizontal ? .degrees(90) : .degrees(0))
                .allowsHitTesting(false)
        }
    }
}

struct PlayerCardView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCardView(player: Player(), horizontal: false)
    }
}
