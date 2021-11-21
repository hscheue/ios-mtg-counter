//
//  HistoryView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/18/21.
//

import SwiftUI

struct ReaderView: View {
    @Binding var binding: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            Color.clear
                .onAppear {
                    self.binding = geo.frame(in: .global).minY
                }
                .onChange(of: geo.frame(in: .global).minY) {
                    self.binding = $0
                }
        }
    }
}

struct PlayerNamesRowView: View {
    let players: [PlayerState]
    
    var body: some View {
        HStack(alignment: .top) {
            ForEach(players) { player in
                Text(player.name)
                    .font(.system(size: 26))
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
            }
        }.padding()
    }
}

struct PlayerLifeColumnView: View {
    let player: PlayerState
    let b: CGFloat
    @State var a: CGFloat = 0
    var offset: CGFloat { max(b-a, 0) }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Array(zip(player.history.indices, player.history)), id: \.0) { index, intWithId in
                if player.history.last?.id != intWithId.id {

                    HStack(alignment: .lastTextBaseline, spacing: 0) {
                        Text("\(intWithId.value)")
                            .font(.system(size: 32))
                            .foregroundColor(.gray)
                        
                        let diff = player.history[index + 1].value - intWithId.value
                        let diffColor = diff > 0 ? Color.green.opacity(0.5) : Color.red.opacity(0.5)
                        
                        Text("\(diff, specifier: "%+d")")
                            .font(.system(size: 16))
                            .foregroundColor(diffColor)
                        
                    }
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    
                } else {
                    Text("\(intWithId.value)")
                        .font(.system(size: 40))
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .offset(x: 0, y: offset)
                        .background(ReaderView(binding: $a))
                }
            }
        }.frame(maxWidth: .infinity)
    }
}

struct HistoryView: View {
    let players: [PlayerState]
    @State var b: CGFloat = 0
    
    var body: some View {
        VStack {
            PlayerNamesRowView(players: players)
            
            ScrollView(.vertical) {
                HStack(alignment: .top) {
                    ForEach(players) { player in
                        PlayerLifeColumnView(player: player, b: b)
                    }
                }
                .padding()
            }
            .background(ReaderView(binding: $b))
        }
    }
}
