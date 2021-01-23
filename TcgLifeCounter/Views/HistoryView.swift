//
//  HistoryView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/18/21.
//

import SwiftUI

struct HistoryView: View {
    let players: [PlayerState]
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                ForEach(players) { player in
                    Text(player.name)
                        .font(.system(size: 26))
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            
            ScrollView(.vertical) {
                ZStack(alignment: .top) {
                    HStack(alignment: .top) {
                        ForEach(players) { player in
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
                                            .offset(x: 0, y: 0)
                                            
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.1)
                                    }
                                }
                            }.frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                }
                
            }
        }
    }
}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(players: [
            PlayerState(0, life: 100, history: [99,88,77,66,55,44,33,22,11,9,8,7,6,5,4,4,3,2,1], debounce: 2.0),
            PlayerState(1, life: 100, history: [99,88,77,66,55,44,33,22,11], debounce: 2.0),
//            PlayerState(2, life: 100, history: [99,88,77]),
//            PlayerState(3, life: 100),
//            PlayerState(4, life: 100),
//            PlayerState(5, life: 100),
        ])
        
        HistoryView(players: [
            PlayerState(0, life: 100, history: [99,88,77,66,55,44,33,22,11,9,8,7,6,5,4,4,3,2,1], debounce: 2.0),
            PlayerState(1, life: 100, history: [99,88,77,66,55,44,33,22,11], debounce: 2.0),
            PlayerState(2, life: 100, history: [99,88,77], debounce: 2.0),
            PlayerState(3, life: 100, debounce: 2.0),
        ])
        .preferredColorScheme(.dark)
    }
}
